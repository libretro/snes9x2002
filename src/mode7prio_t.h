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

#define M7  19
#define M7C 0x1fff

#define MACRO_CONCAT(a,b) a##b
#define DEC_FMODE7(n) MACRO_CONCAT(void DrawBGMode7Background16Prio, n)(uint8 *Screen, int bg)

static void DrawBGMode7Background16R3(uint8* Screen, int bg)
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
   int yy3;
   int xx3;
   int xx;
   int BB;
   int DD;
   uint32 Line;
   uint32 clip;
   uint8* Depth;
   unsigned int fixedColour = GFX.FixedColour;
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

         xx3 = (startx + HOffset);

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
            "	ldrb	r3, [%[d], #1]!			\n"
            "	movs	r1, r0, lsl #24			\n"
            "	beq	4f				\n"
            "	andpl	r1, %[depth], #0xff		\n"
            "	movmi	r1, %[depth], asr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	4f				\n"

            "	strb	r1, [%[d]]		\n"

            "	mov	r1, #0x13000			\n" // R1 = ZDELTA
            "	ldrb	r3, [%[d], r1]			\n"
            "	ldr	r1, [%[colors], r0, lsl #2]	\n"

            "	cmp	r3, #1				\n"
            "	blo	11f				\n"
            "	mov	r3, #0x200000			\n"
            "	addne	r0, r3, r3			\n"
            "	ldreq	r3, %[fixedcolour]		\n"

            ROP
            "11:						\n"
            "	strh	r1, [%[p]]			\n"

            "	ldr	r3, %[dir]			\n"
            "	ldr	r1, %[daa]			\n"
            //"   ldr   r0, %[dcc]        \n"
            "	add	%[xx3], %[xx3], r3		\n"
            "	add	%[AA], %[AA], r1		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            "	b	3f				\n"
            "2:						\n"
            "	ldr	r3, %[yy3]			\n"
            "	and	r0, %[xx3], #7			\n"
            //"   and   r1, r3, #7        \n"
            //"   mov   r3, r1, lsl #4          \n"
            "	add	r3, r3, r0, lsl #1 		\n"
            "						\n"
            "	add	r3, %[VRAM], r3			\n"
            "	ldrb	r0, [r3, #1]			\n"
            "	ldrb	r3, [%[d], #1]!			\n"
            "	movs	r1, r0, lsl #24			\n"
            "	beq	4f				\n"
            "	andpl	r1, %[depth], #0xff		\n"
            "	movmi	r1, %[depth], asr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	4f				\n"

            "	strb	r1, [%[d]]			\n"

            "	mov	r1, #0x13000			\n" // R1 = ZDELTA
            "	ldrb	r3, [%[d], r1]			\n"
            "	ldr	r1, [%[colors], r0, lsl #2]	\n"

            "	cmp	r3, #1				\n"
            "	blo	12f				\n"
            "	mov	r3, #0x200000			\n"
            "	ldrneh	r3, [%[p], r3]			\n"
            "	ldreq	r3, %[fixedcolour]		\n"

            ROP
            "12:						\n"
            "	strh	r1, [%[p]]			\n"
            "4:						\n"
            "	ldr	r3, %[dir]			\n"
            "	ldr	r0, %[daa]			\n"
            //"   ldr   r1, %[dcc]        \n"
            "	add	%[xx3], %[xx3], r3		\n"
            "	add	%[AA], %[AA], r0		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
            "	subs	%[x], %[x], #1			\n"
            "	bne	1b				\n"
            "3:						\n"
            :
            : [x] "r"(Right - Left),
            [AA] "r"(l->MatrixA * (startx + xx) + BB),
            [CC] "r"(l->MatrixC * (startx + xx) + DD),
            [daa] "m"(aa),
            [dcc] "r"(cc),
            [VRAM] "r"(Memory.VRAM),
            [colors] "r"(GFX.ScreenColors),
            [p] "r"(p),
            [d] "r"(d-1),
            [depth] "r"(depth),
            [dir] "m"(dir),
            [yy3] "m"(yy3),
            //[zdelta] "r" (GFX.DepthDelta),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "m"(fixedColour),
            [xx3] "r"(xx3)
            : "r0", "r1", "r3", "cc"
         );
      }
   }

}

