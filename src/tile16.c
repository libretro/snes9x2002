/*
 * Snes9x - Portable Super Nintendo Entertainment System (TM) emulator.
 *
 * (c) Copyright 1996 - 2001 Gary Henderson (gary.henderson@ntlworld.com) and
 *                           Jerremy Koot (jkoot@snes9x.com)
 *
 * Super FX C emulator code
 * (c) Copyright 1997 - 1999 Ivar (ivar@snes9x.com) and
 *                           Gary Henderson.
 * Super FX assembler emulator code (c) Copyright 1998 zsKnight and _Demo_.
 *
 * DSP1 emulator code (c) Copyright 1998 Ivar, _Demo_ and Gary Henderson.
 * C4 asm and some C emulation code (c) Copyright 2000 zsKnight and _Demo_.
 * C4 C code (c) Copyright 2001 Gary Henderson (gary.henderson@ntlworld.com).
 *
 * (c) Copyright 2014 - 2016 Daniel De Matteis. (UNDER NO CIRCUMSTANCE 
 * WILL COMMERCIAL RIGHTS EVER BE APPROPRIATED TO ANY PARTY)
 *
 * DOS port code contains the works of other authors. See headers in
 * individual files.
 *
 * Snes9x homepage: http://www.snes9x.com
 *
 * Permission to use, copy, modify and distribute Snes9x in both binary and
 * source form, for non-commercial purposes, is hereby granted without fee,
 * providing that this license information and copyright notice appear with
 * all copies and any derived work.
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event shall the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Snes9x is freeware for PERSONAL USE only. Commercial users should
 * seek permission of the copyright holders first. Commercial use includes
 * charging money for Snes9x or software derived from Snes9x.
 *
 * The copyright holders request that bug fixes and improvements to the code
 * should be forwarded to them so everyone can benefit from the modifications
 * in future versions.
 *
 * Super NES and Super Nintendo Entertainment System are trademarks of
 * Nintendo Co., Limited and its subsidiary companies.
 */

// ARM V5 Assembly by bitrider

#include "snes9x.h"

#include "memmap.h"
#include "ppu.h"
#include "display.h"
#include "gfx.h"
#include "tile16.h"

extern uint32 HeadMask [4];
extern uint32 TailMask [5];

#ifdef ARM_ASM

#define f(from, to_lo, to_hi, pix) \
   "	movs	" #from ", " #from ", lsl #(17)	\n" \
   "	addcs	" #to_hi ", " #to_hi ", #(1 << ( 0 + 1 + " #pix ")) \n" \
   "	addmi	" #to_hi ", " #to_hi ", #(1 << ( 8 + 1 + " #pix ")) \n" \
   "	movs	" #from ", " #from ", lsl #2	\n" \
   "	addcs	" #to_hi ", " #to_hi ", #(1 << (16 + 1 + " #pix ")) \n" \
   "	addmi	" #to_hi ", " #to_hi ", #(1 << (24 + 1 + " #pix ")) \n" \
   "	movs	" #from ", " #from ", lsl #2	\n"\
   "	addcs	" #to_lo ", " #to_lo ", #(1 << ( 0 + 1 + " #pix ")) \n" \
   "	addmi	" #to_lo ", " #to_lo ", #(1 << ( 8 + 1 + " #pix ")) \n" \
   "	movs	" #from ", " #from ", lsl #2	\n" \
   "	addcs	" #to_lo ", " #to_lo ", #(1 << (16 + 1 + " #pix ")) \n" \
   "	addmi	" #to_lo ", " #to_lo ", #(1 << (24 + 1 + " #pix ")) \n" \
   \
   "	movs	" #from ", " #from ", lsl #2	\n"\
   "	addcs	" #to_hi ", " #to_hi ", #(1 << ( 0 + " #pix ")) \n"\
   "	addmi	" #to_hi ", " #to_hi ", #(1 << ( 8 + " #pix ")) \n" \
   "	movs	" #from ", " #from ", lsl #2	\n"\
   "	addcs	" #to_hi ", " #to_hi ", #(1 << (16 + " #pix ")) \n" \
   "	addmi	" #to_hi ", " #to_hi ", #(1 << (24 + " #pix ")) \n"\
   "	movs	" #from ", " #from ", lsl #2	\n"\
   "	addcs	" #to_lo ", " #to_lo ", #(1 << ( 0 + " #pix ")) \n"\
   "	addmi	" #to_lo ", " #to_lo ", #(1 << ( 8 + " #pix ")) \n" \
   "	movs	" #from ", " #from ", lsl #2	\n"\
   "	addcs	" #to_lo ", " #to_lo ", #(1 << (16 + " #pix ")) \n" \
   "	addmi	" #to_lo ", " #to_lo ", #(1 << (24 + " #pix ")) \n"

