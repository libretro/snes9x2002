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

#ifdef __DEBUG__

#define DMSG(rop) printf("Rendering Mode7, ROp: " rop ", R:%d, r2130: %d\n", PPU.Mode7Repeat, GFX.r2130 & 1)
#else
#define DMSG(rop)
#endif

void DrawBGMode7Background16NewR0(uint8* Screen);
void DrawBGMode7Background16NewR1R2(uint8* Screen);
void DrawBGMode7Background16NewR3(uint8* Screen);

void DrawBGMode7Background16New(uint8* Screen)
{
   DMSG("totally opaque");
   if (GFX.r2130 & 1)
   {
      if (IPPU.DirectColourMapsNeedRebuild) S9xBuildDirectColourMaps();
      GFX.ScreenColors = DirectColourMaps [0];
   }
   else  GFX.ScreenColors = IPPU.ScreenColors;

   switch (PPU.Mode7Repeat)
   {
   case 0:
      DrawBGMode7Background16NewR0(Screen);
      return;
   case 3:
      DrawBGMode7Background16NewR3(Screen);
      return;
   default:
      DrawBGMode7Background16NewR1R2(Screen);
      return;
   }
}

#define M7C 0x1fff

void DrawBGMode7Background16NewR3(uint8* Screen)
{
   int aa, cc;
   int startx;
   uint32 Left = 0;
   uint32 Right = 256;
   uint32 ClipCount = GFX.pCurrentClip->Count [0];

   int HOffset;
   int VOffset;
   int CentreX;
   int CentreY;
   uint16* p;
   int dir;
   int yy;
   int xx;
   int yy3;
   int xx3;
   int BB;
   int DD;
   int Line;
   uint32 clip;

   if (!ClipCount) ClipCount = 1;

   Screen += GFX.StartY * GFX_PITCH;
   SLineMatrixData* l = &LineMatrixData [GFX.StartY];

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, l++)
   {
      HOffset = ((int32) LineData[Line].BG[0].HOffset << M7) >> M7;
      VOffset = ((int32) LineData[Line].BG[0].VOffset << M7) >> M7;

      CentreX = ((int32) l->CentreX << M7) >> M7;
      CentreY = ((int32) l->CentreY << M7) >> M7;

      if (PPU.Mode7VFlip) yy = 255 - Line;
      else yy = Line;

      yy += VOffset - CentreY;
      xx = HOffset - CentreX;

      BB = l->MatrixB * yy + (CentreX << 8);
      DD = l->MatrixD * yy + (CentreY << 8);

      yy3 = ((yy + CentreY) & 7) << 4;

      for (clip = 0; clip < ClipCount; clip++)
      {
         if (GFX.pCurrentClip->Count [0])
         {
            Left = GFX.pCurrentClip->Left [clip][0];
            Right = GFX.pCurrentClip->Right [clip][0];
            if (Right <= Left) continue;
         }
         p = (uint16*) Screen + Left;

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

         int AA = (l->MatrixA * (startx + xx) + BB);
         int CC = (l->MatrixC * (startx + xx) + DD);

         int width = Right - Left;
         xx3 = (startx + HOffset);

         if (dir == 1)
         {
            __asm__ volatile(
               "1:						\n"
               "	mov	r3, %[AA], asr #18		\n"
               "	orrs	r3, r3, %[CC], asr #18		\n"
               "	bne	2f				\n"
               "						\n"
               "	mov	r3, %[CC], asr #11		\n"
               "	mov	r1, %[AA], asr #11		\n"
               "	add	r3, r1, r3, lsl #7		\n"
               "	mov	r3, r3, lsl #1			\n"
               "	ldrb	r3, [%[VRAM], r3]		\n"
               "						\n"
               "	and	r1, %[CC], #(7 << 8)		\n"
               "	add	r3, %[VRAM], r3, lsl #7		\n"
               "	and	r0, %[AA], #(7 << 8)		\n"
               "	add	r3, r3, r1, asr #4 		\n"
               "	add	r3, r3, r0, asr #7		\n"
               "						\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	add	%[AA], %[AA], %[daa]		\n"
               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #1		\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], %[dcc]		\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "	b	3f				\n"
               "2:						\n"
               "	and	r0, %[xx3], #7			\n"
               "	add	r3, %[yy3], r0, lsl #1 		\n"
               "						\n"
               "	add	r3, %[VRAM], r3			\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	add	%[AA], %[AA], %[daa]		\n"
               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #1		\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], %[dcc]		\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "3:						\n"
               : [xx3] "+r"(xx3),
               [x] "+r"(width),
               [p] "+r"(p),
               [AA] "+r"(AA),
               [CC] "+r"(CC)
               : [yy3] "r"(yy3),
               [daa] "r"(aa),
               [dcc] "r"(cc),
               [VRAM] "r"(Memory.VRAM),
               [colors] "r"(GFX.ScreenColors)
               //[dir] "r" (dir)
               : "r0", "r1", "r3", "cc"
            );
         }
         else
         {
            __asm__ volatile(
               "1:						\n"
               "	mov	r3, %[AA], asr #18		\n"
               "	orrs	r3, r3, %[CC], asr #18		\n"
               "	bne	2f				\n"
               "						\n"
               "	mov	r3, %[CC], asr #11		\n"
               "	mov	r1, %[AA], asr #11		\n"
               "	add	r3, r1, r3, lsl #7		\n"
               "	mov	r3, r3, lsl #1			\n"
               "	ldrb	r3, [%[VRAM], r3]		\n"
               "						\n"
               "	and	r1, %[CC], #(7 << 8)		\n"
               "	add	r3, %[VRAM], r3, lsl #7		\n"
               "	and	r0, %[AA], #(7 << 8)		\n"
               "	add	r3, r3, r1, asr #4 		\n"
               "	add	r3, r3, r0, asr #7		\n"
               "						\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	add	%[AA], %[AA], %[daa]		\n"
               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #-1		\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], %[dcc]		\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "	b	3f				\n"
               "2:						\n"
               "	and	r0, %[xx3], #7			\n"
               "	add	r3, %[yy3], r0, lsl #1 		\n"
               "						\n"
               "	add	r3, %[VRAM], r3			\n"
               "	ldrb	r0, [r3, #1]			\n"
               "	add	%[AA], %[AA], %[daa]		\n"
               "	movs	r0, r0, lsl #2			\n"
               "	ldrne	r1, [%[colors], r0]		\n"
               "	add	%[xx3], %[xx3], #-1		\n"
               "	strneh	r1, [%[p]]			\n"
               "						\n"
               "	add	%[CC], %[CC], %[dcc]		\n"
               "	add	%[p], %[p], #2			\n"
               "	subs	%[x], %[x], #1			\n"
               "	bne	1b				\n"
               "3:						\n"
               : [xx3] "+r"(xx3),
               [x] "+r"(width),
               [p] "+r"(p),
               [AA] "+r"(AA),
               [CC] "+r"(CC)
               : [yy3] "r"(yy3),
               [daa] "r"(aa),
               [dcc] "r"(cc),
               [VRAM] "r"(Memory.VRAM),
               [colors] "r"(GFX.ScreenColors)
               //[dir] "r" (dir)
               : "r0", "r1", "r3", "cc"
            );
         }
      }
   }
}

