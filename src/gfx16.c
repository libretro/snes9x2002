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
#include "snes9x.h"

#include "memmap.h"
#include "ppu.h"
#include "cpuexec.h"
#include "display.h"
#include "gfx.h"
#include "apu.h"
#include "cheats.h"
#include <stdint.h>
#include "asmmemfuncs.h"
#include "mode7.h"
#include "rops.h"
#include "tile16.h"
uint32 TileBlank;

//#define __DEBUG__

#ifdef __DEBUG__
#define DBG(b) printf(b)
#else
#define DBG(b)
#endif


const int tx_table[16] =
{
   // t1 = 16, t2 =  0
   // FLIP = 0x00
   16     + 0, // 0x00
   16     + 1, // 0x01

   // FLIP = 0x01
   16 + 1 - 0, // 0x02
   16 + 1 - 1, // 0x03

   // FLIP = 0x02
   0     + 0, // 0x04
   0     + 1, // 0x05

   // FLIP = 0x03
   0 + 1 - 0, // 0x06
   0 + 1 - 1, // 0x07

   // t1 =  0, t2 = 16
   // FLIP = 0x00
   0     + 0, // 0x08
   0     + 1, // 0x09

   // FLIP = 0x01
   0 + 1 - 0, // 0x0A
   0 + 1 - 1, // 0x0B

   // FLIP = 0x02
   16     + 0, // 0x0C
   16     + 1, // 0x0D

   // FLIP = 0x03
   16 + 1 - 0, // 0x0E
   16 + 1 - 1  // 0x0F
};

#define M7 19
#define M8 19

void ComputeClipWindows();

extern uint8 BitShifts[8][4];
extern uint8 TileShifts[8][4];
extern uint8 PaletteShifts[8][4];
extern uint8 PaletteMasks[8][4];
extern uint8 Depths[8][4];
extern uint8 BGSizes [2];

extern NormalTileRenderer DrawTilePtr;
extern ClippedTileRenderer DrawClippedTilePtr;
extern NormalTileRenderer DrawHiResTilePtr;
extern ClippedTileRenderer DrawHiResClippedTilePtr;
extern LargePixelRenderer DrawLargePixelPtr;

extern SBG BG;

extern SLineData LineData[240];
extern SLineMatrixData LineMatrixData [240];

extern uint8  Mode7Depths [2];

#define ON_MAIN(N) (GFX.r212c & (1 << (N)))

#define SUB_OR_ADD(N) \
(GFX.r2131 & (1 << (N)))

#define ON_SUB(N) \
((GFX.r2130 & 0x30) != 0x30 && \
 (GFX.r2130 & 2) && \
 (GFX.r212d & (1 << N)))

#define ANYTHING_ON_SUB \
((GFX.r2130 & 0x30) != 0x30 && \
 (GFX.r2130 & 2) && \
 (GFX.r212d & 0x1f))

#define ADD_OR_SUB_ON_ANYTHING \
(GFX.r2131 & 0x3f)

#define BLACK BUILD_PIXEL(0,0,0)

void DrawNoZTile16(uint32 Tile, uint32 Offset, uint32 StartLine, uint32 LineCount);
void DrawTile16(uint32 Tile, uint32 Offset, uint32 StartLine,
                uint32 LineCount);
void DrawClippedTile16(uint32 Tile, uint32 Offset,
                       uint32 StartPixel, uint32 Width,
                       uint32 StartLine, uint32 LineCount);
void DrawTile16x2(uint32 Tile, uint32 Offset, uint32 StartLine,
                  uint32 LineCount);
void DrawClippedTile16x2(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Width,
                         uint32 StartLine, uint32 LineCount);
void DrawTile16x2x2(uint32 Tile, uint32 Offset, uint32 StartLine,
                    uint32 LineCount);
void DrawClippedTile16x2x2(uint32 Tile, uint32 Offset,
                           uint32 StartPixel, uint32 Width,
                           uint32 StartLine, uint32 LineCount);
void DrawLargePixel16(uint32 Tile, uint32 Offset,
                      uint32 StartPixel, uint32 Pixels,
                      uint32 StartLine, uint32 LineCount);

void DrawNoZTile16Add(uint32 Tile, uint32 Offset, uint32 StartLine,
                      uint32 LineCount);

void DrawTile16Add(uint32 Tile, uint32 Offset, uint32 StartLine,
                   uint32 LineCount);

void DrawClippedTile16Add(uint32 Tile, uint32 Offset,
                          uint32 StartPixel, uint32 Width,
                          uint32 StartLine, uint32 LineCount);

void DrawNoZTile16Add1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                         uint32 LineCount);

void DrawTile16Add1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                      uint32 LineCount);

void DrawClippedTile16Add1_2(uint32 Tile, uint32 Offset,
                             uint32 StartPixel, uint32 Width,
                             uint32 StartLine, uint32 LineCount);

void DrawTile16FixedAdd1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                           uint32 LineCount);

void DrawClippedTile16FixedAdd1_2(uint32 Tile, uint32 Offset,
                                  uint32 StartPixel, uint32 Width,
                                  uint32 StartLine, uint32 LineCount);

void DrawNoZTile16Sub(uint32 Tile, uint32 Offset, uint32 StartLine,
                      uint32 LineCount);


void DrawTile16Sub(uint32 Tile, uint32 Offset, uint32 StartLine,
                   uint32 LineCount);

void DrawClippedTile16Sub(uint32 Tile, uint32 Offset,
                          uint32 StartPixel, uint32 Width,
                          uint32 StartLine, uint32 LineCount);

void DrawNoZTile16Sub1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                         uint32 LineCount);


void DrawTile16Sub1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                      uint32 LineCount);

void DrawClippedTile16Sub1_2(uint32 Tile, uint32 Offset,
                             uint32 StartPixel, uint32 Width,
                             uint32 StartLine, uint32 LineCount);

void DrawTile16FixedSub1_2(uint32 Tile, uint32 Offset, uint32 StartLine,
                           uint32 LineCount);