static void DrawBGMode7Background16R1R2(uint8* Screen, int bg)
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
   unsigned int fixedColour = GFX.FixedColour;
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
            "	mov	r3, %[AA], asr #18		\n"
            "	orrs	r3, r3, %[CC], asr #18		\n"
            "	bne	2f				\n"
            "						\n"
            "	ldr	r1, %[AndByY]			\n"
            "	ldr	r0, %[AndByX]			\n"
            "	and	r1, r1, %[CC], asr #4		\n"
            "	and	r0, r0, %[AA], asr #7	\n"
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
            "	ldrb	r3, [%[d], #1]!			\n"
            "	movs	r1, r0, lsl #24			\n"
            "	beq	2f				\n"
            "	andpl	r1, %[depth], #0xff		\n"
            "	movmi	r1, %[depth], asr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	2f				\n"

            "	strb	r1, [%[d]]			\n"

            "	mov	r1, #0x13000			\n" // R1 = ZDELTA
            "	ldrb	r3, [%[d], r1]			\n"
            "	ldr	r1, [%[colors], r0, lsl #2]	\n"

            "	cmp	r3, #1				\n"
            "	blo	11f				\n"
            "	mov	r3, #0x200000			\n"
            "	ldrneh	r3, [%[p], r3]			\n"
            "	ldreq	r3, %[fixedcolour]		\n"

            ROP
            "11:						\n"
            "	strh	r1, [%[p]]			\n"
            "2:						\n"
            //"   ldr   r0, %[dcc]        \n"
            "	add	%[AA], %[AA], %[daa]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
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
            [d] "r"(d-1),
            [depth] "r"(depth),
            //[zdelta] "r" (GFX.DepthDelta),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "m"(fixedColour),
            [AndByX] "m"(AndByX),
            [AndByY] "m"(AndByY)
            : "r0", "r1", "r3", "cc"
         );
      }
   }
}



static void DrawBGMode7Background16R0(uint8* Screen, int bg)
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
   unsigned int fixedColour = GFX.FixedColour;
   uint32 depth = Mode7Depths[0] | (Mode7Depths[1] << 8);
   unsigned int AndByY = (0x3ff << 4);

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
            "	ldr	r3, %[AndByY]			\n"
            "1:						\n"
            "	and	r1, r3, %[CC], asr #4		\n"
            "	and	r0, r3, %[AA], asr #4		\n"
            "	and	r3, r1, #0x7f			\n"
            "	sub	r3, r1, r3			\n"
            "	add	r3, r3, r0, asr #7		\n"
            "	add	r3, r3, r3			\n"
            "	ldrb	r3, [%[VRAM], r3]		\n"
            "						\n"
            "	and	r1, r1, #0x70			\n"
            "	add	r3, %[VRAM], r3, lsl #7		\n"
            "						\n"
            "	and	r0, r0, #(14 << 3)		\n"
            "	add	r3, r3, r1			\n"
            "	add	r3, r3, r0, asr #3		\n"
            "						\n"
            "	ldrb	r0, [r3, #1]			\n"
            "	ldrb	r3, [%[d], #1]!			\n"
            "	movs	r1, r0, lsl #24			\n"
            "	beq	2f				\n"
            "	andpl	r1, %[depth], #0xff		\n"
            "	movmi	r1, %[depth], asr #8		\n"
            "	cmp	r1, r3				\n"
            "	bls	2f				\n"

            "	strb	r1, [%[d]]			\n"

            "	mov	r1, #0x13000			\n" // R1 = ZDELTA
            "	ldrb	r3, [%[d], r1]			\n"
            "	ldr	r1, [%[colors], r0, lsl #2] 	\n"

            "	cmp	r3, #1				\n"
            "	blo	11f				\n"
            "	mov	r3, #0x200000			\n"
            "	ldrneh	r3, [%[p], r3]			\n"
            "	ldreq	r3, %[fixedcolour]		\n"

            ROP
            "11:						\n"
            "	strh	r1, [%[p]]			\n"

            "2:						\n"
            //"   ldr   r0, %[dcc]        \n"
            "	add	%[AA], %[AA], %[daa]		\n"
            "	add	%[CC], %[CC], %[dcc]		\n"
            "	add	%[p], %[p], #2			\n"
            "	subs	%[x], %[x], #1			\n"
            "	ldrne	r3, %[AndByY]			\n"
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
            [d] "r"(d-1),
            //[zdelta] "r" (GFX.DepthDelta),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "m"(fixedColour),
            [depth] "r"(depth),
            [AndByY] "m"(AndByY)
            : "r0", "r1", "r3", "cc"
         );

      }
   }

}

DEC_FMODE7(ROPNAME)
{
#ifdef __DEBUG__
#define TOSTRING(n)  #n
   printf("Rendering Mode7 w/prio, ROp: " TOSTRING(ROPNAME) ", R:%d, r2130: %d, bg: %d\n", PPU.Mode7Repeat, GFX.r2130 & 1,
          bg)
#endif

   if (GFX.r2130 & 1)
   {
      if (IPPU.DirectColourMapsNeedRebuild) S9xBuildDirectColourMaps();
      GFX.ScreenColors = DirectColourMaps [0];
   }
   else  GFX.ScreenColors = IPPU.ScreenColors;

   switch (PPU.Mode7Repeat)
   {
   case 0:
      DrawBGMode7Background16R0(Screen, bg);
      return;
   case 3:
      DrawBGMode7Background16R3(Screen, bg);
      return;
   default:
      DrawBGMode7Background16R1R2(Screen, bg);
      return;
   }
}


