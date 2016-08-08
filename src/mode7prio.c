#include "snes9x.h"
#include "memmap.h"
#include "ppu.h"
#include "cpuexec.h"
#include "display.h"
#include "gfx.h"
#include "apu.h"

extern SLineData LineData[240];
extern SLineMatrixData LineMatrixData [240];
extern uint8  Mode7Depths [2];

#define M7 19

/*
void DrawBGMode7Background16Prio (uint8 *Screen, int bg)
{
    RENDER_BACKGROUND_MODE7PRIO (GFX.ScreenColors [b & 0x7f]);
}
*/


#ifdef __DEBUG__

#define DMSG(rop) printf("Rendering Mode7 w/prio, ROp: " rop ", R:%d, r2130: %d, bg: %d\n", PPU.Mode7Repeat, GFX.r2130 & 1, bg)
#else
#define DMSG(rop)
#endif

void DrawBGMode7Background16PrioR0(uint8* Screen, int bg);
void DrawBGMode7Background16PrioR1R2(uint8* Screen, int bg);
void DrawBGMode7Background16PrioR3(uint8* Screen, int bg);

void DrawBGMode7Background16Prio(uint8* Screen, int bg)
{
   DMSG("opaque");

   if (GFX.r2130 & 1)
   {
      if (IPPU.DirectColourMapsNeedRebuild) S9xBuildDirectColourMaps();
      GFX.ScreenColors = DirectColourMaps [0];
   }
   else  GFX.ScreenColors = IPPU.ScreenColors;

   switch (PPU.Mode7Repeat)
   {
   case 0:
      DrawBGMode7Background16PrioR0(Screen, bg);
      return;
   case 3:
      DrawBGMode7Background16PrioR3(Screen, bg);
      return;
   default:
      DrawBGMode7Background16PrioR1R2(Screen, bg);
      return;
   }
}

#define M7C 0x1fff