void DrawClippedTile16FixedSub1_2(uint32 Tile, uint32 Offset,
                                  uint32 StartPixel, uint32 Width,
                                  uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Add(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Add1_2(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Sub(uint32 Tile, uint32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Sub1_2(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount);

void DrawHiResClippedTile16(uint32 Tile, uint32 Offset,
                            uint32 StartPixel, uint32 Width,
                            uint32 StartLine, uint32 LineCount);

void DrawHiResTile16(uint32 Tile, uint32 Offset,
                     uint32 StartLine, uint32 LineCount);

bool8_32 S9xGraphicsInit()
{
   uint32 r, g, b;
   uint32 PixelOdd = 1;
   uint32 PixelEven = 2;

#ifdef GFX_MULTI_FORMAT
   if (GFX.BuildPixel == NULL)
      S9xSetRenderPixelFormat(RGB565);
#endif

   uint8 bitshift;
   for (bitshift = 0; bitshift < 4; bitshift++)
   {
      int i;
      for (i = 0; i < 16; i++)
      {
         uint32 h = 0;
         uint32 l = 0;

#if defined(MSB_FIRST)
         if (i & 8)
            h |= (PixelOdd << 24);
         if (i & 4)
            h |= (PixelOdd << 16);
         if (i & 2)
            h |= (PixelOdd << 8);
         if (i & 1)
            h |= PixelOdd;
         if (i & 8)
            l |= (PixelOdd << 24);
         if (i & 4)
            l |= (PixelOdd << 16);
         if (i & 2)
            l |= (PixelOdd << 8);
         if (i & 1)
            l |= PixelOdd;
#else
         // Wiz usa 
         if (i & 8)
            h |= PixelOdd;
         if (i & 4)
            h |= PixelOdd << 8;
         if (i & 2)
            h |= PixelOdd << 16;
         if (i & 1)
            h |= PixelOdd << 24;
         if (i & 8)
            l |= PixelOdd;
         if (i & 4)
            l |= PixelOdd << 8;
         if (i & 2)
            l |= PixelOdd << 16;
         if (i & 1)
            l |= PixelOdd << 24;
#endif

         odd_high[bitshift][i] = h;
         odd_low[bitshift][i] = l;
         h = l = 0;

#if defined(MSB_FIRST)
         if (i & 8)
            h |= (PixelEven << 24);
         if (i & 4)
            h |= (PixelEven << 16);
         if (i & 2)
            h |= (PixelEven << 8);
         if (i & 1)
            h |= PixelEven;
         if (i & 8)
            l |= (PixelEven << 24);
         if (i & 4)
            l |= (PixelEven << 16);
         if (i & 2)
            l |= (PixelEven << 8);
         if (i & 1)
            l |= PixelEven;
#else
         if (i & 8)
            h |= PixelEven;
         if (i & 4)
            h |= PixelEven << 8;
         if (i & 2)
            h |= PixelEven << 16;
         if (i & 1)
            h |= PixelEven << 24;
         if (i & 8)
            l |= PixelEven;
         if (i & 4)
            l |= PixelEven << 8;
         if (i & 2)
            l |= PixelEven << 16;
         if (i & 1)
            l |= PixelEven << 24;
#endif

         even_high[bitshift][i] = h;
         even_low[bitshift][i] = l;
      }
      PixelEven <<= 2;
      PixelOdd <<= 2;
   }

   GFX.Delta = (GFX.SubScreen - GFX.Screen) >> 1;
   GFX.DepthDelta = GFX.SubZBuffer - GFX.ZBuffer;
   //GFX.InfoStringTimeout = 0;
   //GFX.InfoString = NULL;

   PPU.BG_Forced = 0;
   IPPU.OBJChanged = TRUE;

   IPPU.DirectColourMapsNeedRebuild = TRUE;
   DrawTilePtr = DrawTile16;
   DrawClippedTilePtr = DrawClippedTile16;
   DrawLargePixelPtr = DrawLargePixel16;
   DrawHiResTilePtr = DrawHiResTile16;
   DrawHiResClippedTilePtr = DrawHiResClippedTile16;
   S9xFixColourBrightness();

#if defined(USE_OLD_COLOUR_OPS)
   /* Pre-1.60 colour operations */
   if (!(GFX.X2 = (uint16*) malloc(sizeof(uint16) * 0x10000)))
      return (FALSE);

   if (!(GFX.ZERO_OR_X2 = (uint16*) malloc(sizeof(uint16) * 0x10000)) ||
         !(GFX.ZERO = (uint16*) malloc(sizeof(uint16) * 0x10000)))
   {
      if (GFX.ZERO_OR_X2)
      {
         free((char*) GFX.ZERO_OR_X2);
         GFX.ZERO_OR_X2 = NULL;
      }
      if (GFX.X2)
      {
         free((char*) GFX.X2);
         GFX.X2 = NULL;
      }
      return (FALSE);
   }

   // Build a lookup table that multiplies a packed RGB value by 2 with
   // saturation.
   for (r = 0; r <= MAX_RED; r++)
   {
      uint32 r2 = r << 1;
      if (r2 > MAX_RED)
         r2 = MAX_RED;
      for (g = 0; g <= MAX_GREEN; g++)
      {
         uint32 g2 = g << 1;
         if (g2 > MAX_GREEN)
            g2 = MAX_GREEN;
         for (b = 0; b <= MAX_BLUE; b++)
         {
            uint32 b2 = b << 1;
            if (b2 > MAX_BLUE)
               b2 = MAX_BLUE;
            GFX.X2 [BUILD_PIXEL2(r, g, b)] = BUILD_PIXEL2(r2, g2, b2);
            GFX.X2 [BUILD_PIXEL2(r, g, b) & ~ALPHA_BITS_MASK] = BUILD_PIXEL2(r2, g2, b2);
         }
      }
   }
   memset(GFX.ZERO, 0, 0x10000 * sizeof(uint16));
   memset(GFX.ZERO_OR_X2, 0, 0x10000 * sizeof(uint16));
   // Build a lookup table that if the top bit of the color value is zero
   // then the value is zero, otherwise multiply the value by 2. Used by
   // the color subtraction code.

#if defined(OLD_COLOUR_BLENDING)
   for (r = 0; r <= MAX_RED; r++)
   {
      uint32 r2 = r;
      if ((r2 & 0x10) == 0)
         r2 = 0;
      else
         r2 = (r2 << 1) & MAX_RED;

      for (g = 0; g <= MAX_GREEN; g++)
      {
         uint32 g2 = g;
         if ((g2 & GREEN_HI_BIT) == 0)
            g2 = 0;
         else
            g2 = (g2 << 1) & MAX_GREEN;

         for (b = 0; b <= MAX_BLUE; b++)
         {
            uint32 b2 = b;
            if ((b2 & 0x10) == 0)
               b2 = 0;
            else
               b2 = (b2 << 1) & MAX_BLUE;

            GFX.ZERO_OR_X2 [BUILD_PIXEL2(r, g, b)] = BUILD_PIXEL2(r2, g2, b2);
            GFX.ZERO_OR_X2 [BUILD_PIXEL2(r, g, b) & ~ALPHA_BITS_MASK] = BUILD_PIXEL2(r2, g2, b2);
         }
      }
   }
#else
   for (r = 0; r <= MAX_RED; r++)
   {
      uint32 r2 = r;
      if ((r2 & 0x10) == 0)
         r2 = 0;
      else
         r2 = (r2 << 1) & MAX_RED;

      if (r2 == 0)
         r2 = 1;
      for (g = 0; g <= MAX_GREEN; g++)
      {
         uint32 g2 = g;
         if ((g2 & GREEN_HI_BIT) == 0)
            g2 = 0;
         else
            g2 = (g2 << 1) & MAX_GREEN;

         if (g2 == 0)
            g2 = 1;
         for (b = 0; b <= MAX_BLUE; b++)
         {
            uint32 b2 = b;
            if ((b2 & 0x10) == 0)
               b2 = 0;
            else
               b2 = (b2 << 1) & MAX_BLUE;

            if (b2 == 0)
               b2 = 1;
            GFX.ZERO_OR_X2 [BUILD_PIXEL2(r, g, b)] = BUILD_PIXEL2(r2, g2, b2);
            GFX.ZERO_OR_X2 [BUILD_PIXEL2(r, g, b) & ~ALPHA_BITS_MASK] = BUILD_PIXEL2(r2, g2, b2);
         }
      }
   }
#endif
#else
   if (!(GFX.ZERO = (uint16_t*) malloc(sizeof(uint16_t) * 0x10000)))
      return false;
#endif

   // Build a lookup table that if the top bit of the color value is zero
   // then the value is zero, otherwise its just the value.
   for (r = 0; r <= MAX_RED; r++)
   {
      uint32 r2 = r;
      if ((r2 & 0x10) == 0)
         r2 = 0;
      else
         r2 &= ~0x10;

      for (g = 0; g <= MAX_GREEN; g++)
      {
         uint32 g2 = g;
         if ((g2 & GREEN_HI_BIT) == 0)
            g2 = 0;
         else
            g2 &= ~GREEN_HI_BIT;
         for (b = 0; b <= MAX_BLUE; b++)
         {
            uint32 b2 = b;
            if ((b2 & 0x10) == 0)
               b2 = 0;
            else
               b2 &= ~0x10;

            GFX.ZERO [BUILD_PIXEL2(r, g, b)] = BUILD_PIXEL2(r2, g2, b2);
            GFX.ZERO [BUILD_PIXEL2(r, g, b) & ~ALPHA_BITS_MASK] = BUILD_PIXEL2(r2, g2, b2);
         }
      }
   }

   return (TRUE);
}

void S9xGraphicsDeinit(void)
{
   // Free any memory allocated in S9xGraphicsInit
#if defined(USE_OLD_COLOUR_OPS)
   /* Pre-1.60 colour operations */
   if (GFX.X2)
   {
      free((char*) GFX.X2);
      GFX.X2 = NULL;
   }
   if (GFX.ZERO_OR_X2)
   {
      free((char*) GFX.ZERO_OR_X2);
      GFX.ZERO_OR_X2 = NULL;
   }
#endif
   if (GFX.ZERO)
   {
      free((char*) GFX.ZERO);
      GFX.ZERO = NULL;
   }
}

void S9xBuildDirectColourMaps()
{
   uint32 p;
   for (p = 0; p < 8; p++)
   {
      uint32 c;
      for (c = 0; c < 256; c++)
      {
         // XXX: Brightness
         /*
          DirectColourMaps [p][c] = BUILD_PIXEL (IPPU.XB[((c & 7) << 2) | ((p & 1) << 1)],
                        IPPU.XB[((c & 0x38) >> 1) | (p & 2)],
                        IPPU.XB[((c & 0xc0) >> 3) | (p & 4)]);
         */
         DirectColourMaps [p][c] = BUILD_PIXEL(((c & 7) << 2) | ((p & 1) << 1),
                                               ((c & 0x38) >> 1) | (p & 2),
                                               ((c & 0xc0) >> 3) | (p & 4));

      }
   }
   IPPU.DirectColourMapsNeedRebuild = FALSE;
}

void S9xStartScreenRefresh()
{
   RESET_ROPS(0);

   if (IPPU.RenderThisFrame)
   {
      IPPU.RenderedFramesCount++;
      IPPU.PreviousLine = IPPU.CurrentLine = 0;
      IPPU.MaxBrightness = PPU.Brightness;
      IPPU.LatchedBlanking = PPU.ForcedBlanking;
      IPPU.LatchedInterlace = (Memory.FillRAM[0x2133] & 1);
      IPPU.RenderedScreenWidth = 256;
      IPPU.RenderedScreenHeight = PPU.ScreenHeight;
      IPPU.DoubleWidthPixels = FALSE;

      PPU.RecomputeClipWindows = TRUE;
      PPU.BG[0].OffsetsChanged = 0;
      PPU.BG[1].OffsetsChanged = 0;
      PPU.BG[2].OffsetsChanged = 0;
      PPU.BG[3].OffsetsChanged = 0;
      GFX.DepthDelta = GFX.SubZBuffer - GFX.ZBuffer;
      GFX.Delta = (GFX.SubScreen - GFX.Screen) >> 1;
   }
   
   if (++IPPU.FrameCount == (uint32)Memory.ROMFramesPerSecond)
   {
      IPPU.DisplayedRenderedFrameCount = IPPU.RenderedFramesCount;
      IPPU.RenderedFramesCount = 0;
      IPPU.FrameCount = 0;
   }
}

void RenderLine(uint8 C)
{
   if (IPPU.RenderThisFrame)
   {

      LineData[C].BG[0].VOffset = PPU.BG[0].VOffset + 1;
      LineData[C].BG[0].HOffset = PPU.BG[0].HOffset;
      LineData[C].BG[1].VOffset = PPU.BG[1].VOffset + 1;
      LineData[C].BG[1].HOffset = PPU.BG[1].HOffset;

      //if (PPU.BGMode == 7)
      if ((Memory.FillRAM[0x2105] & 7) == 7)
      {
         SLineMatrixData* p = &LineMatrixData [C];
         p->MatrixA = PPU.MatrixA;
         p->MatrixB = PPU.MatrixB;
         p->MatrixC = PPU.MatrixC;
         p->MatrixD = PPU.MatrixD;
         p->CentreX = PPU.CentreX;
         p->CentreY = PPU.CentreY;
      }
      else
      {
         if (Settings.StarfoxHack && PPU.BG[2].VOffset == 0 &&
               PPU.BG[2].HOffset == 0xe000)
         {
            LineData[C].BG[2].VOffset = 0xe1;
            LineData[C].BG[2].HOffset = 0;
         }
         else
         {
            LineData[C].BG[2].VOffset = PPU.BG[2].VOffset + 1;
            LineData[C].BG[2].HOffset = PPU.BG[2].HOffset;
            LineData[C].BG[3].VOffset = PPU.BG[3].VOffset + 1;
            LineData[C].BG[3].HOffset = PPU.BG[3].HOffset;
         }

      }
      IPPU.CurrentLine = C + 1;
   }
}


void S9xEndScreenRefresh()
{
   IPPU.HDMAStarted = FALSE;

   //RC
   if (IPPU.RenderThisFrame)
   {
      FLUSH_REDRAW();
      //if (IPPU.ColorsChanged)
      //{
      IPPU.ColorsChanged = FALSE;
      //}

      S9xDeinitUpdate(IPPU.RenderedScreenWidth, IPPU.RenderedScreenHeight);
   }

#ifdef LAGFIX
   finishedFrame = true;
#endif

#ifndef RC_OPTIMIZED
   S9xApplyCheats();
#endif


#ifdef DEBUGGER
   if (CPU.Flags & FRAME_ADVANCE_FLAG)
   {
      if (ICPU.FrameAdvanceCount)
      {
         ICPU.FrameAdvanceCount--;
         IPPU.RenderThisFrame = TRUE;
         IPPU.FrameSkip = 0;
      }
      else
      {
         CPU.Flags &= ~FRAME_ADVANCE_FLAG;
         CPU.Flags |= DEBUG_MODE_FLAG;
      }
   }
#endif

   /*
      if (CPU.SRAMModified)
       {
         if (!CPU.AutoSaveTimer)
         {
            if (!(CPU.AutoSaveTimer = Settings.AutoSaveDelay * Memory.ROMFramesPerSecond))
            CPU.SRAMModified = FALSE;
         }
         else
         {
            if (!--CPU.AutoSaveTimer)
            {
               CPU.SRAMModified = FALSE;
            }
         }
       }
   */
}

void S9xSetInfoString(const char* string)
{
}



int TileRenderer;
TileRendererSet TileRenderers[] =
{
   {DrawTile16Add, DrawClippedTile16Add, DrawLargePixel16Add}, // 0 -> GFX.r2131:7 = 0, GFX.r2131:6 = 0, GFX.r2130:1 = 0
   {DrawTile16Add, DrawClippedTile16Add, DrawLargePixel16Add}, // 1 -> GFX.r2131:7 = 0, GFX.r2131:6 = 0, GFX.r2130:1 = 1
   {DrawTile16FixedAdd1_2, DrawClippedTile16FixedAdd1_2, DrawLargePixel16Add1_2}, // 2 -> GFX.r2131:7 = 0, GFX.r2131:6 = 1, GFX.r2130:1 = 0
   {DrawTile16Add1_2, DrawClippedTile16Add1_2, DrawLargePixel16Add1_2}, // 3 -> GFX.r2131:7 = 0, GFX.r2131:6 = 1, GFX.r2130:1 = 1
   {DrawTile16Sub, DrawClippedTile16Sub, DrawLargePixel16Sub}, // 4 -> GFX.r2131:7 = 1, GFX.r2131:6 = 0, GFX.r2130:1 = 0
   {DrawTile16Sub, DrawClippedTile16Sub, DrawLargePixel16Sub}, // 5 -> GFX.r2131:7 = 1, GFX.r2131:6 = 0, GFX.r2130:1 = 1
   {DrawTile16FixedSub1_2, DrawClippedTile16FixedSub1_2, DrawLargePixel16Sub1_2},  // 6 -> GFX.r2131:7 = 1, GFX.r2131:6 = 1, GFX.r2130:1 = 0
   {DrawTile16Sub1_2, DrawClippedTile16Sub1_2, DrawLargePixel16Sub1_2},  // 7 -> GFX.r2131:7 = 1, GFX.r2131:6 = 1, GFX.r2130:1 = 1
   {DrawTile16, DrawClippedTile16, DrawLargePixel16}  // 8 -> normal
};
#ifdef __FAST_OBJS__
TileRendererSet TileRenderersNoZ[] =
{
   {DrawNoZTile16Add, DrawClippedTile16Add, DrawLargePixel16Add}, // 0 -> GFX.r2131:7 = 0, GFX.r2131:6 = 0, GFX.r2130:1 = 0
   {DrawNoZTile16Add, DrawClippedTile16Add, DrawLargePixel16Add}, // 1 -> GFX.r2131:7 = 0, GFX.r2131:6 = 0, GFX.r2130:1 = 1
   {DrawTile16FixedAdd1_2, DrawClippedTile16FixedAdd1_2, DrawLargePixel16Add1_2}, // 2 -> GFX.r2131:7 = 0, GFX.r2131:6 = 1, GFX.r2130:1 = 0
   {DrawNoZTile16Add1_2, DrawClippedTile16Add1_2, DrawLargePixel16Add1_2}, // 3 -> GFX.r2131:7 = 0, GFX.r2131:6 = 1, GFX.r2130:1 = 1
   {DrawNoZTile16Sub, DrawClippedTile16Sub, DrawLargePixel16Sub}, // 4 -> GFX.r2131:7 = 1, GFX.r2131:6 = 0, GFX.r2130:1 = 0
   {DrawNoZTile16Sub, DrawClippedTile16Sub, DrawLargePixel16Sub}, // 5 -> GFX.r2131:7 = 1, GFX.r2131:6 = 0, GFX.r2130:1 = 1
   {DrawTile16FixedSub1_2, DrawClippedTile16FixedSub1_2, DrawLargePixel16Sub1_2},  // 6 -> GFX.r2131:7 = 1, GFX.r2131:6 = 1, GFX.r2130:1 = 0
   {DrawNoZTile16Sub1_2, DrawClippedTile16Sub1_2, DrawLargePixel16Sub1_2},  // 7 -> GFX.r2131:7 = 1, GFX.r2131:6 = 1, GFX.r2130:1 = 1
   {DrawNoZTile16, DrawClippedTile16, DrawLargePixel16}  // 8 -> normal
};
#endif
static INLINE void SelectTileRenderer(bool8_32 normal, bool NoZ)
{
   if (normal)
      TileRenderer = 8;
   else
      TileRenderer = (((GFX.r2131 >> 5) & 0x06) | ((GFX.r2130 >> 1) & 1));

#ifdef __DEBUG__
   char* TRName[] =
   {
      "Add", "Add", "FixedAdd1_2", "Add1_2",
      "Sub", "Sub", "FixedSub1_2", "Sub1_2",
      "Normal"
   };
   printf("SelectTileRenderer: %s\n", TRName[TileRenderer]);
#endif

#ifdef __FAST_OBJS__
   if (NoZ)
   {
      DrawTilePtr = TileRenderersNoZ[TileRenderer].Normal;
      DrawClippedTilePtr = TileRenderersNoZ[TileRenderer].Clipped;
      DrawLargePixelPtr = TileRenderersNoZ[TileRenderer].Large;
   }
   else
   {
#endif
      DrawTilePtr = TileRenderers[TileRenderer].Normal;
      DrawClippedTilePtr = TileRenderers[TileRenderer].Clipped;
      DrawLargePixelPtr = TileRenderers[TileRenderer].Large;
#ifdef __FAST_OBJS__
   }
#endif
}

void S9xSetupOBJ()
{
   int SmallSize;
   int LargeSize;

   switch (PPU.OBJSizeSelect)
   {
   case 0:
      SmallSize = 8;
      LargeSize = 16;
      break;
   case 1:
      SmallSize = 8;
      LargeSize = 32;
      break;
   case 2:
      SmallSize = 8;
      LargeSize = 64;
      break;
   case 3:
      SmallSize = 16;
      LargeSize = 32;
      break;
   case 4:
      SmallSize = 16;
      LargeSize = 64;
      break;
   case 5:
   default:
      SmallSize = 32;
      LargeSize = 64;
      break;
   }

   int C = 0;

   int FirstSprite = PPU.FirstSprite & 0x7f;
   int S = FirstSprite;
   do
   {
      int Size;
      if (PPU.OBJ [S].Size)
         Size = LargeSize;
      else
         Size = SmallSize;

      long VPos = PPU.OBJ [S].VPos;

      if (VPos >= PPU.ScreenHeight)
         VPos -= 256;
      if (PPU.OBJ [S].HPos < 256 && PPU.OBJ [S].HPos > -Size &&
            VPos < PPU.ScreenHeight && VPos > -Size)
      {
#ifndef __FAST_OBJS__
         GFX.OBJList[C++] = S;
#else
         int x = 0;
         int a, b;
         // -- Sort objects (from low to high priority)
         while (x < C)
         {
            a = GFX.OBJList[x];
            if (PPU.OBJ[a].Priority >= PPU.OBJ[S].Priority) break;
            x++;
         }

         GFX.OBJList[x] = S;
         x++;
         C++;

         while (x < C)
         {
            b = GFX.OBJList[x];
            GFX.OBJList[x] = a;
            a = b;
            x++;
         }
#endif
         // --
         GFX.Sizes[S] = Size;
         GFX.VPositions[S] = VPos;
      }
      S = (S + 1) & 0x7f;
   }
   while (S != FirstSprite);

   // Terminate the list
   GFX.OBJList [C] = -1;
   IPPU.OBJChanged = FALSE;
}

void DrawOBJS(bool8_32 OnMain, uint8 D)
{
   int bg_ta_ns;
   int bg_ta;
   uint32 O;
   uint32 BaseTile, Tile;

   BG.BitShift = 4;
   SelectConvertTile();
   BG.TileShift = 5;
   //BG.TileAddress = PPU.OBJNameBase;
   BG.StartPalette = 128;
   BG.PaletteShift = 4;
   BG.PaletteMask = 7;
   BG.Buffer = IPPU.TileCache [TILE_4BIT];
   BG.Buffered = IPPU.TileCached [TILE_4BIT];
   //BG.NameSelect = PPU.OBJNameSelect;
   BG.DirectColourMode = FALSE;

   SelectPalette();
   bg_ta = PPU.OBJNameBase;
   bg_ta_ns = bg_ta + PPU.OBJNameSelect;

   GFX.Z1 = D + 2;

   DBG("Draw Objects.\n");

   int I = 0;
   int S;
   for (S = GFX.OBJList [I++]; S >= 0; S = GFX.OBJList [I++])
   {
      int VPos = GFX.VPositions [S];
      int Size = GFX.Sizes[S];
      int TileInc = 1;
      int Offset;

      if (VPos + Size <= (int) GFX.StartY || VPos > (int) GFX.EndY)
         continue;

      if (OnMain && SUB_OR_ADD(4))
      {
#ifndef __FAST_OBJS__
         SelectTileRenderer(!GFX.Pseudo && PPU.OBJ [S].Palette < 4, false);
#else
         SelectTileRenderer(!GFX.Pseudo && PPU.OBJ [S].Palette < 4, true);
#endif
      }

      BaseTile = PPU.OBJ[S].Name | (PPU.OBJ[S].Palette << 10);

      if (PPU.OBJ[S].HFlip)
      {
         BaseTile += ((Size >> 3) - 1) | H_FLIP;
         TileInc = -1;
      }

      if (PPU.OBJ[S].VFlip) BaseTile |= V_FLIP;
      //BaseTile |= PPU.OBJ[S].VFlip << 15;

      int clipcount = GFX.pCurrentClip->Count [4];
      if (!clipcount) clipcount = 1;

      GFX.Z2 = (PPU.OBJ[S].Priority + 1) * 4 + D;

      int clip;
      for (clip = 0; clip < clipcount; clip++)
      {
         int Left;
         int Right;
         if (!GFX.pCurrentClip->Count [4])
         {
            Left = 0;
            Right = 256;
         }
         else
         {
            Left = GFX.pCurrentClip->Left [clip][4];
            Right = GFX.pCurrentClip->Right [clip][4];
         }

         if (Right <= Left || PPU.OBJ[S].HPos + Size <= Left ||
               PPU.OBJ[S].HPos >= Right)
            continue;

         int Y;
         for (Y = 0; Y < Size; Y += 8)
         {
            if (VPos + Y + 7 >= (int) GFX.StartY && VPos + Y <= (int) GFX.EndY)
            {
               int StartLine;
               int TileLine;
               int LineCount;
               int Last;

               if ((StartLine = VPos + Y) < (int) GFX.StartY)
               {
                  StartLine = GFX.StartY - StartLine;
                  LineCount = 8 - StartLine;
               }
               else
               {
                  StartLine = 0;
                  LineCount = 8;
               }
               if ((Last = VPos + Y + 7 - GFX.EndY) > 0)
                  if ((LineCount -= Last) <= 0)
                     break;

               TileLine = StartLine << 3;

               O = (VPos + Y + StartLine) * GFX_PPL;
               if (!PPU.OBJ[S].VFlip) Tile = BaseTile + (Y << 1);
               else Tile = BaseTile + ((Size - Y - 8) << 1);

               if (Tile & 0x100) BG.TileAddress = bg_ta_ns;
               else BG.TileAddress = bg_ta;

               int Middle = Size >> 3;
               if (PPU.OBJ[S].HPos < Left)
               {
                  Tile += ((Left - PPU.OBJ[S].HPos) >> 3) * TileInc;
                  Middle -= (Left - PPU.OBJ[S].HPos) >> 3;
                  O += Left * GFX_PIXSIZE;
                  if ((Offset = (Left - PPU.OBJ[S].HPos) & 7))
                  {
                     O -= Offset * GFX_PIXSIZE;
                     int W = 8 - Offset;
                     int Width = Right - Left;
                     if (W > Width) W = Width;
                     //if (Tile & 0x100) BG.TileAddress = bg_ta_ns;
                     //else BG.TileAddress = bg_ta;
                     (*DrawClippedTilePtr)(Tile, O, Offset, W, TileLine, LineCount);

                     if (W >= Width)
                        continue;
                     Tile += TileInc;
                     Middle--;
                     O += 8 * GFX_PIXSIZE;
                  }
               }
               else
                  O += PPU.OBJ[S].HPos * GFX_PIXSIZE;

               if (PPU.OBJ[S].HPos + Size >= Right)
               {
                  Middle -= ((PPU.OBJ[S].HPos + Size + 7) -
                             Right) >> 3;
                  Offset = (Right - (PPU.OBJ[S].HPos + Size)) & 7;
               }
               else
                  Offset = 0;

               int X;
               for (X = 0; X < Middle; X++, O += 8 * GFX_PIXSIZE,
                     Tile += TileInc)
               {
                  //if (Tile & 0x100) BG.TileAddress = bg_ta_ns;
                  //else BG.TileAddress = bg_ta;
                  (*DrawTilePtr)(Tile, O, TileLine, LineCount);
               }
               if (Offset)
               {
                  //if (Tile & 0x100) BG.TileAddress = bg_ta_ns;
                  //else BG.TileAddress = bg_ta;
                  (*DrawClippedTilePtr)(Tile, O, 0, Offset, TileLine, LineCount);
               }
            }
         }
      }
   }
}
void DrawBackgroundMosaic(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
#ifdef __DEBUG__
   printf("DrawBackgroundMosaic(%i, %i, %i, %i)\n", BGMode, bg, Z1, Z2);
#endif
   uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint8 depths [2] = {Z1, Z2};

   if (BGMode == 0)
      BG.StartPalette = bg << 5;
   else
      BG.StartPalette = 0;
   SelectPalette();

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   if (PPU.BG[bg].SCSize & 1)
      SC1 = SC0 + 1024;
   else
      SC1 = SC0;

   if (((uint8*)SC1 - Memory.VRAM) >= 0x10000)
      SC1 -= 0x08000;


   if (PPU.BG[bg].SCSize & 2)
      SC2 = SC1 + 1024;
   else
      SC2 = SC0;

   if (((uint8*)SC2 - Memory.VRAM) >= 0x10000)
      SC2 -= 0x08000;


   if (PPU.BG[bg].SCSize & 1)
      SC3 = SC2 + 1024;
   else
      SC3 = SC2;

   if (((uint8*)SC3 - Memory.VRAM) >= 0x10000)
      SC3 -= 0x08000;

   uint32 Lines;
   uint32 OffsetMask;
   uint32 OffsetShift;

   if (BG.TileSize == 16)
   {
      OffsetMask = 0x3ff;
      OffsetShift = 4;
   }
   else
   {
      OffsetMask = 0x1ff;
      OffsetShift = 3;
   }

   uint32 Y;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      uint32 VOffset = LineData [Y].BG[bg].VOffset;
      uint32 HOffset = LineData [Y].BG[bg].HOffset;
      uint32 MosaicOffset = Y % PPU.Mosaic;

      for (Lines = 1; Lines < PPU.Mosaic - MosaicOffset; Lines++)
         if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [Y + Lines].BG[bg].HOffset))
            break;

      uint32 MosaicLine = VOffset + Y - MosaicOffset;

      if (Y + Lines > GFX.EndY)
         Lines = GFX.EndY + 1 - Y;
      uint32 VirtAlign = (MosaicLine & 7) << 3;

      uint16* b1;
      uint16* b2;

      uint32 ScreenLine = MosaicLine >> OffsetShift;
      uint32 Rem16 = MosaicLine & 15;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;
      uint16* t;
      uint32 Left = 0;
      uint32 Right = 256;

      uint32 ClipCount = GFX.pCurrentClip->Count [bg];
      uint32 HPos = HOffset;
      uint32 PixWidth = PPU.Mosaic;

      if (!ClipCount)
         ClipCount = 1;

      uint32 clip;
      for (clip = 0; clip < ClipCount; clip++)
      {
         if (GFX.pCurrentClip->Count [bg])
         {
            Left = GFX.pCurrentClip->Left [clip][bg];
            Right = GFX.pCurrentClip->Right [clip][bg];
            uint32 r = Left % PPU.Mosaic;
            HPos = HOffset + Left;
            PixWidth = PPU.Mosaic - r;
         }
         uint32 s = Y * GFX_PPL + Left * GFX_PIXSIZE;
         uint32 x;
         for (x = Left; x < Right; x += PixWidth,
               s += PixWidth * GFX_PIXSIZE,
               HPos += PixWidth, PixWidth = PPU.Mosaic)
         {
            uint32 Quot = (HPos & OffsetMask) >> 3;

            if (x + PixWidth >= Right)
               PixWidth = Right - x;

            if (BG.TileSize == 8)
            {
               if (Quot > 31)
                  t = b2 + (Quot & 0x1f);
               else
                  t = b1 + Quot;
            }
            else
            {
               if (Quot > 63)
                  t = b2 + ((Quot >> 1) & 0x1f);
               else
                  t = b1 + (Quot >> 1);
            }

            Tile = READ_2BYTES(t);
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];

            // Draw tile...
            if (BG.TileSize != 8)
            {
               if (Tile & H_FLIP)
               {
                  // Horizontal flip, but what about vertical flip ?
                  if (Tile & V_FLIP)
                  {
                     // Both horzontal & vertical flip
                     if (Rem16 < 8)
                     {
                        (*DrawLargePixelPtr)(Tile + 17 - (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                     else
                     {
                        (*DrawLargePixelPtr)(Tile + 1 - (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                  }
                  else
                  {
                     // Horizontal flip only
                     if (Rem16 > 7)
                     {
                        (*DrawLargePixelPtr)(Tile + 17 - (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                     else
                     {
                        (*DrawLargePixelPtr)(Tile + 1 - (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                  }
               }
               else
               {
                  // No horizontal flip, but is there a vertical flip ?
                  if (Tile & V_FLIP)
                  {
                     // Vertical flip only
                     if (Rem16 < 8)
                     {
                        (*DrawLargePixelPtr)(Tile + 16 + (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                     else
                     {
                        (*DrawLargePixelPtr)(Tile + (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                  }
                  else
                  {
                     // Normal unflipped
                     if (Rem16 > 7)
                     {
                        (*DrawLargePixelPtr)(Tile + 16 + (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                     else
                     {
                        (*DrawLargePixelPtr)(Tile + (Quot & 1), s,
                                             HPos & 7, PixWidth,
                                             VirtAlign, Lines);
                     }
                  }
               }
            }
            else
               (*DrawLargePixelPtr)(Tile, s, HPos & 7, PixWidth,
                                    VirtAlign, Lines);
         }
      }
   }
}

void DrawBackgroundOffset(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
#ifdef __DEBUG__
   printf("DrawBackgroundOffset(%i, %i, %i, %i)\n", BGMode, bg, Z1, Z2);
#endif
   uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint16* BPS0;
   uint16* BPS1;
   uint16* BPS2;
   uint16* BPS3;
   uint32 Width;
   int VOffsetOffset = BGMode == 4 ? 0 : 32;
   uint8 depths [2] = {Z1, Z2};

   BG.StartPalette = 0;
   SelectPalette();

   BPS0 = (uint16*) &Memory.VRAM[PPU.BG[2].SCBase << 1];

   if (PPU.BG[2].SCSize & 1)
      BPS1 = BPS0 + 1024;
   else
      BPS1 = BPS0;

   if (PPU.BG[2].SCSize & 2)
      BPS2 = BPS1 + 1024;
   else
      BPS2 = BPS0;

   if (PPU.BG[2].SCSize & 1)
      BPS3 = BPS2 + 1024;
   else
      BPS3 = BPS2;

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   if (PPU.BG[bg].SCSize & 1)
      SC1 = SC0 + 1024;
   else
      SC1 = SC0;

   if (((uint8*)SC1 - Memory.VRAM) >= 0x10000)
      SC1 -= 0x08000;


   if (PPU.BG[bg].SCSize & 2)
      SC2 = SC1 + 1024;
   else
      SC2 = SC0;

   if (((uint8*)SC2 - Memory.VRAM) >= 0x10000)
      SC2 -= 0x08000;


   if (PPU.BG[bg].SCSize & 1)
      SC3 = SC2 + 1024;
   else
      SC3 = SC2;

   if (((uint8*)SC3 - Memory.VRAM) >= 0x10000)
      SC3 -= 0x08000;

   static const int Lines = 1;
   int OffsetMask;
   int OffsetShift;
   int OffsetEnableMask = 1 << (bg + 13);

   if (BG.TileSize == 16)
   {
      OffsetMask = 0x3ff;
      OffsetShift = 4;
   }
   else
   {
      OffsetMask = 0x1ff;
      OffsetShift = 3;
   }

   TileBlank = 0xFFFFFFFF;
   uint32 Y;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y++)
   {
      uint32 VOff = LineData [Y].BG[2].VOffset - 1;
      uint32 HOff = LineData [Y].BG[2].HOffset;
      int VirtAlign;
      int ScreenLine = VOff >> 3;
      uint16* s0;
      uint16* s1;
      uint16* s2;
#ifdef __DEBUG__
      printf("Processing line: %d\n", Y);
#endif
      if (ScreenLine & 0x20)
         s1 = BPS2, s2 = BPS3;
      else
         s1 = BPS0, s2 = BPS1;

      s1 += (ScreenLine & 0x1f) << 5;
      s2 += (ScreenLine & 0x1f) << 5;

      if (BGMode != 4)
      {
         if ((ScreenLine & 0x1f) == 0x1f)
         {
            if (ScreenLine & 0x20)
               VOffsetOffset = BPS0 - BPS2 - 0x1f * 32;
            else
               VOffsetOffset = BPS2 - BPS0 - 0x1f * 32;
         }
         else
            VOffsetOffset = 32;
      }
      int clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;

      int clip;
      for (clip = 0; clip < clipcount; clip++)
      {
         uint32 Left;
         uint32 Right;
#ifdef __DEBUG__
         printf("Processing clip: %d/%d\n", clip, clipcount);
#endif

         if (!GFX.pCurrentClip->Count [bg])
         {
            Left = 0;
            Right = 256;
         }
         else
         {
            Left = GFX.pCurrentClip->Left [clip][bg];
            Right = GFX.pCurrentClip->Right [clip][bg];

            if (Right <= Left)
               continue;
         }

         uint32 VOffset;
         uint32 HOffset;
         uint32 LineHOffset = LineData [Y].BG[bg].HOffset;
         uint32 Offset;
         uint32 HPos;
         uint32 Quot;
         uint32 Count;
         uint16* t;
         uint32 Quot2;
         uint32 VCellOffset;
         uint32 HCellOffset;
         uint16* b1;
         uint16* b2;
         uint32 TotalCount = 0;
         uint32 MaxCount = 8;

         uint32 s = Left * GFX_PIXSIZE + Y * GFX_PPL;
         bool8_32 left_hand_edge = (Left == 0);
         Width = Right - Left;

         if (Left & 7)
            MaxCount = 8 - (Left & 7);

         while (Left < Right)
         {
#ifdef __DEBUG__
            printf("Left: %d, Right: %d\n", Left, Right);
#endif
            if (left_hand_edge)
            {
               // The SNES offset-per-tile background mode has a
               // hardware limitation that the offsets cannot be set
               // for the tile at the left-hand edge of the screen.
               VOffset = LineData [Y].BG[bg].VOffset;
               HOffset = LineHOffset;
               left_hand_edge = FALSE;
            }
            else
            {
               // All subsequent offset tile data is shifted left by one,
               // hence the - 1 below.
               Quot2 = ((HOff + Left - 1) & OffsetMask) >> 3;

               if (Quot2 > 31)
                  s0 = s2 + (Quot2 & 0x1f);
               else
                  s0 = s1 + Quot2;

               HCellOffset = READ_2BYTES(s0);

               if (BGMode == 4)
               {
                  VOffset = LineData [Y].BG[bg].VOffset;
                  HOffset = LineHOffset;
                  if ((HCellOffset & OffsetEnableMask))
                  {
                     if (HCellOffset & 0x8000)
                        VOffset = HCellOffset + 1;
                     else
                        HOffset = HCellOffset;
                  }
               }
               else
               {
                  VCellOffset = READ_2BYTES(s0 + VOffsetOffset);
                  if ((VCellOffset & OffsetEnableMask))
                     VOffset = VCellOffset + 1;
                  else
                     VOffset = LineData [Y].BG[bg].VOffset;

                  if ((HCellOffset & OffsetEnableMask))
                     HOffset = (HCellOffset & ~7) | (LineHOffset & 7);
                  else
                     HOffset = LineHOffset;
               }
            }
            VirtAlign = ((Y + VOffset) & 7) << 3;
            ScreenLine = (VOffset + Y) >> OffsetShift;

            int      tx_index;
            tx_index = (((VOffset + Y) & 15) <= 7) << 3;

            if (ScreenLine & 0x20)
               b1 = SC2, b2 = SC3;
            else
               b1 = SC0, b2 = SC1;

            b1 += (ScreenLine & 0x1f) << 5;
            b2 += (ScreenLine & 0x1f) << 5;

            HPos = (HOffset + Left) & OffsetMask;

            Quot = HPos >> 3;

            if (BG.TileSize == 8)
            {
               if (Quot > 31)
                  t = b2 + (Quot & 0x1f);
               else
                  t = b1 + Quot;
            }
            else
            {
               if (Quot > 63)
                  t = b2 + ((Quot >> 1) & 0x1f);
               else
                  t = b1 + (Quot >> 1);
            }

            if (MaxCount + TotalCount > Width)
               MaxCount = Width - TotalCount;

            Offset = HPos & 7;

            Count = 8 - Offset;
            if (Count > MaxCount)
               Count = MaxCount;

            s -= Offset * GFX_PIXSIZE;
            Tile = READ_2BYTES(t);
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];

            if (Tile != TileBlank)
               if (BG.TileSize == 8)
                  (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
               else
               {
                  Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13) + (Quot & 1)];
                  if (Tile != TileBlank)
                     (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
               }

            Left += Count;
            TotalCount += Count;
            s += (Offset + Count) * GFX_PIXSIZE;
            MaxCount = 8;
         }
      }
   }
}

void DrawBackgroundMode5(uint32 BGMODE, uint32 bg, uint8 Z1, uint8 Z2)
{
#ifdef __DEBUG__
   printf("DrawBackgroundMode5(?, %i, %i, %i)\n", bg, Z1, Z2);
#endif
   uint8 depths [2] = {Z1, Z2};

   uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint32 Width;

   BG.StartPalette = 0;
   SelectPalette();

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   if ((PPU.BG[bg].SCSize & 1))
      SC1 = SC0 + 1024;
   else
      SC1 = SC0;

   if ((SC1 - (unsigned short*)Memory.VRAM) > 0x10000)
      SC1 = (uint16*)&Memory.VRAM[(((uint8*)SC1) - Memory.VRAM) % 0x10000];

   if ((PPU.BG[bg].SCSize & 2))
      SC2 = SC1 + 1024;
   else SC2 = SC0;

   if (((uint8*)SC2 - Memory.VRAM) >= 0x10000)
      SC2 -= 0x08000;

   if ((PPU.BG[bg].SCSize & 1))
      SC3 = SC2 + 1024;
   else
      SC3 = SC2;

   if (((uint8*)SC3 - Memory.VRAM) >= 0x10000)
      SC3 -= 0x08000;
   int Lines;
   int VOffsetShift = 3;

   if (BG.TileSize == 16)
      VOffsetShift = 4;
   int endy = GFX.EndY;

   int Y;
   for (Y = GFX.StartY; Y <= endy; Y += Lines)
   {
      //int y = Y;
      uint32 VOffset = LineData [Y].BG[bg].VOffset;
      uint32 HOffset = LineData [Y].BG[bg].HOffset;
      int VirtAlign = (Y + VOffset) & 7;

      for (Lines = 1; Lines < 8 - VirtAlign; Lines++)
         if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [Y + Lines].BG[bg].HOffset))
            break;

      HOffset <<= 1;
      if (Y + Lines > endy)
         Lines = endy + 1 - Y;

      int ScreenLine = (VOffset + Y) >> VOffsetShift;
      int t1;
      int t2;
      if (((VOffset + Y) & 15) > 7)
      {
         t1 = 16;
         t2 = 0;
      }
      else
      {
         t1 = 0;
         t2 = 16;
      }
      uint16* b1;
      uint16* b2;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      int clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;
      int clip;
      for (clip = 0; clip < clipcount; clip++)
      {
         int Left;
         int Right;

         if (!GFX.pCurrentClip->Count [bg])
         {
            Left = 0;
            Right = 512;
         }
         else
         {
            Left = GFX.pCurrentClip->Left [clip][bg] * 2;
            Right = GFX.pCurrentClip->Right [clip][bg] * 2;

            if (Right <= Left)
               continue;
         }

         uint32 s = (Left >> 1) * GFX_PIXSIZE + Y * GFX_PPL;
         uint32 HPos = (HOffset + Left * GFX_PIXSIZE) & 0x3ff;

         uint32 Quot = HPos >> 3;
         uint32 Count = 0;

         uint16* t;
         if (Quot > 63)
            t = b2 + ((Quot >> 1) & 0x1f);
         else
            t = b1 + (Quot >> 1);

         Width = Right - Left;
         // Left hand edge clipped tile
         if (HPos & 7)
         {
            int Offset = (HPos & 7);
            Count = 8 - Offset;
            if (Count > Width)
               Count = Width;
            s -= (Offset >> 1);
            Tile = READ_2BYTES(t);
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];

            if (BG.TileSize == 8)
            {
               if (!(Tile & H_FLIP))
               {
                  // Normal, unflipped
                  (*DrawHiResClippedTilePtr)(Tile + (Quot & 1),
                                             s, Offset, Count, VirtAlign, Lines);
               }
               else
               {
                  // H flip
                  (*DrawHiResClippedTilePtr)(Tile + 1 - (Quot & 1),
                                             s, Offset, Count, VirtAlign, Lines);
               }
            }
            else
            {
               if (!(Tile & (V_FLIP | H_FLIP)))
               {
                  // Normal, unflipped
                  (*DrawHiResClippedTilePtr)(Tile + t1 + (Quot & 1),
                                             s, Offset, Count, VirtAlign, Lines);
               }
               else if (Tile & H_FLIP)
               {
                  if (Tile & V_FLIP)
                  {
                     // H & V flip
                     (*DrawHiResClippedTilePtr)(Tile + t2 + 1 - (Quot & 1),
                                                s, Offset, Count, VirtAlign, Lines);
                  }
                  else
                  {
                     // H flip only
                     (*DrawHiResClippedTilePtr)(Tile + t1 + 1 - (Quot & 1),
                                                s, Offset, Count, VirtAlign, Lines);
                  }
               }
               else
               {
                  // V flip only
                  (*DrawHiResClippedTilePtr)(Tile + t2 + (Quot & 1),
                                             s, Offset, Count, VirtAlign, Lines);
               }
            }

            t += Quot & 1;
            if (Quot == 63)
               t = b2;
            else if (Quot == 127)
               t = b1;
            Quot++;
            s += 4;
         }

         // Middle, unclipped tiles
         Count = Width - Count;
         int Middle = Count >> 3;
         Count &= 7;
         int C;
         for (C = Middle; C > 0; s += 4, Quot++, C--)
         {
            Tile = READ_2BYTES(t);
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
            if (BG.TileSize == 8)
            {
               if (!(Tile & H_FLIP))
               {
                  // Normal, unflipped
                  (*DrawHiResTilePtr)(Tile + (Quot & 1),
                                      s, VirtAlign, Lines);
               }
               else
               {
                  // H flip
                  (*DrawHiResTilePtr)(Tile + 1 - (Quot & 1),
                                      s, VirtAlign, Lines);
               }
            }
            else
            {
               if (!(Tile & (V_FLIP | H_FLIP)))
               {
                  // Normal, unflipped
                  (*DrawHiResTilePtr)(Tile + t1 + (Quot & 1),
                                      s, VirtAlign, Lines);
               }
               else if (Tile & H_FLIP)
               {
                  if (Tile & V_FLIP)
                  {
                     // H & V flip
                     (*DrawHiResTilePtr)(Tile + t2 + 1 - (Quot & 1),
                                         s, VirtAlign, Lines);
                  }
                  else
                  {
                     // H flip only
                     (*DrawHiResTilePtr)(Tile + t1 + 1 - (Quot & 1),
                                         s, VirtAlign, Lines);
                  }
               }
               else
               {
                  // V flip only
                  (*DrawHiResTilePtr)(Tile + t2 + (Quot & 1),
                                      s, VirtAlign, Lines);
               }
            }

            t += Quot & 1;
            if (Quot == 63)
               t = b2;
            else if (Quot == 127)
               t = b1;
         }

         // Right-hand edge clipped tiles
         if (Count)
         {
            Tile = READ_2BYTES(t);
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
            if (BG.TileSize == 8)
            {
               if (!(Tile & H_FLIP))
               {
                  // Normal, unflipped
                  (*DrawHiResClippedTilePtr)(Tile + (Quot & 1),
                                             s, 0, Count, VirtAlign, Lines);
               }
               else
               {
                  // H flip
                  (*DrawHiResClippedTilePtr)(Tile + 1 - (Quot & 1),
                                             s, 0, Count, VirtAlign, Lines);
               }
            }
            else
            {
               if (!(Tile & (V_FLIP | H_FLIP)))
               {
                  // Normal, unflipped
                  (*DrawHiResClippedTilePtr)(Tile + t1 + (Quot & 1),
                                             s, 0, Count, VirtAlign, Lines);
               }
               else if (Tile & H_FLIP)
               {
                  if (Tile & V_FLIP)
                  {
                     // H & V flip
                     (*DrawHiResClippedTilePtr)(Tile + t2 + 1 - (Quot & 1),
                                                s, 0, Count, VirtAlign, Lines);
                  }
                  else
                  {
                     // H flip only
                     (*DrawHiResClippedTilePtr)(Tile + t1 + 1 - (Quot & 1),
                                                s, 0, Count, VirtAlign, Lines);
                  }
               }
               else
               {
                  // V flip only
                  (*DrawHiResClippedTilePtr)(Tile + t2 + (Quot & 1),
                                             s, 0, Count, VirtAlign, Lines);
               }
            }
         }
      }
   }
}

void DrawBackground_8(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
#ifdef __DEBUG__
   printf("DrawBackground_8(%i, %i, %i, %i)\n", BGMode, bg, Z1, Z2);
#endif
   //uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint32 depths [2] = {Z1, Z2};

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   SC1 = SC0 + ((PPU.BG[bg].SCSize & 1) << 10);

   if (SC1 >= (unsigned short*)(Memory.VRAM + 0x10000)) SC1 = (uint16*)&Memory.VRAM[((uint8*)SC1 - &Memory.VRAM[0]) &
            0xffff];

   if (PPU.BG[bg].SCSize & 2)
      SC2 = SC1 + 1024;
   else
      SC2 = SC0;

   if (((uint8*)SC2 - Memory.VRAM) >= 0x10000)   SC2 -= 0x08000;

   SC3 = SC2 + ((PPU.BG[bg].SCSize & 1) << 10);

   if (((uint8*)SC3 - Memory.VRAM) >= 0x10000)   SC3 -= 0x08000;

   int Lines;

   int oc = PPU.BG[bg].OffsetsChanged;
   uint32 VOffset, HOffset;
   if (!oc)
   {
      VOffset = LineData [GFX.StartY].BG[bg].VOffset;
      HOffset = LineData [GFX.StartY].BG[bg].HOffset;
   }
   TileBlank = 0xFFFFFFFF;
   uint32 Y;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      int y_ppl = Y * GFX_PPL;
      if (oc)
      {
         VOffset = LineData [Y].BG[bg].VOffset;
         HOffset = LineData [Y].BG[bg].HOffset;
      }
      int VirtAlign = (Y + VOffset) & 7;

      int maxLines = GFX.EndY - Y + 1;
      if ((8 - VirtAlign) < maxLines) maxLines = (8 - VirtAlign);

      if (oc)
      {
         for (Lines = 1; Lines < maxLines; Lines++)
            if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
                  (HOffset != LineData [Y + Lines].BG[bg].HOffset))
               break;
      }
      else Lines = maxLines;

      VirtAlign <<= 3;

      uint32 ScreenLine = (VOffset + Y) >> 3;
      uint16* b1;
      uint16* b2;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      uint32 Left;
      uint32 Right;
      int clip = 0;
      int clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
      {
         Left = 0;
         Right = 256;
      }

      do
      {
         if (clipcount)
         {
            Left = GFX.pCurrentClip->Left [clip][bg];
            Right = GFX.pCurrentClip->Right [clip][bg];

            if (Right <= Left)
            {
               clip++;
               continue;
            }
         }

         uint32 s = Left + y_ppl;
         uint32 HPos = (HOffset + Left) & 0x1ff;
         uint32 Quot = HPos >> 3;
         uint32 Count = 0;
         uint16* t;
         uint16* b;

         if (Quot > 31)
         {
            t = b2 + (Quot & 0x1f);
            b = b1;
            Quot -= 32;
         }
         else
         {
            t = b1 +  Quot;
            b = b2;
         }

         uint32 Width = Right - Left;

         // Left hand edge clipped tile
         uint32 Offset = (HPos & 7);
         if (Offset)
         {
            Count = 8 - Offset;
            if (Count > Width) Count = Width;
            s -= Offset;
            //uint32 Tile = READ_2BYTES(t);
            uint32 Tile = *(t++);
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
            }
            //t++;
            if (Quot == 31)   t = b;
            //else if (Quot == 63)  t = b1;
            Quot++;
            s += 8;
         }

         // Middle, unclipped tiles
         Count = Width - Count;
         int C ;
         for (C = Count >> 3; C > 0; s += 8, Quot++, C--)
         {
            //uint32 Tile = READ_2BYTES(t);
            uint32 Tile = *(t++);
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawTilePtr)(Tile, s, VirtAlign, Lines);
            }

            //t++;
            if (Quot == 31)   t = b;
            //else if (Quot == 63)  t = b1;
         }

         // Right-hand edge clipped tiles
         if (Count & 7)
         {
            //uint32 Tile = READ_2BYTES(t);
            uint32 Tile = *t;
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, 0, Count & 7, VirtAlign, Lines);
            }
         }
         clip ++;
      }
      while (clip < clipcount);
   }
}

void DrawBackground_16(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
#ifdef __DEBUG__
   printf("DrawBackground_16(%i, %i, %i, %i)\n", BGMode, bg, Z1, Z2);
#endif
   //uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint32 depths [2] = {Z1, Z2};

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   SC1 = SC0 + ((PPU.BG[bg].SCSize & 1) << 10);

   if (SC1 >= (unsigned short*)(Memory.VRAM + 0x10000)) SC1 = (uint16*)&Memory.VRAM[((uint8*)SC1 - &Memory.VRAM[0]) &
            0xffff];

   if (PPU.BG[bg].SCSize & 2)
      SC2 = SC1 + 1024;
   else
      SC2 = SC0;

   if (((uint8*)SC2 - Memory.VRAM) >= 0x10000)   SC2 -= 0x08000;

   SC3 = SC2 + ((PPU.BG[bg].SCSize & 1) << 10);

   if (((uint8*)SC3 - Memory.VRAM) >= 0x10000)   SC3 -= 0x08000;

   int Lines;

   int oc = PPU.BG[bg].OffsetsChanged;
   uint32 VOffset, HOffset;
   if (!oc)
   {
      VOffset = LineData [GFX.StartY].BG[bg].VOffset;
      HOffset = LineData [GFX.StartY].BG[bg].HOffset;
   }

   TileBlank = 0xFFFFFFFF;
   unsigned int tb1 = 0xffffffff;
   unsigned int tb2 = 0xffffffff;
   uint32 Y ;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      int y_ppl = Y * GFX_PPL;
      if (oc)
      {
         VOffset = LineData [Y].BG[bg].VOffset;
         HOffset = LineData [Y].BG[bg].HOffset;
      }
      int VirtAlign = (Y + VOffset) & 7;

      int maxLines = GFX.EndY - Y + 1;
      if ((8 - VirtAlign) < maxLines) maxLines = (8 - VirtAlign);

      if (oc)
      {
         for (Lines = 1; Lines < maxLines; Lines++)
            if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
                  (HOffset != LineData [Y + Lines].BG[bg].HOffset))
               break;
      }
      else Lines = maxLines;

      VirtAlign <<= 3;

      uint32 ScreenLine = (VOffset + Y) >> 4;
      int    tx_index = (((VOffset + Y) & 15) <= 7) << 3;
      uint16* b1;
      uint16* b2;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      uint32 Left;
      uint32 Right;
      int clip = 0;
      int clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
      {
         Left = 0;
         Right = 256;
      }

      do
      {
         if (clipcount)
         {
            Left = GFX.pCurrentClip->Left [clip][bg];
            Right = GFX.pCurrentClip->Right [clip][bg];

            if (Right <= Left)
            {
               clip++;
               continue;
            }
         }

         uint32 s = Left + y_ppl;
         uint32 HPos = (HOffset + Left) & 0x3ff;
         uint32 Quot = HPos >> 3;
         uint32 Count = 0;
         uint16* t;
         uint16* b;

         if (Quot > 63)
         {
            t = b2 + ((Quot >> 1) & 0x1f);
            b = b1;
            Quot -= 64;
         }
         else
         {
            t = b1 + (Quot >> 1);
            b = b2;
         }


         uint32 Width = Right - Left;

         uint32 Tile;
         if (Quot & 1)
         {
            Tile = *(t++);
            Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13)];
            GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
         }

         // Left hand edge clipped tile
         uint32 Offset = (HPos & 7);
         if (Offset)
         {
            Count = 8 - Offset;
            if (Count > Width) Count = Width;
            s -= Offset;
            if (!(Quot & 1))
            {
               Tile = *(t++);
               Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13)];
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               if (Tile != tb1)
               {
                  (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
                  tb1 = TileBlank;
               }
            }
            else
            {
               if (Tile & H_FLIP) Tile--;
               else Tile++;
               if (Quot == 63) t = b;
               if (Tile != tb2)
               {
                  (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
                  tb2 = TileBlank;
               }
            }
            Quot++;
            s += 8;
         }

         // Middle, unclipped tiles
         Count = Width - Count;
         int C ;
         for (C = Count >> 3; C > 0; s += 8, Quot++, C--)
         {
            if (!(Quot & 1))
            {
               Tile = *(t++);
               Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13)];
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               if (Tile != tb1)
               {
                  (*DrawTilePtr)(Tile, s, VirtAlign, Lines);
                  tb1 = TileBlank;
               }
            }
            else
            {
               if (Tile & H_FLIP) Tile--;
               else Tile++;
               if (Quot == 63) t = b;
               if (Tile != tb2)
               {
                  (*DrawTilePtr)(Tile, s, VirtAlign, Lines);
                  tb2 = TileBlank;
               }
            }
         }

         // Right-hand edge clipped tiles
         if (Count & 7)
         {
            if (!(Quot & 1))
            {
               Tile = *(t++);
               Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13)];
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               if (Tile != tb1)(*DrawClippedTilePtr)(Tile, s, 0, Count & 7, VirtAlign, Lines);
            }
            else
            {
               if (Tile & H_FLIP) Tile--;
               else Tile++;
               if (Tile != tb2)(*DrawClippedTilePtr)(Tile, s, 0, Count & 7, VirtAlign, Lines);
            }
         }
         clip ++;
      }
      while (clip < clipcount);
   }
}


static INLINE void DrawBackground(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
   //StartAnalyze();

   BG.TileSize = BGSizes [PPU.BG[bg].BGSize];
   BG.BitShift = BitShifts[BGMode][bg];
   SelectConvertTile();
   BG.TileShift = TileShifts[BGMode][bg];
   BG.TileAddress = PPU.BG[bg].NameBase << 1;
   //BG.NameSelect = 0;
   BG.Buffer = IPPU.TileCache [Depths [BGMode][bg]];
   BG.Buffered = IPPU.TileCached [Depths [BGMode][bg]];
   BG.PaletteShift = PaletteShifts[BGMode][bg];
   BG.PaletteMask = PaletteMasks[BGMode][bg];
   BG.DirectColourMode = (BGMode == 3 || BGMode == 4) && bg == 0 && (GFX.r2130 & 1);

   DBG("Draw Background.\n");

   if (IPPU.DirectColourMapsNeedRebuild && BG.DirectColourMode) S9xBuildDirectColourMaps();

   if (PPU.BGMosaic [bg] && PPU.Mosaic > 1)
   {
      DrawBackgroundMosaic(BGMode, bg, Z1, Z2);
      return;

   }
   switch (BGMode)
   {
   case 2:
   case 4: // Used by Puzzle Bobble
      DrawBackgroundOffset(BGMode, bg, Z1, Z2);
      break;

   case 5:
   case 6: // XXX: is also offset per tile.
      DrawBackgroundMode5(BGMode, bg, Z1, Z2);
      break;
   case 0:
   case 1:
   case 3:
      if (BGMode == 0) BG.StartPalette = bg << 5;
      else BG.StartPalette = 0;
      SelectPalette();

      if (BG.TileSize == 8) DrawBackground_8(BGMode, bg, Z1, Z2);
      else DrawBackground_16(BGMode, bg, Z1, Z2);
      break;
   }
}

#define _BUILD_SETUP(F) \
GFX.BuildPixel = BuildPixel##F; \
GFX.BuildPixel2 = BuildPixel2##F; \
GFX.DecomposePixel = DecomposePixel##F; \
RED_LOW_BIT_MASK = RED_LOW_BIT_MASK_##F; \
GREEN_LOW_BIT_MASK = GREEN_LOW_BIT_MASK_##F; \
BLUE_LOW_BIT_MASK = BLUE_LOW_BIT_MASK_##F; \
RED_HI_BIT_MASK = RED_HI_BIT_MASK_##F; \
GREEN_HI_BIT_MASK = GREEN_HI_BIT_MASK_##F; \
BLUE_HI_BIT_MASK = BLUE_HI_BIT_MASK_##F; \
MAX_RED = MAX_RED_##F; \
MAX_GREEN = MAX_GREEN_##F; \
MAX_BLUE = MAX_BLUE_##F; \
GREEN_HI_BIT = ((MAX_GREEN_##F + 1) >> 1); \
SPARE_RGB_BIT_MASK = SPARE_RGB_BIT_MASK_##F; \
RGB_LOW_BITS_MASK = (RED_LOW_BIT_MASK_##F | \
           GREEN_LOW_BIT_MASK_##F | \
           BLUE_LOW_BIT_MASK_##F); \
RGB_HI_BITS_MASK = (RED_HI_BIT_MASK_##F | \
          GREEN_HI_BIT_MASK_##F | \
          BLUE_HI_BIT_MASK_##F); \
RGB_HI_BITS_MASKx2 = ((RED_HI_BIT_MASK_##F | \
             GREEN_HI_BIT_MASK_##F | \
             BLUE_HI_BIT_MASK_##F) << 1); \
RGB_REMOVE_LOW_BITS_MASK = ~RGB_LOW_BITS_MASK; \
FIRST_COLOR_MASK = FIRST_COLOR_MASK_##F; \
SECOND_COLOR_MASK = SECOND_COLOR_MASK_##F; \
THIRD_COLOR_MASK = THIRD_COLOR_MASK_##F; \
ALPHA_BITS_MASK = ALPHA_BITS_MASK_##F; \
FIRST_THIRD_COLOR_MASK = FIRST_COLOR_MASK | THIRD_COLOR_MASK; \
TWO_LOW_BITS_MASK = RGB_LOW_BITS_MASK | (RGB_LOW_BITS_MASK << 1); \
HIGH_BITS_SHIFTED_TWO_MASK = (( (FIRST_COLOR_MASK | SECOND_COLOR_MASK | THIRD_COLOR_MASK) & \
                                ~TWO_LOW_BITS_MASK ) >> 2);

void RenderScreen(uint8* Screen, bool8_32 sub, bool8_32 force_no_add, uint8 D)
{
   bool8_32 BG0;
   bool8_32 BG1;
   bool8_32 BG2;
   bool8_32 BG3;
   bool8_32 OB;

   GFX.S = Screen;

   if (!sub)
   {
      GFX.pCurrentClip = &IPPU.Clip [0];
      BG0 = ON_MAIN(0) && !(Settings.os9x_hack & GFX_IGNORE_BG0);
      BG1 = ON_MAIN(1) && !(Settings.os9x_hack & GFX_IGNORE_BG1);
      BG2 = ON_MAIN(2) && !(Settings.os9x_hack & GFX_IGNORE_BG2);
      BG3 = ON_MAIN(3) && !(Settings.os9x_hack & GFX_IGNORE_BG3);
      OB  = ON_MAIN(4) && !(Settings.os9x_hack & GFX_IGNORE_OBJ);
   }
   else
   {
      GFX.pCurrentClip = &IPPU.Clip [1];
      BG0 = ON_SUB(0) && !(Settings.os9x_hack & GFX_IGNORE_BG0);
      BG1 = ON_SUB(1) && !(Settings.os9x_hack & GFX_IGNORE_BG1);
      BG2 = ON_SUB(2) && !(Settings.os9x_hack & GFX_IGNORE_BG2);
      BG3 = ON_SUB(3) && !(Settings.os9x_hack & GFX_IGNORE_BG3);
      OB  = ON_SUB(4) && !(Settings.os9x_hack & GFX_IGNORE_OBJ);
   }

#ifdef __DEBUG__
   printf("Screen[y1,y2]:[%i,%i],Mode:%i, BG0:%i,BG1:%i,BG2:%i,BG3:%i,OBJ:%i\n", GFX.StartY, GFX.EndY, PPU.BGMode, BG0,
          BG1, BG2, BG3, OB);
#endif

   sub |= force_no_add;

   if (PPU.BGMode <= 1)
   {
      if (OB)
      {
#ifndef __FAST_OBJS__
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
#else
         SelectTileRenderer(sub || !SUB_OR_ADD(4), true);
#endif
         DrawOBJS(!sub, D);
      }
      if (BG0)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(0), false);
         DrawBackground(PPU.BGMode, 0, D + 10, D + 14);
      }
      if (BG1)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(1), false);
         DrawBackground(PPU.BGMode, 1, D + 9, D + 13);
      }
      if (BG2)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(2), false);
         DrawBackground(PPU.BGMode, 2, D + 3,
                        PPU.BG3Priority ? D + 17 : D + 6);
      }
      if (BG3 && PPU.BGMode == 0)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(3), false);
         DrawBackground(PPU.BGMode, 3, D + 2, D + 5);
      }
   }
   else if (PPU.BGMode != 7)
   {
      if (OB)
      {
#ifndef __FAST_OBJS__
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
#else
         SelectTileRenderer(sub || !SUB_OR_ADD(4), true);
#endif
         DrawOBJS(!sub, D);
      }
      if (BG0)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(0), false);
         DrawBackground(PPU.BGMode, 0, D + 5, D + 13);
      }
      if (PPU.BGMode != 6 && BG1)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(1), false);
         DrawBackground(PPU.BGMode, 1, D + 2, D + 9);
      }
   }
   else
   {
      if (OB && ((SNESGameFixes.Mode7Hack && D) || !SNESGameFixes.Mode7Hack))
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(4), true);
         DrawOBJS(!sub, D);
      }
      if (BG0 || ((Memory.FillRAM [0x2133] & 0x40) && BG1))
      {
         int bg;

         if ((Memory.FillRAM [0x2133] & 0x40) && BG1)
         {
            Mode7Depths [0] = (BG0 ? 5 : 1) + D;
            Mode7Depths [1] = 9 + D;
            bg = 1;
            if (sub || !SUB_OR_ADD(0))
               DrawBGMode7Background16Prio(Screen, bg);
            else
            {
               if (GFX.r2131 & 0x80)
               {
                  if (GFX.r2131 & 0x40)
                     DrawBGMode7Background16PrioSub1_2(Screen, bg);
                  else
                     DrawBGMode7Background16PrioSub(Screen, bg);
               }
               else
               {
                  if (GFX.r2131 & 0x40)
                     DrawBGMode7Background16PrioAdd1_2(Screen, bg);
                  else
                     DrawBGMode7Background16PrioAdd(Screen, bg);
               }
            }
         }
         else
         {
            bg = 0;
            if (sub || !SUB_OR_ADD(0))
            {
               if (D || !SNESGameFixes.Mode7Hack) DrawBGMode7Background16(Screen, bg, D + 5);
               else DrawBGMode7Background16New(Screen);
            }
            else
            {
               if (GFX.r2131 & 0x80)
               {
                  if (GFX.r2131 & 0x40)
                     DrawBGMode7Background16Sub1_2(Screen, bg, D + 5);
                  else
                     DrawBGMode7Background16Sub(Screen, bg, D + 5);
               }
               else
               {
                  if (GFX.r2131 & 0x40)
                     DrawBGMode7Background16Add1_2(Screen, bg, D + 5);
                  else
                     DrawBGMode7Background16Add(Screen, bg, D + 5);
               }
            }
         }
      }
      if (OB && SNESGameFixes.Mode7Hack && D == 0)
      {
#ifndef __FAST_OBJS__
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
#else
         SelectTileRenderer(sub || !SUB_OR_ADD(4), true);
#endif
         DrawOBJS(!sub, D);
      }
   }
}