uint8 ConvertTile8bpp(uint8* pCache, uint32 TileAddr)
{
   uint8* tp = &Memory.VRAM[TileAddr];
   uint32* p = (uint32*) pCache;
   uint32 non_zero;

   __asm__ volatile(
      "	mov	r0, #8		\n"
      "	mov	%[non_zero], #0	\n"

      "1:	\n"

      "	mov	r1, #0		\n"
      "	mov	r2, #0		\n"

      "	ldrh	r3, [%[tp], #16]	\n"
      "	ldrh	r4, [%[tp], #32]	\n"

      f(r3, r2, r1, 2)
      f(r4, r2, r1, 4)

      "	ldrh	r3, [%[tp], #48]	\n"
      "	ldrh	r4, [%[tp]], #2	\n"

      f(r3, r2, r1, 6)
      f(r4, r2, r1, 0)

      "	stmia	%[p]!, {r1, r2} \n"

      "	orr	%[non_zero], %[non_zero], r1	\n"
      "	orr	%[non_zero], %[non_zero], r2	\n"

      "	subs	r0, r0, #1	\n"
      "	bne	1b		\n"

      : [non_zero] "+r"(non_zero),
      [tp] "+r"(tp),
      [p] "+r"(p)
      :
      : "r0", "r1", "r2", "r3", "r4", "cc"
   );

   return (non_zero ? TRUE : BLANK_TILE);
}

uint8 ConvertTile4bpp(uint8* pCache, uint32 TileAddr)
{
   uint8* tp = &Memory.VRAM[TileAddr];
   uint32* p = (uint32*) pCache;
   uint32 non_zero;

   __asm__ volatile(
      "	mov	r0, #8		\n"
      "	mov	%[non_zero], #0	\n"
      "1:	\n"

      "	mov	r1, #0		\n"
      "	mov	r2, #0		\n"

      "	ldrh	r3, [%[tp], #16]\n"
      "	ldrh	r4, [%[tp]], #2	\n"

      f(r3, r2, r1, 2)
      f(r4, r2, r1, 0)

      "	stmia	%[p]!, {r1, r2} \n"

      "	orr	%[non_zero], %[non_zero], r1	\n"
      "	orr	%[non_zero], %[non_zero], r2	\n"

      "	subs	r0, r0, #1	\n"
      "	bne	1b		\n"

      : [non_zero] "+r"(non_zero),
      [tp] "+r"(tp),
      [p] "+r"(p)
      :
      : "r0", "r1", "r2", "r3", "r4", "cc"
   );

   return (non_zero ? TRUE : BLANK_TILE);
}

uint8 ConvertTile2bpp(uint8* pCache, uint32 TileAddr)
{
   uint8* tp = &Memory.VRAM[TileAddr];
   uint32* p = (uint32*) pCache;
   uint32 non_zero;

   __asm__ volatile(
      "	mov	r0, #8		\n"
      "	mov	%[non_zero], #0	\n"
      "1:	\n"

      "	ldrh	r3, [%[tp]], #2	\n"

      "	mov	r1, #0		\n"
      "	mov	r2, #0		\n"

      f(r3, r2, r1, 0)

      "	stmia	%[p]!, {r1, r2} \n"

      "	orr	%[non_zero], %[non_zero], r1	\n"
      "	orr	%[non_zero], %[non_zero], r2	\n"

      "	subs	r0, r0, #1	\n"
      "	bne	1b		\n"

      : [non_zero] "+r"(non_zero),
      [tp] "+r"(tp),
      [p] "+r"(p)
      :
      : "r0", "r1", "r2", "r3", "cc"
   );

   return (non_zero ? TRUE : BLANK_TILE);
}