void DrawBGMode7Background16PrioR3(uint8* Screen, int bg)
{
   int aa, cc;
   int startx;
   uint32 Left = 0;
   uint32 Right = 256;
   uint32 ClipCount = GFX.pCurrentClip->Count [0];

   int32 HOffset;
   int32 VOffset;
   int32 CentreX;
   int32 CentreY;
   uint8* d;
   uint16* p;
   int dir;
   int yy;
   int xx;
   int BB;
   int DD;
   uint32 Line;
   uint32 clip;
   uint8* Depth;
   uint32 depth = Mode7Depths[0] | (Mode7Depths[1] << 8);

   if (!ClipCount) ClipCount = 1;

   Screen += GFX.StartY * GFX_PITCH;
   Depth = GFX.DB + GFX.StartY * GFX_PPL;
   SLineMatrixData* l = &LineMatrixData [GFX.StartY];

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, Depth += GFX_PPL, l++)
   {
      HOffset = ((int32) LineData[Line].BG[0].HOffset << M7) >> M7;
      VOffset = ((int32) LineData[Line].BG[0].VOffset << M7) >> M7;

      CentreX = ((int32) l->CentreX << M7) >> M7;
      CentreY = ((int32) l->CentreY << M7) >> M7;

      if (PPU.Mode7VFlip) yy = 255 - (int) Line;
      else yy = Line;

      yy += VOffset - CentreY;
      xx = HOffset - CentreX;

      BB = l->MatrixB * yy + (CentreX << 8);
      DD = l->MatrixD * yy + (CentreY << 8);

      for (clip = 0; clip < ClipCount; clip++)
      {
         if (GFX.pCurrentClip->Count [0])
         {
            Left = GFX.pCurrentClip->Left [clip][0];
            Right = GFX.pCurrentClip->Right [clip][0];
            if (Right <= Left) continue;
         }
         p = (uint16*) Screen + Left;
         d = Depth + Left;

         if (PPU.Mode7HFlip)
         {
            startx = Right - 1;
            aa = -l->MatrixA;
            cc = -l->MatrixC;
            dir = -1;
         }
         else
         {
            startx = Left;
            aa = l->MatrixA;
            cc = l->MatrixC;
            dir = 1;
         }

         if (dir == 1)
         {
            __asm__ volatile(
               "1:						\n"
               "	mov	r3, %[AA], lsr #18		\n"
               "	orrs	r3, r3, %[CC], lsr #18		\n"
               "	bne	2f				\n"
               "						\n"
               "	mov	r3, %[CC], lsr #11		\n"
               "	mov	r1, %[AA], lsr #11		\n"
               "	add	r3, r1, r3, lsl #7		\n"
               "	mov	r3, r3, lsl #1			\n"
               "	ldrb	r3, [%[VRAM], r3]		\n"
               "						\n"
               "	mov	r1, %[CC], lsr #8		\n"
               "	mov	r0, %[AA], lsr #8		\n"
               "						\n"
               "	add	r3, %[VRAM], r3, lsl #7		\n"
               "						\n"
               "	and	r1, r1, #7			\n"
               "	and	r0, r0, #7			\n"
               "	add	r3, r3, r1, lsl #4 		\n"
               "	add	r3, r3, r0, lsl #1 		\n"
               "						\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	ldrb	r3, [%[d]]			\n"
               "	tst	r0, #0x80			\n"
               "	andeq	r1, %[depth], #0xff		\n"
               "	mov	r1, %[depth], lsr #8		\n"
               "	cmp	r1, r3				\n"
               "	bls	4f				\n"

               "	ldr	r1, %[daa]			\n"
               "	movs	r0, r0, lsl #2			\n"
               "	add	%[AA], %[AA], r1		\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #1		\n"
               "	strneb	%[depth], [%[d]]		\n"
               "	ldr	r0, %[dcc]			\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], r0		\n"
               "	add	%[d], %[d], #1			\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "	b	3f				\n"
               "2:						\n"
               "	and	r1, %[yy3], #7			\n"
               "	and	r0, %[xx3], #7			\n"
               "	mov	r3, r1, lsl #4 			\n"
               "	add	r3, r3, r0, lsl #1 		\n"
               "						\n"
               "	add	r3, %[VRAM], r3			\n"

               "	ldrb	r0, [r3, #1]			\n"
               "	ldrb	r3, [%[d]]			\n"
               "	tst	r0, #0x80			\n"
               "	andeq	r1, %[depth], #0xff		\n"
               "	mov	r1, %[depth], lsr #8		\n"
               "	cmp	r1, r3				\n"
               "	bls	4f				\n"

               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	strneb	%[depth], [%[d]]		\n"
               "	strneh	r1, [%[p]]			\n"
               "4:						\n"
               "	ldr	r0, %[daa]			\n"
               "	ldr	r1, %[dcc]			\n"
               "	add	%[xx3], %[xx3], #1		\n"
               "	add	%[AA], %[AA], r0		\n"
               "	add	%[CC], %[CC], r1		\n"
               "	add	%[p], %[p], #2			\n"
               "	add	%[d], %[d], #1			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "3:						\n"
               :
               : [x] "r"(Right - Left),
               [AA] "r"(l->MatrixA * (startx + xx) + BB),
               [CC] "r"(l->MatrixC * (startx + xx) + DD),
               [daa] "m"(aa),
               [dcc] "m"(cc),
               [VRAM] "r"(Memory.VRAM),
               [colors] "r"(GFX.ScreenColors),
               [p] "r"(p),
               [d] "r"(d),
               [depth] "r"(depth),
               //[dir] "r" (dir),
               [yy3] "r"(yy + CentreY),
               [xx3] "r"(startx + HOffset)
               : "r0", "r1", "r3", "cc"
            );
         }
         else
         {
            __asm__ volatile(
               "1:						\n"
               "	mov	r3, %[AA], lsr #18		\n"
               "	orrs	r3, r3, %[CC], lsr #18		\n"
               "	bne	2f				\n"
               "						\n"
               "	mov	r3, %[CC], lsr #11		\n"
               "	mov	r1, %[AA], lsr #11		\n"
               "	add	r3, r1, r3, lsl #7		\n"
               "	mov	r3, r3, lsl #1			\n"
               "	ldrb	r3, [%[VRAM], r3]		\n"
               "						\n"
               "	mov	r1, %[CC], lsr #8		\n"
               "	mov	r0, %[AA], lsr #8		\n"
               "						\n"
               "	add	r3, %[VRAM], r3, lsl #7		\n"
               "						\n"
               "	and	r1, r1, #7			\n"
               "	and	r0, r0, #7			\n"
               "	add	r3, r3, r1, lsl #4 		\n"
               "	add	r3, r3, r0, lsl #1 		\n"
               "						\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	ldrb	r3, [%[d]]			\n"
               "	tst	r0, #0x80			\n"
               "	andeq	r1, %[depth], #0xff		\n"
               "	mov	r1, %[depth], lsr #8		\n"
               "	cmp	r1, r3				\n"
               "	bls	4f				\n"

               "	ldr	r1, %[daa]			\n"
               "	movs	r0, r0, lsl #2			\n"
               "	add	%[AA], %[AA], r1		\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #-1		\n"
               "	strneb	%[depth], [%[d]]		\n"
               "	ldr	r0, %[dcc]			\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], r0		\n"
               "	add	%[d], %[d], #1			\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "	b	3f				\n"
               "2:						\n"
               "	and	r1, %[yy3], #7			\n"
               "	and	r0, %[xx3], #7			\n"
               "	mov	r3, r1, lsl #4 			\n"
               "	add	r3, r3, r0, lsl #1 		\n"
               "						\n"
               "	add	r3, %[VRAM], r3			\n"

               "	ldrb	r0, [r3, #1]			\n"
               "	ldrb	r3, [%[d]]			\n"
               "	tst	r0, #0x80			\n"
               "	andeq	r1, %[depth], #0xff		\n"
               "	mov	r1, %[depth], lsr #8		\n"
               "	cmp	r1, r3				\n"
               "	bls	4f				\n"

               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	strneb	%[depth], [%[d]]		\n"
               "	strneh	r1, [%[p]]			\n"
               "4:						\n"
               "	ldr	r0, %[daa]			\n"
               "	ldr	r1, %[dcc]			\n"
               "	add	%[xx3], %[xx3], #-1		\n"
               "	add	%[AA], %[AA], r0		\n"
               "	add	%[CC], %[CC], r1		\n"
               "	add	%[p], %[p], #2			\n"
               "	add	%[d], %[d], #1			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "3:						\n"
               :
               : [x] "r"(Right - Left),
               [AA] "r"(l->MatrixA * (startx + xx) + BB),
               [CC] "r"(l->MatrixC * (startx + xx) + DD),
               [daa] "m"(aa),
               [dcc] "m"(cc),
               [VRAM] "r"(Memory.VRAM),
               [colors] "r"(GFX.ScreenColors),
               [p] "r"(p),
               [d] "r"(d),
               [depth] "r"(depth),
               //[dir] "r" (dir),
               [yy3] "r"(yy + CentreY),
               [xx3] "r"(startx + HOffset)
               : "r0", "r1", "r3", "cc"
            );
         }
      }
   }

}