#include "font.h"

void DisplayChar(uint8* Screen, uint8 c)
{
   int line = (((c & 0x7f) - 32) >> 4) * font_height;
   int offset = (((c & 0x7f) - 32) & 15) * font_width;
   int h, w;
   uint16* s = (uint16*) Screen;
   for (h = 0; h < font_height; h++, line++,
         s += GFX_PPL - font_width)
   {
      for (w = 0; w < font_width; w++, s++)
      {
         uint8 p = font [line][offset + w];

         if (p == '#')
            *s = 0xffff;
         else if (p == '.')
            *s = BLACK;
      }
   }
}

static void S9xUpdateScreenTransparency()  // ~30-50ms! (called from FLUSH_REDRAW())
{
   uint32 starty = GFX.StartY;
   uint32 endy = GFX.EndY;
   uint32 black = BLACK | (BLACK << 16);


   if (GFX.Pseudo)
   {
      GFX.r2131 = 0x5f;  //0101 1111 - enable addition/subtraction on all BGS and sprites and "1/2 OF COLOR DATA" DESIGNATION
      GFX.r212c &= (GFX.r212d_s | 0xf0);
      GFX.r212d |= (GFX.r212c_s & 0x0f);
      GFX.r2130 |= 2; // enable ADDITION/SUBTRACTION FOR SUB SCREEN
   }

   // Check to see if any transparency effects are currently in use
   if (!PPU.ForcedBlanking && ADD_OR_SUB_ON_ANYTHING &&
         (GFX.r2130 & 0x30) != 0x30 &&
         !((GFX.r2130 & 0x30) == 0x10 && IPPU.Clip[1].Count[5] == 0))
   {
      DBG("Transparency in use\n");
      // transparency effects in use, so lets get busy!
      ClipData* pClip;
      uint32 fixedColour;
      GFX.FixedColour = BUILD_PIXEL(IPPU.XB[PPU.FixedColourRed], IPPU.XB[PPU.FixedColourGreen] ,
                                    IPPU.XB[PPU.FixedColourBlue]);
      fixedColour = (GFX.FixedColour << 16 | GFX.FixedColour);
      // Clear the z-buffer, marking areas 'covered' by the fixed
      // colour as depth 1.
      pClip = &IPPU.Clip [1];

      // Clear the z-buffer

      if (pClip->Count [5])
      {

         DBG("Colour window enabled. Clearing...\n");

         // Colour window enabled.
         // loop around all of the lines being updated
         uint32 y ;
         for (y = starty; y <= endy; y++)
         {
            // Clear the subZbuffer
            memset32((uint32_t*)(GFX.SubZBuffer + y * GFX_ZPITCH), 0, (256 >> 2));
            // Clear the Zbuffer
            memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0, (256 >> 2));
            if (IPPU.Clip[0].Count [5])
            {
               // if there is clipping then clear subscreen to a black color
               memset32((uint32_t*)(GFX.SubScreen + y * GFX_PITCH), black, (256 >> 1));
            }

            // loop through all window clippings
            uint32 c ;
            for (c = 0; c < pClip->Count [5]; c++)
            {
               int width = pClip->Right [c][5] - pClip->Left [c][5];
               if (width > 0)
               {

                  //if (pClip->Right [c][5] > pClip->Left [c][5])
                  //{
                  memset(GFX.SubZBuffer + y * GFX_ZPITCH + pClip->Left [c][5],
                         1, width); //pClip->Right [c][5] - pClip->Left [c][5]);

                  if (IPPU.Clip [0].Count [5])
                  {
                     DBG("Clearing sub-screen. Clipping effects in use.\n");
                     // Blast, have to clear the sub-screen to the fixed-colour
                     // because there is a colour window in effect clipping
                     // the main screen that will allow the sub-screen
                     // 'underneath' to show through.

                     __asm__ volatile(
                        "    mov     r0, %[fixedcolour]		\n"
                        "    subs    %[width], %[width], #8	\n"
                        "    bmi     2f				\n"
                        "    mov     r1, r0	\n"
                        "    mov     r2, r0	\n"
                        "    bic     %[p], #3 \n"

                        "1:	\n"
                        "    subs    %[width], %[width], #8	\n"
                        "    stmia   %[p]!, {r0, r1, r2, %[fixedcolour]}\n"
                        "    bpl     1b				\n"

                        "2:	\n"
                        "    tst     %[width], #1		\n"
                        "    strneh  %[fixedcolour], [%[p]], #2	\n"
                        "    bic     %[p], #3 \n"

                        "    tst     %[width], #2		\n"
                        "    strne   %[fixedcolour], [%[p]], #4	\n"

                        "    tst     %[width], #4		\n"
                        "    stmia   %[p]!, {r0, %[fixedcolour]}\n"

                        : [width] "+r"(width)
                        : [fixedcolour] "r"(fixedColour),
                        [p] "r"(((uint16*)(GFX.SubScreen + y * GFX_PITCH)) + pClip->Left [c][5])
                        : "r0", "r1", "r2", "cc"
                     );
                     //}
                  }
               }
            }
         }

      }
      else
      {
         DBG("No windows clipping the main screen.\n");

         // No windows are clipping the main screen
         // this simplifies the screen clearing process
         // loop through all of the lines to be updated
         uint32 y ;
         for (y = starty; y <= endy; y++)
         {
            // Clear the Zbuffer
            memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0, (256 >> 2));
            // clear the sub Zbuffer to 1
            memset32((uint32_t*)(GFX.SubZBuffer + y * GFX_ZPITCH), 0x01010101, (256 >> 2));

            if (IPPU.Clip [0].Count [5])
            {
               // Blast, have to clear the sub-screen to the fixed-colour
               // because there is a colour window in effect clipping
               // the main screen that will allow the sub-screen
               // 'underneath' to show through.
               memset32((uint32_t*)(GFX.SubScreen + y * GFX_PITCH), fixedColour, (256 >> 1));
            }
         }
      }

      if (ANYTHING_ON_SUB)
      {
         DBG("Rendering SubScreen...\n");
         GFX.DB = GFX.SubZBuffer;
         RenderScreen(GFX.SubScreen, TRUE, TRUE, SUB_SCREEN_DEPTH);
      }

      if (IPPU.Clip [0].Count [5])
      {
         DBG("Copying from SubScreen to the Main Screen\n");

         __asm__ volatile(
            "1:		\n"
            "	mov	r1, #(256 >> 2)		\n"

            "2:		\n"
            // four pixels at once
            "	ldrb	r0, [%[d]], #1		\n"
            "	ldrb	r3, [%[d]], #1		\n"

            "	bics	r0, r0, #1		\n"
            "	ldrneh	r0, [%[p], %[delta]]	\n"

            "	bics	r3, r3, #1		\n"
            "	ldrneh	r3, [%[p], %[delta2]]	\n"

            "	strh	r0, [%[p]], #2		\n"
            "	ldrb	r0, [%[d]], #1		\n"
            "	strh	r3, [%[p]], #2		\n"
            "	ldrb	r3, [%[d]], #1		\n"

            "	bics	r0, r0, #1		\n"
            "	ldrneh	r0, [%[p], %[delta]]	\n"

            "	bics	r3, r3, #1		\n"
            "	ldrneh	r3, [%[p], %[delta2]]	\n"

            "	strh	r0, [%[p]], #2		\n"
            "	strh	r3, [%[p]], #2		\n"

            "	subs	r1, r1, #1		\n"
            "	bne	2b			\n"
            "3:		\n"
            "	subs	%[lines], %[lines], #1	\n"
            "	addne	%[p], %[p], #(640 - 512)	\n"
            "	addne	%[d], %[d], #(320 - 256)	\n"
            "	bne	1b			\n"
            "4:		\n"

            :
            : [p] "r"((uint16*)(GFX.Screen + starty * GFX_PITCH)),
            [d] "r"(GFX.SubZBuffer + starty * GFX_ZPITCH),
            [delta] "r"(GFX.Delta << 1),
            [delta2] "r"((GFX.Delta << 1) + 2),
            [lines] "r"(endy - starty + 1)
            : "r0", "r1", "r3", "cc"
         );
      }

      DBG("Rendering the Main Screen...\n");

      GFX.DB = GFX.ZBuffer;
      RenderScreen(GFX.Screen, FALSE, FALSE, MAIN_SCREEN_DEPTH);

      if (SUB_OR_ADD(5))
      {
         uint32 back = IPPU.ScreenColors [0];
         uint32 Left = 0;
         uint32 Right = 256;
         uint32 Count;

         DBG("Addition/Substraction in use...\n");

         pClip = &IPPU.Clip [0];

         // some initial values
         unsigned int fixedcolour_c;
         if (GFX.r2131 & 0x80)
            fixedcolour_c = COLOR_SUB(back, GFX.FixedColour);
         else
            fixedcolour_c = COLOR_ADD(back, GFX.FixedColour);

         if (!(Count = pClip->Count [5])) Count = 1;
         uint32 y ;
         for (y = starty; y <= endy; y++)
         {

            uint32 b ;
            for (b = 0; b < Count; b++)
            {
               if (pClip->Count [5])
               {
                  Left = pClip->Left [b][5];
                  Right = pClip->Right [b][5];
                  if (Right <= Left)
                     continue;
               }
#define _ROP_ADD1_2  \
   "	mov	r0, %[back]		\n"\
   ROP_ADD1_2(r0, r1)  \
   "	strh	r0, [%[p]]		\n"

               // Arguments can be exchanged on addition, so early exit on back == 0 is possible
#define _ROP_ADD \
   ROP_ADD(r1, %[back]) \
   "	strh	r1, [%[p]]		\n"


#define _ROP_SUB1_2 \
   "	mov	r0, %[back]		\n"\
   ROP_SUB1_2(r0, r1) \
   "	strh	r0, [%[p]]		\n"

#define _ROP_SUB \
"	mov	r0, %[back]		\n"\
   ROP_SUB(r0, r1) \
   "	strh	r0, [%[p]]		\n"

#define SUBSCREEN_BG(rop, half) \
\
__asm__ volatile (\
"	ldrb	r0, [%[d]] 		\n"\
"71:		\n"\
\
"	movs	r0, r0			\n"\
"	ldreqb	r1, [%[d], %[zdelta]]	\n"\
"	bne	72f			\n"\
\
"	cmp	r1, #1			\n"\
"	ldrhih	r1, [%[p], %[delta]]	\n"\
"	bls	74f			\n"\
\
_ROP_##rop##half \
\
"72:		\n"\
"	add	%[p], %[p], #2		\n"\
"	subs	%[c], %[c], #1		\n"\
"	ldrneb	r0, [%[d], #1]!		\n"\
"	bne	71b			\n"\
"	b	75f			\n"\
"74:		\n"\
"	streqh	%[fixedcolour], [%[p]], #2 		\n"\
"	strloh	%[back], [%[p]], #2 	\n"\
"	subs	%[c], %[c], #1		\n"\
"	ldrneb	r0, [%[d], #1]!		\n"\
"	bne	71b			\n"\
"75:	\n"\
:\
:[p] "r" ((uint16 *) (GFX.Screen + y * GFX_PITCH) + Left),\
 [d] "r" (GFX.ZBuffer + y * GFX_ZPITCH + Left),\
 [zdelta] "r" (GFX.DepthDelta),\
 [back] "r" (back),\
 [delta] "r" (GFX.Delta << 1),\
 [fixedcolour] "r" (fixedcolour_c),\
 [c] "r" (Right - Left) \
: "r0", "r1", "cc"\
);
               if (GFX.r2131 & 0x80)
               {
                  if (GFX.r2131 & 0x40)
                  {
                     SUBSCREEN_BG(SUB, 1_2)
                  }
                  else
                  {
                     SUBSCREEN_BG(SUB,)

                  }
               }
               else if (GFX.r2131 & 0x40)
               {
                  SUBSCREEN_BG(ADD, 1_2)
               }
               else if (back != 0)
               {
                  SUBSCREEN_BG(ADD,)
               }
               else
               {

                  if (!pClip->Count [5])
                  {
                     DBG("Copying line with no effect...\n");
                     // The backdrop has not been cleared yet - so
                     // copy the sub-screen to the main screen
                     // or fill it with the back-drop colour if the
                     // sub-screen is clear.
                     __asm__ volatile(
                        "	ldrb	r0, [%[d]] 		\n"
                        "31:		\n"

                        "	movs	r0, r0			\n"
                        "	ldreqb	r1, [%[d], %[zdelta]]	\n"
                        "	bne	32f			\n"

                        "	cmp	r1, #1			\n"
                        "	ldrhih	r0, [%[p], %[delta]]	\n"
                        "	strloh	%[back], [%[p]]		\n"
                        "	streqh	%[fixedcolour], [%[p]]	\n"
                        "	strhih	r0, [%[p]]  		\n"

                        "32:		\n"
                        "	subs	%[c], %[c], #1		\n"
                        "	add	%[p], %[p], #2		\n"
                        "	ldrneb	r0, [%[d], #1]!		\n"
                        "	bne	31b			\n"
                        "	\n"
                        :
                        :[p] "r"((uint16*)(GFX.Screen + y * GFX_PITCH) + Left),
                        [d] "r"(GFX.ZBuffer + y * GFX_ZPITCH + Left),
                        [zdelta] "r"(GFX.DepthDelta),
                        [back] "r"(back),
                        [delta] "r"(GFX.Delta << 1),
                        [fixedcolour] "r"(GFX.FixedColour),
                        [c] "r"(Right - Left)
                        : "r0", "r1", "cc"

                     );

                  }
               }
            }
         }

      }
      else
      {

         // Subscreen not being added to back
         DBG("No addition/substraction in use...\n");
         uint32 back = IPPU.ScreenColors [0] | (IPPU.ScreenColors [0] << 16);
         pClip = &IPPU.Clip [0];

         if (pClip->Count [5])
         {

            DBG("Copying subscreen with clipping...\n");

            uint32 y ;
            for (y = starty; y <= endy; y++)
            {
               uint32 b ;
               for (b = 0; b < pClip->Count [5]; b++)
               {
                  uint32 Left = pClip->Left [b][5];
                  uint32 Right = pClip->Right [b][5];
                  if (Left >= Right) continue;
                  __asm__ volatile(

                     "	tst	%[c], #1		\n"
                     "	bne	21f			\n"

                     "	ldrb	r0, [%[d]], #1 		\n"
                     "	add	%[p], %[p], #2		\n"
                     "	movs	r0, r0			\n"
                     "	streqh	%[back], [%[p], #-2]  	\n"
                     "	subs	%[c], %[c], #1		\n"
                     "	beq	22f			\n"

                     "21:		\n"

                     "	ldrb	r0, [%[d]], #1 		\n"
                     "	ldrb	r1, [%[d]], #1		\n"
                     "	add	%[p], %[p], #4		\n"

                     "	movs	r0, r0			\n"
                     "	streqh	%[back], [%[p], #-4]  	\n"

                     "	movs	r1, r1			\n"
                     "	streqh	%[back], [%[p], #-2]  	\n"

                     "	subs	%[c], %[c], #2		\n"
                     "	bhi	21b			\n"
                     "22:	\n"
                     :
                     :[p] "r"((uint16*)(GFX.Screen + y * GFX_PITCH) + Left),
                     [d] "r"(GFX.ZBuffer + y * GFX_ZPITCH + Left),
                     [back] "r"(back),
                     [c] "r"(Right - Left)
                     : "r0", "r1", "cc"

                  );
               }
            }
         }
         else
         {
            DBG("Copying SubScreen with no clipping...\n");

            __asm__ volatile(
               "@ -- SubScreen clear			\n"
               "1113:		\n"
               "	mov	r1, #(256/8)		\n"
               "1112:		\n"
               "	ldr	r0, [%[d]], #4 		\n"

               "	add	%[p], %[p], #8		\n"

               "	tst	r0, #0x0ff		\n"
               "	streqh	%[back], [%[p], #-8]  	\n"

               "	tst	r0, #0x0ff00		\n"
               "	streqh	%[back], [%[p], #-6]  	\n"

               "	tst	r0, #0x0ff0000		\n"
               "	streqh	%[back], [%[p], #-4]  	\n"

               "	tst	r0, #0x0ff000000	\n"
               "	streqh	%[back], [%[p], #-2]  	\n"

               "	ldr	r0, [%[d]], #4 		\n"

               "	add	%[p], %[p], #8		\n"

               "	tst	r0, #0x0ff		\n"
               "	streqh	%[back], [%[p], #-8]  	\n"

               "	tst	r0, #0x0ff00		\n"
               "	streqh	%[back], [%[p], #-6]  	\n"

               "	tst	r0, #0x0ff0000		\n"
               "	streqh	%[back], [%[p], #-4]  	\n"

               "	tst	r0, #0x0ff000000	\n"
               "	streqh	%[back], [%[p], #-2]  	\n"

               "	subs	r1, r1, #1 		\n"
               "	bne	1112b			\n"

               "	subs	%[lines], %[lines], #1	\n"
               "	add	%[p], %[p], #(640-512)	\n"
               "	add	%[d], %[d], #(320-256)	\n"
               "	bne	1113b			\n"
               "1114:"
               :
               :[p] "r"(GFX.Screen + starty * GFX_PITCH),
               [d] "r"(GFX.ZBuffer + starty * GFX_ZPITCH),
               [back] "r"(back),
               [lines] "r"(endy - starty + 1)
               : "r0", "r1", "cc"
            );
         }
      }

   }
   else
   {
      DBG("No transparency effects in use.\n");

      // 16bit and transparency but currently no transparency effects in
      // operation.

      // get the back colour of the current screen
      uint32 back = IPPU.ScreenColors [0] |
                    (IPPU.ScreenColors [0] << 16);

      // if forceblanking in use then use black instead of the back color
      if (PPU.ForcedBlanking)
         back = black;

      // not sure what Clip is used for yet
      // could be a check to see if there is any clipping present?
      if (IPPU.Clip [0].Count[5])
      {
         DBG("Clearing background with clipping...\n");

         // loop through all of the lines that are going to be updated as part of this screen update
         uint32 y ;
         for (y = starty; y <= endy; y++)
         {
            memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), black,
                     IPPU.RenderedScreenWidth >> 1);

            if (black != back)
            {
               uint32 c ;
               for (c = 0; c < IPPU.Clip [0].Count [5]; c++)
               {
                  //if (IPPU.Clip [0].Right [c][5] > IPPU.Clip [0].Left [c][5])
                  //{
                  int width = IPPU.Clip [0].Right [c][5] - IPPU.Clip [0].Left [c][5];
                  if (width <= 0) continue;

                  __asm__ volatile(
                     "    mov     r0, %[back]		\n"
                     "    subs    %[width], %[width], #8	\n"
                     "    bmi     2f				\n"
                     "    mov     r1, r0	\n"
                     "    mov     r2, r0	\n"
                     "    bic     %[p], #3 \n"

                     "1:	\n"
                     "    subs    %[width], %[width], #8	\n"
                     "    stmia   %[p]!, {r0, r1, r2, %[back]}\n"
                     "    bpl     1b				\n"

                     "2:	\n"
                     "    tst     %[width], #1		\n"
                     "    strneh  %[back], [%[p]], #2	\n"
                     "    bic     %[p], #3 \n"

                     "    tst     %[width], #2		\n"
                     "    strne   %[back], [%[p]], #4	\n"

                     "    tst     %[width], #4		\n"
                     "    stmia   %[p]!, {r0, %[back]}\n"

                     : [width] "+r"(width)
                     : [back] "r"(back | (back << 16)),
                     [p] "r"(((uint16*)(GFX.SubScreen + y * GFX_PITCH)) + IPPU.Clip [0].Left [c][5])
                     : "r0", "r1", "r2", "cc"
                  );
                  //}
               }
            }
         }

      }
      else
      {
         DBG("Clearing background with no clipping...\n");

         // there is no clipping to worry about so just fill with the back colour
         uint32 y ;
         for (y = starty; y <= endy; y++)
            memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), back, (256 >> 1));

      }

      // If Forced blanking is not in effect
      if (!PPU.ForcedBlanking)
      {
         DBG("Forced Blanking not in use. Clearing ZBuffer ... !!\n");
         // Clear the Zbuffer for each of the lines which are going to be updated
         uint32 y ;
         for (y = starty; y <= endy; y++)
            memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0, (256 >> 2));
         DBG("Rendering screen !!\n");
         GFX.DB = GFX.ZBuffer;  // save pointer to Zbuffer in GFX object
         RenderScreen(GFX.Screen, FALSE, TRUE, SUB_SCREEN_DEPTH);

      }
   }
   IPPU.PreviousLine = IPPU.CurrentLine;
}