uint8(*ConvertTile)(uint8* pCache, uint32 TileAddr);
void SelectConvertTile()
{
   switch (BG.BitShift)
   {

   case 8:
      ConvertTile = &ConvertTile8bpp;
      break;
   case 4:
      ConvertTile = &ConvertTile4bpp;
      break;
   case 2:
      ConvertTile = &ConvertTile2bpp;
      break;
   }
}
#else
uint8 ConvertTile(uint8* pCache, uint32 TileAddr)
{
   uint8* tp = &Memory.VRAM[TileAddr];
   uint32* p = (uint32*) pCache;
   uint32 non_zero = 0;
   uint8 line;

   switch (BG.BitShift)
   {
   case 8:
      for (line = 8; line != 0; line--, tp += 2)
      {
         uint32 p1 = 0;
         uint32 p2 = 0;
         uint8 pix;

         if ((pix = *(tp + 0)))
         {
            p1 |= odd_high[0][pix >> 4];
            p2 |= odd_low[0][pix & 0xf];
         }
         if ((pix = *(tp + 1)))
         {
            p1 |= even_high[0][pix >> 4];
            p2 |= even_low[0][pix & 0xf];
         }
         if ((pix = *(tp + 16)))
         {
            p1 |= odd_high[1][pix >> 4];
            p2 |= odd_low[1][pix & 0xf];
         }
         if ((pix = *(tp + 17)))
         {
            p1 |= even_high[1][pix >> 4];
            p2 |= even_low[1][pix & 0xf];
         }
         if ((pix = *(tp + 32)))
         {
            p1 |= odd_high[2][pix >> 4];
            p2 |= odd_low[2][pix & 0xf];
         }
         if ((pix = *(tp + 33)))
         {
            p1 |= even_high[2][pix >> 4];
            p2 |= even_low[2][pix & 0xf];
         }
         if ((pix = *(tp + 48)))
         {
            p1 |= odd_high[3][pix >> 4];
            p2 |= odd_low[3][pix & 0xf];
         }
         if ((pix = *(tp + 49)))
         {
            p1 |= even_high[3][pix >> 4];
            p2 |= even_low[3][pix & 0xf];
         }
         *p++ = p1;
         *p++ = p2;
         non_zero |= p1 | p2;
      }
      break;

   case 4:
      for (line = 8; line != 0; line--, tp += 2)
      {
         uint32 p1 = 0;
         uint32 p2 = 0;
         uint8 pix;
         if ((pix = *(tp + 0)))
         {
            p1 |= odd_high[0][pix >> 4];
            p2 |= odd_low[0][pix & 0xf];
         }
         if ((pix = *(tp + 1)))
         {
            p1 |= even_high[0][pix >> 4];
            p2 |= even_low[0][pix & 0xf];
         }
         if ((pix = *(tp + 16)))
         {
            p1 |= odd_high[1][pix >> 4];
            p2 |= odd_low[1][pix & 0xf];
         }
         if ((pix = *(tp + 17)))
         {
            p1 |= even_high[1][pix >> 4];
            p2 |= even_low[1][pix & 0xf];
         }
         *p++ = p1;
         *p++ = p2;
         non_zero |= p1 | p2;
      }
      break;

   case 2:
      for (line = 8; line != 0; line--, tp += 2)
      {
         uint32 p1 = 0;
         uint32 p2 = 0;
         uint8 pix;
         if ((pix = *(tp + 0)))
         {
            p1 |= odd_high[0][pix >> 4];
            p2 |= odd_low[0][pix & 0xf];
         }
         if ((pix = *(tp + 1)))
         {
            p1 |= even_high[0][pix >> 4];
            p2 |= even_low[0][pix & 0xf];
         }
         *p++ = p1;
         *p++ = p2;
         non_zero |= p1 | p2;
      }
      break;
   }
   return (non_zero ? TRUE : BLANK_TILE);
}
#endif

