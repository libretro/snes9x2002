/*
 Templates for

 DrawTile16
 DrawClippedTile16
*/

#include "snes9x.h"
#include "memmap.h"
#include "ppu.h"
#include "display.h"
#include "gfx.h"
#include "tile16.h"

#define ROW(width) \
         "	ldrb	r8, [%[depth]], #1		\n"\
         "	mov	r10, " width "			\n" \
         "7:\n" \
         \
         "	cmp	%[gfx_z1], r8			\n"\
         "	ldrhib	r9, [%[bp]]		\n"\
         "	bls	3f				\n"\
                              \
         "	movs	r9, r9, lsl #2			\n"\
         "	beq	3f				\n"\
                              \
         "	ldrb	r8, [%[subdepth], %[depth]]	\n"\
         "	ldr	r9, [%[colors], r9]		\n"\
         "	strb	%[gfx_z2], [%[depth], #(-1)]	\n"\
                              \
         "	cmp	r8, #1				\n"\
         "	bne	4f				\n"\
                              \
         ROP \
         "4:						\n"\
         "	strh	r9, [%[screen]] 	\n"\
                              \
         "3:						\n"\
         \
         "	add	%[bp], %[bp], #1		\n"\
         "	add	%[screen], %[screen], #2	\n"\
         "	subs	r10, r10, #1			\n"\
         "	ldrneb	r8, [%[depth]], #1		\n"\
         "	bne	7b				\n"

#define ROW1(width)  \
         "	ldrb	r8, [%[depth]], #1		\n"\
         "	mov	r10, " width "			\n" \
         "7:\n" \
         \
         "	cmp	%[gfx_z1], r8			\n"\
         "	ldrhib	r9, [%[bp]]			\n"\
         "	bls	3f				\n"\
                              \
         "	movs	r9, r9, lsl #2			\n"\
         "	beq	3f				\n"\
                              \
         "	ldrb	r8, [%[subdepth], %[depth]]	\n"\
         "	ldr	r9, [%[colors], r9]		\n"\
         "	strb	%[gfx_z2], [%[depth], #(-1)]	\n"\
                              \
         "	cmp	r8, #1				\n"\
         "	bne	4f				\n"\
                              \
         ROP \
         "4:						\n"\
         "	strh	r9, [%[screen]]		 	\n"\
                              \
         "3:						\n"\
         \
         "	sub	%[bp], %[bp], #1  		\n"\
         "	add	%[screen], %[screen], #2	\n"\
         "	subs	r10, r10, #1			\n"\
         "	ldrneb	r8, [%[depth]], #1		\n"\
         "	bne	7b				\n"


#define MACRO_CONCAT(a,b) a##b
#define DEC_DRAW(n) MACRO_CONCAT(void DrawTile16, n)(uint32 Tile, uint32 Offset, uint32 StartLine, uint32 LineCount)
#define DEC_DRAWCLIPPED(n) MACRO_CONCAT(void DrawClippedTile16, n)(uint32 Tile, uint32 Offset, uint32 StartPixel, uint32 Width,  uint32 StartLine, uint32 LineCount)


// DrawTile16 -----------------------------------------
DEC_DRAW(ROPNAME)
{
   TILE_PREAMBLE

   if (Tile & V_FLIP)
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"

            ROW("#8")

            "	sub	%[bp], %[bp], #(8+8)		\n"
            "	add	%[screen], %[screen], #(640-16)	\n"
            "	add	%[depth], %[depth], #(320-8)	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
            ROW1("#8")

            "	add	%[screen], %[screen], #(640-16)	\n"
            "	add	%[depth], %[depth], #(320-8)	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + 56 - StartLine + 7)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
   }
   else
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
            ROW("#8")

            "	add	%[screen], %[screen], #(640-16)	\n"
            "	add	%[depth], %[depth], #(320-8)	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
            ROW1("#8")

            "	add	%[bp], %[bp], #(8+8)		\n"
            "	add	%[screen], %[screen], #(640-16)	\n"
            "	add	%[depth], %[depth], #(320-8)	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"

            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + StartLine + 7)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );

      }
   }
}

// DrawClippedTile16 -----------------------------------------
DEC_DRAWCLIPPED(ROPNAME)
{
   if (Width == 0) return;

   TILE_PREAMBLE

   Offset = Offset + StartPixel;
   if (Tile & V_FLIP)
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"

            ROW("%[width]")

            // Loop
            "1:						\n"
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            // --
            "	sub	%[bp], %[bp], %[width]		\n"
            "	sub	%[screen], %[screen], %[width], lsl #1	\n"
            "	sub	%[depth], %[depth], %[width]	\n"
            // --
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [width] "r"(Width),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + 56 - StartLine + StartPixel)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
            ROW1("%[width]")
            // Loop
            "1:						\n"
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            // --
            "	add	%[bp], %[bp], %[width]		\n"
            "	sub	%[screen], %[screen], %[width], lsl #1	\n"
            "	sub	%[depth], %[depth], %[width]	\n"
            // --
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [width] "r"(Width),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + 56 - StartLine - StartPixel + 7)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
   }
   else
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
            ROW("%[width]")
            // Loop
            "1:						\n"
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            // --
            "	sub	%[bp], %[bp], %[width]		\n"
            "	sub	%[screen], %[screen], %[width], lsl #1	\n"
            "	sub	%[depth], %[depth], %[width]	\n"
            // --
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [width] "r"(Width),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + StartLine + StartPixel)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
            ROW1("%[width]")
            // Loop
            "1:						\n"
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            // --
            "	add	%[bp], %[bp], %[width]		\n"
            "	sub	%[screen], %[screen], %[width], lsl #1	\n"
            "	sub	%[depth], %[depth], %[width]	\n"
            // --
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [colors] "r"(GFX.ScreenColors),
            //[delta] "r" (GFX.Delta << 1),
            [fixedcolour] "r"(FIXEDCOLOUR),
            [width] "r"(Width),
            [screen] "r"((uint16*) GFX.S + Offset),
            [depth] "r"(GFX.ZBuffer + Offset),
            [subdepth] "r"(GFX.DepthDelta - 1),
            [bp] "r"(pCache + StartLine - StartPixel + 7)
            // clobbered
            : "r8", "r9", "r10", "cc"
         );

      }
   }
}