static void S9xUpdateScreenNoTransparency()  // ~30-50ms! (called from FLUSH_REDRAW())
{
   uint32 starty = GFX.StartY;
   uint32 endy = GFX.EndY;

   uint32 black = BLACK | (BLACK << 16);

   // get back colour to be used in clearing the screen
   uint32 back;
   if (!(GFX.r2131 & 0x80) && (GFX.r2131 & 0x20) &&
         (PPU.FixedColourRed || PPU.FixedColourGreen || PPU.FixedColourBlue))
   {
      back = (PPU.FixedColourRed << 11) | (PPU.FixedColourGreen << 6) | (1 << 5) | (PPU.FixedColourBlue);
      back = (back << 16) | back;
   }
   else
      back = IPPU.ScreenColors [0] | (IPPU.ScreenColors [0] << 16);

   // if Forcedblanking in use then back colour becomes black
   if (PPU.ForcedBlanking)
      back = black;
   else
   {
      SelectTileRenderer(TRUE, false);   //selects the tile renderers to be used
      // TRUE means to use the default
      // FALSE means use best renderer based on current
      // graphics register settings
   }

   // now clear all graphics lines which are being updated using the back colour
   uint32 y;
   for (y = starty; y <= endy; y++)
   {
      memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), back,
               IPPU.RenderedScreenWidth >> 1);
   }

   if (!PPU.ForcedBlanking)
   {
      // Loop through all lines being updated and clear the
      // zbuffer for each of the lines
      uint32 y ;
      for (y = starty; y <= endy; y++)
      {
         memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0,
                  IPPU.RenderedScreenWidth >> 2);
      }
      GFX.DB = GFX.ZBuffer; // save pointer to Zbuffer in GFX object
      GFX.pCurrentClip = &IPPU.Clip [0];

      // Define an inline function to handle clipping