void SelectPalette()
{
   // GFX.ScreenColors = &GFX.ScreenColorsPre[(Tile & GFX.PaletteMask) >> GFX.PaletteShift];
   if (BG.DirectColourMode)
   {
      // GFX.ScreenColors = DirectColourMaps [(Tile >> 10) & BG.PaletteMask];

      GFX.ScreenColorsPre = DirectColourMaps[0];
      GFX.PaletteMask = BG.PaletteMask << 10;
      GFX.PaletteShift = 10;
   }
   else
   {
      // GFX.ScreenColors = &IPPU.ScreenColors [(((Tile >> 10) & BG.PaletteMask) << BG.PaletteShift) + BG.StartPalette];

      GFX.ScreenColorsPre = &IPPU.ScreenColors[BG.StartPalette];
      GFX.PaletteMask = BG.PaletteMask << 10;
      GFX.PaletteShift = 10 - BG.PaletteShift;
   }

}

static INLINE void WRITE_4PIXELSHI16(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N] && (Pixel = Pixels[2*N])) \
    { \
   Screen [N] = GFX.ScreenColors [Pixel]; \
   Depth [N] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

static INLINE void WRITE_4PIXELSHI16_FLIPPED(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N] && (Pixel = Pixels[6 - 2*N])) \
    { \
   Screen [N] = GFX.ScreenColors [Pixel]; \
   Depth [N] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

static INLINE void WRITE_4PIXELS16x2(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N * 2] && (Pixel = Pixels[N])) \
    { \
   Screen [N * 2] = Screen [N * 2 + 1] = GFX.ScreenColors [Pixel]; \
   Depth [N * 2] = Depth [N * 2 + 1] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

static INLINE void WRITE_4PIXELS16_FLIPPEDx2(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N * 2] && (Pixel = Pixels[3 - N])) \
    { \
   Screen [N * 2] = Screen [N * 2 + 1] = GFX.ScreenColors [Pixel]; \
   Depth [N * 2] = Depth [N * 2 + 1] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

static INLINE void WRITE_4PIXELS16x2x2(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N * 2] && (Pixel = Pixels[N])) \
    { \
   Screen [N * 2] = Screen [N * 2 + 1] = Screen [(GFX_PITCH >> 1) + N * 2] = \
       Screen [(GFX_PITCH >> 1) + N * 2 + 1] = GFX.ScreenColors [Pixel]; \
   Depth [N * 2] = Depth [N * 2 + 1] = Depth [(GFX_PITCH >> 1) + N * 2] = \
       Depth [(GFX_PITCH >> 1) + N * 2 + 1] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

static INLINE void WRITE_4PIXELS16_FLIPPEDx2x2(uint32 Offset, uint8* Pixels)
{
   uint32 Pixel;
   uint16* Screen = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;

#define FN(N) \
    if (GFX.Z1 > Depth [N * 2] && (Pixel = Pixels[3 - N])) \
    { \
   Screen [N * 2] = Screen [N * 2 + 1] = Screen [(GFX_PITCH >> 1) + N * 2] = \
       Screen [(GFX_PITCH >> 1) + N * 2 + 1] = GFX.ScreenColors [Pixel]; \
   Depth [N * 2] = Depth [N * 2 + 1] = Depth [(GFX_PITCH >> 1) + N * 2] = \
       Depth [(GFX_PITCH >> 1) + N * 2 + 1] = GFX.Z2; \
    }

   FN(0)
   FN(1)
   FN(2)
   FN(3)
#undef FN
}

#ifdef __FAST_OBJS__
// DrawNoZTile16 -----------------------------------------
void DrawNoZTile16(uint32 Tile, uint32 Offset, uint32 StartLine, uint32 LineCount)
{

   TILE_PREAMBLE
   if (Tile & V_FLIP)
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
#define FN(p)  \
         "	ldrb	r1, [%[bp], #" #p "]		\n"\
         "	ldrb	r0, [%[bp], #(" #p " + 1)]	\n"\
         "	movs	r1, r1, lsl #2			\n"\
         "	ldrne	r1, [%[colors], r1]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r1, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"\
         "	movs	r1, r0, lsl #2			\n"\
         "	ldrne	r1, [%[colors], r1]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #(" #p " + 1)]	\n"\
         "	strneh	r1, [%[screen], #((" #p " + 1) * 2)]	\n"\
         "3:						\n"

            FN(0)
            FN(2)
            FN(4)
            FN(6)
            // Loop
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r0", "r1", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
#define FN1(p)  \
         "	ldrb	r1, [%[bp], #( 7 - " #p ")]	\n"\
         "	ldrb	r0, [%[bp], #(7 - " #p " - 1)]	\n"\
         "	movs	r1, r1, lsl #2			\n"\
         "	ldrne	r1, [%[colors], r1]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r1, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"\
         "	movs	r1, r0, lsl #2			\n"\
         "	ldrne	r1, [%[colors], r1]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #(" #p " + 1)]	\n"\
         "	strneh	r1, [%[screen], #((" #p " + 1) * 2 )]	\n"\
         "3:						\n"

            FN1(0)
            FN1(2)
            FN1(4)
            FN1(6)
            // Loop
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r0", "r1", "cc" // r8 & flags
         );
      }
   }
   else
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
            FN(0)
            FN(2)
            FN(4)
            FN(6)
            // Loop
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r0", "r1", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
            FN1(0)
            FN1(2)
            FN1(4)
            FN1(6)
            // Loop
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r0", "r1", "cc" // r8 & flags
         );

      }
   }