void DrawBGMode7Background16PrioR1R2(uint8* Screen, int bg)
{

   int aa, cc;
   int startx;
   uint32 Left = 0;
   uint32 Right = 256;
   uint32 ClipCount = GFX.pCurrentClip->Count [0];

   int32 HOffset;
   int32 VOffset;
   int32 CentreX;
   int32 CentreY;
   uint8* d;
   uint16* p;
   int yy;
   int xx;
   int BB;
   int DD;
   uint32 Line;
   uint32 clip;
   uint32 AndByY;
   uint32 AndByX = 0xffffffff;
   if (Settings.Dezaemon && PPU.Mode7Repeat == 2) AndByX = 0x7ff;
   AndByY = AndByX << 4;
   AndByX = AndByX << 1;
   uint8* Depth;
   uint32 depth = Mode7Depths[0] | (Mode7Depths[1] << 8);

   if (!ClipCount) ClipCount = 1;

   Screen += GFX.StartY * GFX_PITCH;
   Depth = GFX.DB + GFX.StartY * GFX_PPL;

   SLineMatrixData* l = &LineMatrixData [GFX.StartY];

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, Depth += GFX_PPL, l++)
   {
      HOffset = ((int32) LineData[Line].BG[0].HOffset << M7) >> M7;
      VOffset = ((int32) LineData[Line].BG[0].VOffset << M7) >> M7;

      CentreX = ((int32) l->CentreX << M7) >> M7;
      CentreY = ((int32) l->CentreY << M7) >> M7;

      if (PPU.Mode7VFlip) yy = 255 - (int) Line;
      else yy = Line;

      yy += VOffset - CentreY;
      xx = HOffset - CentreX;

      BB = l->MatrixB * yy + (CentreX << 8);
      DD = l->MatrixD * yy + (CentreY << 8);

      for (clip = 0; clip < ClipCount; clip++)
      {
         if (GFX.pCurrentClip->Count [0])
         {
            Left = GFX.pCurrentClip->Left [clip][0];
            Right = GFX.pCurrentClip->Right [clip][0];
            if (Right <= Left) continue;
         }
         p = (uint16*) Screen + Left;
         d = Depth + Left;

         if (PPU.Mode7HFlip)
         {
            startx = Right - 1;
            aa = -l->MatrixA;
            cc = -l->MatrixC;
         }
         else
         {
            startx = Left;
            aa = l->MatrixA;
            cc = l->MatrixC;
         }
         __asm__ volatile(
            "1:						\n"
            "	mov	r3, %[AA], lsr #18		\n"
            "	orrs	r3, r3, %[CC], lsr #18		\n"
            "	bne	2f				\n"
            "						\n"
            "	ldr	r1, %[AndByY]			\n"
            "	ldr	r0, %[AndByX]			\n"
            "	and	r1, r1, %[CC], lsr #4		\n"
            "	and	r0, r0, %[AA], lsr #7	\n"
            "						\n"
            "	and	r3, r1, #0x7f			\n"
            "	sub	r3, r1, r3			\n"
            "	add	r3, r3, r0, lsr #4		\n"
            "	add	r3, r3, r3			\n"
            "	ldrb	r3, [%[VRAM], r3]		\n"
            "	and	r1, r1, #0x70			\n"
            "						\n"
            "	add	r3, %[VRAM], r3, lsl #7		\n"
            "						\n"
            "	and	r0, r0, #14			\n"
            "	add	r3, r3, r1			\n"
            "	add	r3, r3, r0			\n"
            "						\n"
            "	ldrb	r0, [r3, #1]			\n"
            "	ldrb	r3, [%[d]]			\n"
            "	tst	r0, #0x80			\n"
            "	andeq	r1, %[depth], #0xff		\n"
            "	mov	r1, %[depth], lsr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	2f				\n"

            "	add	%[AA], %[AA], %[daa]		\n"
            "	movs	r0, r0, lsl #2			\n"
            "	ldrne	r1, [%[colors], r0]		\n"
            "	strneb	%[depth], [%[d]]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	strneh	r1, [%[p]]			\n"
            "	add	%[p], %[p], #2			\n"
            "	add	%[d], %[d], #1			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            "	b	3f				\n"
            "2:						\n"
            "	add	%[AA], %[AA], %[daa]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
            "	add	%[d], %[d], #1			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            "3:						\n"
            :
            : [x] "r"(Right - Left),
            [AA] "r"(l->MatrixA * (startx + xx) + BB),
            [CC] "r"(l->MatrixC * (startx + xx) + DD),
            [daa] "r"(aa),
            [dcc] "r"(cc),
            [VRAM] "r"(Memory.VRAM),
            [colors] "r"(GFX.ScreenColors),
            [p] "r"(p),
            [d] "r"(d),
            [depth] "r"(depth),
            [AndByX] "m"(AndByX),
            [AndByY] "m"(AndByY)
            : "r0", "r1", "r3", "cc"
         );
      }
   }
}