#define FIXCLIP(n) \
if (GFX.r212c & (1 << (n))) \
   GFX.pCurrentClip = &IPPU.Clip [0]; \
else \
   GFX.pCurrentClip = &IPPU.Clip [1]

      // Define an inline function to handle which BGs are being displayed
#define DISPLAY(n)   ((GFX.r212c & n) || ((GFX.r212d & n) && subadd))

      uint8 subadd = GFX.r2131 & 0x3f;

      // go through all BGS are check if they need to be displayed
      bool8_32 BG0 = DISPLAY(1) && !(Settings.os9x_hack & GFX_IGNORE_BG0);
      bool8_32 BG1 = DISPLAY(2) && !(Settings.os9x_hack & GFX_IGNORE_BG1);
      bool8_32 BG2 = DISPLAY(4) && !(Settings.os9x_hack & GFX_IGNORE_BG2);
      bool8_32 BG3 = DISPLAY(8) && !(Settings.os9x_hack & GFX_IGNORE_BG3);
      bool8_32 OB  = DISPLAY(16) && !(Settings.os9x_hack & GFX_IGNORE_OBJ);

      if (PPU.BGMode <= 1)
      {
         // screen modes 0 and 1
         if (OB)
         {
            FIXCLIP(4);
            DrawOBJS(FALSE, 0);
         }
         if (BG0)
         {
            FIXCLIP(0);
            DrawBackground(PPU.BGMode, 0, 10, 14);
         }
         if (BG1)
         {
            FIXCLIP(1);
            DrawBackground(PPU.BGMode, 1, 9, 13);
         }
         if (BG2)
         {
            FIXCLIP(2);
            DrawBackground(PPU.BGMode, 2, 3,
                           PPU.BG3Priority ? 17 : 6);
         }
         if (BG3 && PPU.BGMode == 0)
         {
            FIXCLIP(3);
            DrawBackground(PPU.BGMode, 3, 2, 5);
         }
      }
      else if (PPU.BGMode != 7)
      {
         // screen modes 2 and up but not mode 7
         if (OB)
         {
            FIXCLIP(4);
            DrawOBJS(FALSE, 0);
         }
         if (BG0)
         {
            FIXCLIP(0);
            DrawBackground(PPU.BGMode, 0, 5, 13);
         }
         if (BG1 && PPU.BGMode != 6)
         {
            FIXCLIP(1);
            DrawBackground(PPU.BGMode, 1, 2, 9);
         }
      }
      else
      {
         // screen mode 7
         DrawBGMode7Background16New(GFX.Screen);
         if (OB)
         {
            FIXCLIP(4);
            DrawOBJS(FALSE, 0);
         }
      }
   }
   IPPU.PreviousLine = IPPU.CurrentLine;
}