#undef FN
#undef FN1

}
#endif // #ifdef __FAST_OBJS__

// DrawTile16 -----------------------------------------
void DrawTile16(uint32 Tile, uint32 Offset, uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE

   if (Tile & V_FLIP)
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
#define FN(p)  \
         "	ldrb	r9, [%[depth], #" #p "]		\n"\
         "	ldrb	r8, [%[depth], #(" #p " + 1)]	\n"\
         "	cmp	%[gfx_z1], r9			\n"\
         "	ldrhib	r9, [%[bp], #" #p "]		\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r9, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"\
         "	cmp	%[gfx_z1], r8			\n"\
         "	ldrhib	r9, [%[bp], #(" #p " + 1)]	\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #(" #p " + 1)]	\n"\
         "	strneh	r9, [%[screen], #((" #p " + 1) * 2)]	\n"\
         "3:						\n"

            FN(0)
            FN(2)
            FN(4)
            FN(6)
            // Loop
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
#define FN1(p)  \
         "	ldrb	r9, [%[depth], #" #p "]		\n"\
         "	ldrb	r8, [%[depth], #(" #p " + 1)]	\n"\
         "	cmp	%[gfx_z1], r9			\n"\
         "	ldrhib	r9, [%[bp], #( 7 - " #p ")]	\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r9, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"\
         "	cmp	%[gfx_z1], r8			\n"\
         "	ldrhib	r9, [%[bp], #(7 - " #p " - 1)]	\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #(" #p " + 1)]	\n"\
         "	strneh	r9, [%[screen], #((" #p " + 1) * 2 )]	\n"\
         "3:						\n"

            FN1(0)
            FN1(2)
            FN1(4)
            FN1(6)
            // Loop
            "	sub	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );
      }
   }
   else
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
            FN(0)
            FN(2)
            FN(4)
            FN(6)
            // Loop
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
            FN1(0)
            FN1(2)
            FN1(4)
            FN1(6)
            // Loop
            "	add	%[bp], %[bp], #8		\n"
            "	add	%[screen], %[screen], #640	\n"
            "	add	%[depth], %[depth], #320	\n"
            "	subs 	%[lcount], %[lcount], #1	\n"
            "	bne	2b"
            // output
            : [lcount] "+r"(LineCount)
            // input
            : [gfx_z1] "r"(GFX.Z1),
            [gfx_z2] "r"(GFX.Z2),
            [screen] "r"((uint16*) GFX.S + Offset),
            [colors] "r"(GFX.ScreenColors),
            [depth] "r"(GFX.DB + Offset),
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8, r9 & flags
         );

      }
   }