void DrawBGMode7Background16NewR1R2(uint8* Screen)
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

   if (!ClipCount) ClipCount = 1;

   Screen += GFX.StartY * GFX_PITCH;
   SLineMatrixData* l = &LineMatrixData [GFX.StartY];

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, l++)
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
            "	mov	r3, %[AA], asr #18		\n"
            "	orrs	r3, r3, %[CC], asr #18		\n"
            "	bne	2f				\n"
            "						\n"
            "	and	r1, %[AndByY], %[CC], asr #4	\n"
            "	and	r0, %[AndByX], %[AA], asr #7	\n"
            "						\n"
            "	and	r3, r1, #0x7f			\n"
            "	sub	r3, r1, r3			\n"
            "	add	r3, r3, r0, asr #4		\n"
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
            "	add	%[AA], %[AA], %[daa]		\n"
            "	movs	r0, r0, lsl #2			\n"
            "	ldrne	r1, [%[colors], r0]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	strneh	r1, [%[p]]			\n"
            "	add	%[p], %[p], #2			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            "	b	3f				\n"
            "2:						\n"
            "	add	%[AA], %[AA], %[daa]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
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
            [AndByX] "r"(AndByX),
            [AndByY] "r"(AndByY)
            : "r0", "r1", "r3", "cc"
         );
      }
   }
}


void DrawBGMode7Background16NewR0(uint8* Screen)
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
   int yy;
   int xx;
   int BB;
   int DD;
   uint32 Line;
   uint32 clip;
   SLineMatrixData* l;



   Left = 0;
   Right = 256;


   if (!ClipCount) ClipCount = 1;


   l = &LineMatrixData [GFX.StartY];
   Screen  += GFX.StartY * GFX_PITCH;

   for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, l++)
   {
      HOffset = ((int32) LineData[Line].BG[0].HOffset << M7) >> M7;
      VOffset = ((int32) LineData[Line].BG[0].VOffset << M7) >> M7;

      CentreX = ((int32) l->CentreX << M7) >> M7;
      CentreY = ((int32) l->CentreY << M7) >> M7;

      if (PPU.Mode7VFlip) yy = 255 - (int) Line;
      else yy = Line;

      /*yy += (VOffset - CentreY) % 1023;
      xx = (HOffset - CentreX) % 1023;
      */

      yy += ((VOffset - CentreY) << (32 - 10 + 1)) >> (32 - 10 + 1) ;
      xx = ((HOffset - CentreX) << (32 - 10 + 1)) >> (32 - 10 + 1);

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
            "						\n"
            "1:						\n"
            "	and	r1, %[AndByY], %[CC], asr #4	\n"
            "	and	r3, r1, #0x7f			\n"
            "	and	r0, %[AndByX], %[AA], asr #7	\n"
            "	sub	r3, r1, r3			\n"
            "	add	r3, r3, r0, asr #4		\n"
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
            "	add	%[AA], %[AA], %[daa]		\n"
            "	movs	r0, r0, lsl #2			\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	ldrne	r1, [%[colors], r0]		\n"
            "	add	%[p], %[p], #2			\n"
            "	strneh	r1, [%[p]]			\n"
            "						\n"
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
            [AndByX] "r"(0x3ff << 1),
            [AndByY] "r"(0x3ff << 4)
            : "r0", "r1", "r3", "cc"
         );

      }
   }

}