#ifndef __OLD_RASTER_FX__
void S9xUpdateScreen()  // ~30-50ms! (called from FLUSH_REDRAW())
{
   int StartY, EndY, CurrentLine, CurrentROp;

   StartY = IPPU.PreviousLine;
   if ((EndY = IPPU.CurrentLine - 1) >= PPU.ScreenHeight) EndY = PPU.ScreenHeight - 1;

   GFX.S = GFX.Screen;

   CurrentROp = 0;
   CurrentLine = StartY;
#ifdef __DEBUG__
   printf("Start screen update. ROPCount: %d, StartY: %d, EndY: %d\n", ROpCount, StartY, EndY);
#endif
   do
   {
      while ((CurrentROp < ROpCount) && ((rops[CurrentROp].line == CurrentLine)
                                         || (!wouldRasterAlterStatus(&rops[CurrentROp]))))
      {
#ifdef __DEBUG__
         printf("Processing ROP %d/%d. Line: %d\n", CurrentROp, ROpCount, CurrentLine);
#endif
         doRaster(&rops[CurrentROp]);
         CurrentROp++;
      }

      GFX.StartY = CurrentLine;
      if ((CurrentROp < ROpCount) && ((rops[CurrentROp].line - 1) <= EndY)) GFX.EndY = rops[CurrentROp].line - 1;
      else GFX.EndY = EndY;

#ifdef __DEBUG__
      printf("Partial screen update. ROPCount: %d, StartY: %d, EndY: %d\n", ROpCount, GFX.StartY, GFX.EndY);
#endif

      // get local copies of vid registers to be used later
      GFX.r2131 = GFX.r2131_s; // ADDITION/SUBTRACTION & SUBTRACTION DESIGNATION FOR EACH SCREEN
      GFX.r212c = GFX.r212c_s; // MAIN SCREEN, DESIGNATION - used to enable BGS
      GFX.r212d = GFX.r212d_s; // SUB SCREEN DESIGNATION - used to enable sub BGS
      GFX.r2130 = GFX.r2130_s; // INITIAL SETTINGS FOR FIXED COLOR ADDITION OR SCREEN ADDITION

      // If external sync is off and
      // main screens have not been configured the same as the sub screen and
      // color addition and subtraction has been disabled then
      // Pseudo is 1
      // anything else it is 0
      GFX.Pseudo = (Memory.FillRAM[0x2133] & 8) != 0 && // Use EXTERNAL SYNCHRONIZATION?
                   (GFX.r212c & 15) != (GFX.r212d & 15) && // Are the main screens different from the sub screens?
                   (GFX.r2131 & 0x3f) == 0; // Is colour data addition/subtraction disabled on all BGS?

      // If sprite data has been changed then go through and
      // refresh the sprites.
      if (IPPU.OBJChanged)
      {
#ifdef __DEBUG__
         printf("Objects changed !! setting up Objects...\n");
#endif
         S9xSetupOBJ();
      }

      if (PPU.RecomputeClipWindows)
      {
#ifdef __DEBUG__
         printf("Clipping changed !! recalculating clipping...\n");
#endif
         ComputeClipWindows();
      }

      if (Settings.Transparency) S9xUpdateScreenTransparency();
      else S9xUpdateScreenNoTransparency();
      CurrentLine = GFX.EndY + 1;

#ifdef __DEBUG__
      printf("Finished partial screen update.\n", ROpCount, StartY, EndY);
#endif


   }
   while ((CurrentROp < ROpCount) && (CurrentLine <= EndY));

#ifdef __DEBUG__
   printf("End screen update. ROPCount: %d, CurrentROp: %d, StartY: %d, EndY: %d\n", ROpCount, CurrentROp, StartY, EndY);
#endif

   RESET_ROPS(CurrentROp);

#ifdef __DEBUG__
   printf("ROps cleaned\n");
#endif

   PPU.BG[0].OffsetsChanged = 0;
   PPU.BG[1].OffsetsChanged = 0;
   PPU.BG[2].OffsetsChanged = 0;
   PPU.BG[3].OffsetsChanged = 0;
}