#undef FN
#undef FN1

}

// DrawClippedTile16 -----------------------------------------
void DrawClippedTile16(uint32 Tile, uint32 Offset,
                       uint32 StartPixel, uint32 Width,
                       uint32 StartLine, uint32 LineCount)
{
   if (Width == 0) return;
   if (Width == 8)
   {
      DrawTile16(Tile, Offset, StartLine, LineCount);
      return;
   }

   TILE_PREAMBLE
   Offset += StartPixel;

#define FN(p)  \
         "	ldrb	r8, [%[depth], #" #p "]		\n"\
         "	ldrb	r9, [%[bp], #" #p "]		\n"\
         "	cmp	%[gfx_z1], r8			\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r9, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"

#define FN1(p)  \
         "	ldrb	r8, [%[depth], #" #p "]		\n"\
         "	ldrb	r9, [%[bp], #(7 - " #p ")]	\n"\
         "	cmp	%[gfx_z1], r8			\n"\
         "	bls	3f				\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" #p "]	\n"\
         "	strneh	r9, [%[screen], #(" #p " * 2)]	\n"\
         "3:						\n"\

   switch (Width)
   {
   case 1:
      // -- Width = 1 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }
      break;
   case 2:
      // -- Width = 2 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   case 3:
      // -- Width = 3 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               FN(2)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               FN1(2)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               FN(2)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               FN1(2)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   case 4:
      // -- Width = 4 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               FN(2)
               FN(3)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               FN(2)
               FN(3)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   case 5:
      // -- Width = 5 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   case 6:
      // -- Width = 6 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               FN(5)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               FN1(5)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               FN(5)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               FN1(5)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   case 7:
      // -- Width = 7 ------
      if (Tile & V_FLIP)
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"

               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               FN(5)
               FN(6)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"

               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               FN1(5)
               FN1(6)
               // Loop
               "1:						\n"
               "	sub	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + 56 - StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
      }
      else
      {
         if (!(Tile & H_FLIP))
         {
            __asm__ volatile(
               "2:					\n"
               FN(0)
               FN(1)
               FN(2)
               FN(3)
               FN(4)
               FN(5)
               FN(6)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine + StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );
         }
         else
         {
            __asm__ volatile(
               "2:					\n"
               FN1(0)
               FN1(1)
               FN1(2)
               FN1(3)
               FN1(4)
               FN1(5)
               FN1(6)
               // Loop
               "1:						\n"
               "	add	%[bp], %[bp], #8		\n"
               "	add	%[screen], %[screen], #640	\n"
               "	add	%[depth], %[depth], #320	\n"
               "	subs 	%[lcount], %[lcount], #1	\n"
               "	bne	2b"
               // output
               :  // none
               // input
               : [lcount] "r"(LineCount),
               [gfx_z1] "r"(GFX.Z1),
               [gfx_z2] "r"(GFX.Z2),
               [screen] "r"((uint16*) GFX.S + Offset),
               [colors] "r"(GFX.ScreenColors),
               [depth] "r"(GFX.DB + Offset),
               [width] "r"(Width),
               [bp] "r"(pCache + StartLine - StartPixel)
               // clobbered
               : "r9", "r8", "cc" // r9 & flags
            );

         }
      }

      break;
   }





#undef FN
#undef FN1
#undef C

}

void DrawTile16x2(uint32 Tile, uint32 Offset, uint32 StartLine,
                  uint32 LineCount)
{
   TILE_PREAMBLE
   uint8* bp;
   uint32 l;

   RENDER_TILE(WRITE_4PIXELS16x2, WRITE_4PIXELS16_FLIPPEDx2, 8)
}

void DrawClippedTile16x2(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Width,
                         uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint8* bp;
   uint32 l;

   TILE_CLIP_PREAMBLE
   RENDER_CLIPPED_TILE(WRITE_4PIXELS16x2, WRITE_4PIXELS16_FLIPPEDx2, 8)
}