void DrawBGMode7Background16PrioR0(uint8* Screen, int bg)
{
   int aa, cc;
   int startx;
   uint32 Left;
   uint32 Right;
   uint32 ClipCount = GFX.pCurrentClip->Count [0];

   int32 HOffset;
   int32 VOffset;
   int32 CentreX;
   int32 CentreY;
   uint16* p;
   uint8* d;
   int yy;
   int xx;
   int BB;
   int DD;
   uint32 Line;
   uint32 clip;
   SLineMatrixData* l;
   uint8* Depth;
   uint32 depth = Mode7Depths[0] | (Mode7Depths[1] << 8);

   Left = 0;
   Right = 256;


   if (!ClipCount) ClipCount = 1;


   l = &LineMatrixData [GFX.StartY];
   Screen  += GFX.StartY * GFX_PITCH;
   Depth = GFX.DB + GFX.StartY * GFX_PPL;

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, Depth += GFX_PPL, l++)
   {
      HOffset = ((int32) LineData[Line].BG[0].HOffset << M7) >> M7;
      VOffset = ((int32) LineData[Line].BG[0].VOffset << M7) >> M7;

      CentreX = ((int32) l->CentreX << M7) >> M7;
      CentreY = ((int32) l->CentreY << M7) >> M7;

      if (PPU.Mode7VFlip) yy = 255 - (int) Line;
      else yy = Line;

      yy += (VOffset - CentreY) % 1023;
      xx = (HOffset - CentreX) % 1023;

      BB = l->MatrixB * yy + (CentreX << 8);
      DD = l->MatrixD * yy + (CentreY << 8);

      for (clip = 0; clip < ClipCount; clip++)
      {
         if (GFX.pCurrentClip->Count [0])
         {
            Left = GFX.pCurrentClip->Left [clip][0];
            Right = GFX.pCurrentClip->Right [clip][0];
            if (Right <= Left) continue;
         }

         p = (uint16*) Screen + Left;
         d = Depth + Left;

         if (PPU.Mode7HFlip)
         {
            startx = Right - 1;
            aa = -l->MatrixA;
            cc = -l->MatrixC;
         }
         else
         {
            startx = Left;
            aa = l->MatrixA;
            cc = l->MatrixC;
         }
         __asm__ volatile(
            "	b	1f				\n"
            "7:						\n" // AndByX
            "	.word	(0x3ff << 1)                    \n"
            "8:						\n" // AndByY
            "	.word	(0x3ff << 4)                    \n"
            "						\n"
            "1:						\n"
            "	ldr	r3, 8b				\n"
            "	ldr	r0, 7b				\n"
            "	and	r1, r3, %[CC], lsr #4		\n"
            "	and	r3, r1, #0x7f			\n"
            "	and	r0, r0, %[AA], lsr #7		\n"
            "	sub	r3, r1, r3			\n"
            "	add	r3, r3, r0, lsr #4		\n"
            "	add	r3, r3, r3			\n"
            "	ldrb	r3, [%[VRAM], r3]		\n"
            "						\n"
            "	and	r1, r1, #0x70			\n"
            "	add	r3, %[VRAM], r3, lsl #7		\n"
            "						\n"
            "	and	r0, r0, #14			\n"
            "	add	r3, r3, r1			\n"
            "	add	r3, r3, r0			\n"
            "						\n"
            "	ldrb	r0, [r3, #1]			\n"
            "	ldrb	r3, [%[d]]			\n"
            "	tst	r0, #0x80			\n"
            "	andeq	r1, %[depth], #0xff		\n"
            "	mov	r1, %[depth], lsr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	2f				\n"

            "	movs	r0, r0, lsl #2			\n"
            "	ldrne	r1, [%[colors], r0]		\n"
            "	strneb	%[depth], [%[d]]		\n"
            "	strneh	r1, [%[p]]			\n"
            "						\n"
            "2:						\n"
            "	add	%[AA], %[AA], %[daa]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
            "	add	%[d], %[d], #1			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            :
            : [x] "r"(Right - Left),
            [AA] "r"(l->MatrixA * (startx + xx) + BB),
            [CC] "r"(l->MatrixC * (startx + xx) + DD),
            [daa] "r"(aa),
            [dcc] "r"(cc),
            [VRAM] "r"(Memory.VRAM),
            [colors] "r"(GFX.ScreenColors),
            [p] "r"(p),
            [d] "r"(d),
            [depth] "r"(depth)
            : "r0", "r1", "r3", "cc"
         );

      }
   }

}