#else // __OLD_RASTER_FX__

void S9xUpdateScreen()  // ~30-50ms! (called from FLUSH_REDRAW())
{
   GFX.StartY = IPPU.PreviousLine;
   if ((GFX.EndY = IPPU.CurrentLine - 1) >= PPU.ScreenHeight) GFX.EndY = PPU.ScreenHeight - 1;

   GFX.S = GFX.Screen;

#ifdef __DEBUG__
   printf("Start screen update. StartY: %d, EndY: %d\n", GFX.StartY, GFX.EndY);
#endif
   // get local copies of vid registers to be used later
   GFX.r2131 = GFX.r2131_s; // ADDITION/SUBTRACTION & SUBTRACTION DESIGNATION FOR EACH SCREEN
   GFX.r212c = GFX.r212c_s; // MAIN SCREEN, DESIGNATION - used to enable BGS
   GFX.r212d = GFX.r212d_s; // SUB SCREEN DESIGNATION - used to enable sub BGS
   GFX.r2130 = GFX.r2130_s; // INITIAL SETTINGS FOR FIXED COLOR ADDITION OR SCREEN ADDITION

   // If external sync is off and
   // main screens have not been configured the same as the sub screen and
   // color addition and subtraction has been disabled then
   // Pseudo is 1
   // anything else it is 0
   GFX.Pseudo = (Memory.FillRAM[0x2133] & 8) != 0 && // Use EXTERNAL SYNCHRONIZATION?
                (GFX.r212c & 15) != (GFX.r212d & 15) && // Are the main screens different from the sub screens?
                (GFX.r2131 & 0x3f) == 0; // Is colour data addition/subtraction disabled on all BGS?

   // If sprite data has been changed then go through and
   // refresh the sprites.
   if (IPPU.OBJChanged)
   {
#ifdef __DEBUG__
      printf("Objects changed !! setting up Objects...\n");
#endif
      S9xSetupOBJ();
   }

   if (PPU.RecomputeClipWindows)
   {
#ifdef __DEBUG__
      printf("Clipping changed !! recalculating clipping...\n");
#endif
      ComputeClipWindows();
   }

   if (Settings.Transparency) S9xUpdateScreenTransparency();
   else S9xUpdateScreenNoTransparency();

#ifdef __DEBUG__
   printf("End screen update. StartY: %d, EndY: %d\n", GFX.StartY, GFX.EndY);
#endif
   PPU.BG[0].OffsetsChanged = 0;
   PPU.BG[1].OffsetsChanged = 0;
   PPU.BG[2].OffsetsChanged = 0;
   PPU.BG[3].OffsetsChanged = 0;
}
#endif