void DrawTile16x2x2(uint32 Tile, uint32 Offset, uint32 StartLine,
                    uint32 LineCount)
{
   TILE_PREAMBLE
   uint8* bp;
   uint32 l;

   RENDER_TILE(WRITE_4PIXELS16x2x2, WRITE_4PIXELS16_FLIPPEDx2x2, 8)
}

void DrawClippedTile16x2x2(uint32 Tile, uint32 Offset,
                           uint32 StartPixel, uint32 Width,
                           uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint8* bp;
   uint32 l;

   TILE_CLIP_PREAMBLE
   RENDER_CLIPPED_TILE(WRITE_4PIXELS16x2x2, WRITE_4PIXELS16_FLIPPEDx2x2, 8)
}

void DrawLargePixel16(uint32 Tile, uint32 Offset,
                      uint32 StartPixel, uint32 Pixels,
                      uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;

   uint16* sp = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.DB + Offset;
   uint16 pixel;

#define PLOT_PIXEL(screen, pixel) (pixel)

   RENDER_TILE_LARGE(GFX.ScreenColors [pixel], PLOT_PIXEL)
}


void DrawLargePixel16Add(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;

   uint16* sp = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.ZBuffer + Offset;
   uint16 pixel;

#define LARGE_ADD_PIXEL(s, p) \
(Depth [z + GFX.DepthDelta] ? (Depth [z + GFX.DepthDelta] != 1 ? \
                COLOR_ADD (p, *(s + GFX.Delta))    : \
                COLOR_ADD (p, GFX.FixedColour)) \
             : p)

   RENDER_TILE_LARGE(GFX.ScreenColors [pixel], LARGE_ADD_PIXEL)
}

void DrawLargePixel16Add1_2(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;

   uint16* sp = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.ZBuffer + Offset;
   uint16 pixel;

#define LARGE_ADD_PIXEL1_2(s, p) \
((uint16) (Depth [z + GFX.DepthDelta] ? (Depth [z + GFX.DepthDelta] != 1 ? \
                COLOR_ADD1_2 (p, *(s + GFX.Delta))    : \
                COLOR_ADD (p, GFX.FixedColour)) \
             : p))

   RENDER_TILE_LARGE(GFX.ScreenColors [pixel], LARGE_ADD_PIXEL1_2)
}

void DrawLargePixel16Sub(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;


   uint16* sp = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.ZBuffer + Offset;
   uint16 pixel;

#define LARGE_SUB_PIXEL(s, p) \
(Depth [z + GFX.DepthDelta] ? (Depth [z + GFX.DepthDelta] != 1 ? \
                COLOR_SUB (p, *(s + GFX.Delta))    : \
                COLOR_SUB (p, GFX.FixedColour)) \
             : p)

   RENDER_TILE_LARGE(GFX.ScreenColors [pixel], LARGE_SUB_PIXEL)
}

void DrawLargePixel16Sub1_2(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;

   uint16* sp = (uint16*) GFX.S + Offset;
   uint8*  Depth = GFX.ZBuffer + Offset;
   uint16 pixel;

#define LARGE_SUB_PIXEL1_2(s, p) \
(Depth [z + GFX.DepthDelta] ? (Depth [z + GFX.DepthDelta] != 1 ? \
                COLOR_SUB1_2 (p, *(s + GFX.Delta))    : \
                COLOR_SUB (p, GFX.FixedColour)) \
             : p)

   RENDER_TILE_LARGE(GFX.ScreenColors [pixel], LARGE_SUB_PIXEL1_2)
}

void DrawHiResTile16(uint32 Tile, uint32 Offset, uint32 StartLine,
                     uint32 LineCount)
{
   TILE_PREAMBLE
   uint32 l;

   uint8* bp;

   RENDER_TILEHI(WRITE_4PIXELSHI16, WRITE_4PIXELSHI16_FLIPPED, 4)
}

void DrawHiResClippedTile16(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Width,
                            uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE
   uint8* bp;
   uint32 l;

   TILE_CLIP_PREAMBLE
   RENDER_CLIPPED_TILEHI(WRITE_4PIXELSHI16, WRITE_4PIXELSHI16_FLIPPED, 4)
}
