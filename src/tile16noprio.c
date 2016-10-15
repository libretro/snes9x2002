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

extern uint8 ConvertTile(uint8* pCache, uint32 TileAddr);

// DrawTile16 -----------------------------------------
void DrawTile16NoPrio(uint32 Tile, uint32 Offset, uint32 StartLine, uint32 LineCount)
{
   TILE_PREAMBLE

   if (Tile & V_FLIP)
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
#define FN(p, p2, p3, p4)  \
         "	ldrb	r9, [%[bp], #" p "]		\n"\
         "	ldrb	r8, [%[bp], #" p3 "]		\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p "]	\n"\
         "	strneh	r9, [%[screen], #" p2 "]	\n"\
         "3:						\n"\
         "	movs	r9, r8, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p3 "]	\n"\
         "	strneh	r9, [%[screen], #" p4 "]	\n"\
         "3:						\n"

            FN("0", "0", "1", "2")
            FN("2", "4", "3", "6")
            FN("4", "8", "5", "10")
            FN("6", "12", "7", "14")
            // Loop
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
            [bp] "r"(pCache + 56 - StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
#define FN1(p, p2, p3, p4, p5, p6)  \
         "	ldrb	r9, [%[bp], #" p3 "]		\n"\
         "	ldrb	r8, [%[bp], #" p6 "]		\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p "]	\n"\
         "	strneh	r9, [%[screen], #" p2 "]	\n"\
         "3:						\n"\
         "	movs	r9, r8, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p4 "]	\n"\
         "	strneh	r9, [%[screen], #" p5 "]	\n"\
         "3:						\n"

            FN1("0", "0", "7", "1", "2", "6")
            FN1("2", "4", "5", "3", "6", "4")
            FN1("4", "8", "3", "5", "10", "2")
            FN1("6", "12", "1", "7", "14", "0")
            // Loop
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
            FN("0", "0", "1", "2")
            FN("2", "4", "3", "6")
            FN("4", "8", "5", "10")
            FN("6", "12", "7", "14")
            // Loop
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
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:						\n"
            FN1("0", "0", "7", "1", "2", "6")
            FN1("2", "4", "5", "3", "6", "4")
            FN1("4", "8", "3", "5", "10", "2")
            FN1("6", "12", "1", "7", "14", "0")
            // Loop
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
            [bp] "r"(pCache + StartLine)
            // clobbered
            : "r9", "r8", "cc" // r8 & flags
         );

      }
   }
#undef FN
#undef FN1

}

// DrawClippedTile16NoPrio -----------------------------------------
void DrawClippedTile16NoPrio(uint32 Tile, uint32 Offset,
                             uint32 StartPixel, uint32 Width,
                             uint32 StartLine, uint32 LineCount)
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
#define FN(p)  \
         "	ldrb	r9, [%[bp], #" p "]		\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p "]	\n"\
         "	strneh	r9, [%[screen], #(" p " * 2)]	\n"\
         "3:						\n"

#define C(p)      "	cmp	%[width], #(" p  " + 1)		\n"\
         "	beq	1f				\n"

            FN("0")
            C("0")
            FN("1")
            C("1")
            FN("2")
            C("2")
            FN("3")
            C("3")
            FN("4")
            C("4")
            FN("5")
            C("5")
            FN("6")
            C("6")
            FN("7")
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
            : "r9", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
#define FN1(p)  \
         "	ldrb	r9, [%[bp], #(7 - " p ")]	\n"\
         "	movs	r9, r9, lsl #2			\n"\
         "	ldrne	r9, [%[colors], r9]		\n"\
         "	strneb	%[gfx_z2], [%[depth], #" p "]	\n"\
         "	strneh	r9, [%[screen], #(" p " * 2)]	\n"\
         "3:						\n"\

            FN1("0")
            C("0")
            FN1("1")
            C("1")
            FN1("2")
            C("2")
            FN1("3")
            C("3")
            FN1("4")
            C("4")
            FN1("5")
            C("5")
            FN1("6")
            C("6")
            FN1("7")
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
            : "r9", "cc" // r8 & flags
         );
      }
   }
   else
   {
      if (!(Tile & H_FLIP))
      {
         __asm__ volatile(
            "2:					\n"
            FN("0")
            C("0")
            FN("1")
            C("1")
            FN("2")
            C("2")
            FN("3")
            C("3")
            FN("4")
            C("4")
            FN("5")
            C("5")
            FN("6")
            C("6")
            FN("7")
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
            : "r9", "cc" // r8 & flags
         );
      }
      else
      {
         __asm__ volatile(
            "2:					\n"
            FN1("0")
            C("0")
            FN1("1")
            C("1")
            FN1("2")
            C("2")
            FN1("3")
            C("3")
            FN1("4")
            C("4")
            FN1("5")
            C("5")
            FN1("6")
            C("6")
            FN1("7")
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
            : "r9", "cc" // r8 & flags
         );

      }
   }
#undef FN
#undef FN1
#undef C

}