// -x-

#ifdef GFX_MULTI_FORMAT

#define _BUILD_PIXEL(F) \
uint32 BuildPixel##F(uint32 R, uint32 G, uint32 B) \
{ \
    return (BUILD_PIXEL_##F(R,G,B)); \
}\
uint32 BuildPixel2##F(uint32 R, uint32 G, uint32 B) \
{ \
    return (BUILD_PIXEL2_##F(R,G,B)); \
} \
void DecomposePixel##F(uint32 pixel, uint32 &R, uint32 &G, uint32 &B) \
{ \
    DECOMPOSE_PIXEL_##F(pixel,R,G,B); \
}

_BUILD_PIXEL(RGB565)
_BUILD_PIXEL(RGB555)
_BUILD_PIXEL(BGR565)
_BUILD_PIXEL(BGR555)
_BUILD_PIXEL(GBR565)
_BUILD_PIXEL(GBR555)
_BUILD_PIXEL(RGB5551)

bool8_32 S9xSetRenderPixelFormat(int format)
{
   extern uint32 current_graphic_format;

   current_graphic_format = format;

   switch (format)
   {
   case RGB565:
      _BUILD_SETUP(RGB565)
      return (TRUE);
   case RGB555:
      _BUILD_SETUP(RGB555)
      return (TRUE);
   case BGR565:
      _BUILD_SETUP(BGR565)
      return (TRUE);
   case BGR555:
      _BUILD_SETUP(BGR555)
      return (TRUE);
   case GBR565:
      _BUILD_SETUP(GBR565)
      return (TRUE);
   case GBR555:
      _BUILD_SETUP(GBR555)
      return (TRUE);
   case RGB5551:
      _BUILD_SETUP(RGB5551)
      return (TRUE);
   default:
      break;
   }
   return (FALSE);
}
#endif
