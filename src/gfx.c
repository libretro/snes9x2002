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
#include "tile.h"

uint32 TileBlank;

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

#define CLIP_10_BIT_SIGNED(a) \
   ((a)%1023)
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

void DrawTile(uint32 Tile, int32 Offset, uint32 StartLine,
              uint32 LineCount);
void DrawClippedTile(uint32 Tile, int32 Offset,
                     uint32 StartPixel, uint32 Width,
                     uint32 StartLine, uint32 LineCount);
void DrawTilex2(uint32 Tile, int32 Offset, uint32 StartLine,
                uint32 LineCount);
void DrawClippedTilex2(uint32 Tile, int32 Offset,
                       uint32 StartPixel, uint32 Width,
                       uint32 StartLine, uint32 LineCount);
void DrawTilex2x2(uint32 Tile, int32 Offset, uint32 StartLine,
                  uint32 LineCount);
void DrawClippedTilex2x2(uint32 Tile, int32 Offset,
                         uint32 StartPixel, uint32 Width,
                         uint32 StartLine, uint32 LineCount);
void DrawLargePixel(uint32 Tile, int32 Offset,
                    uint32 StartPixel, uint32 Pixels,
                    uint32 StartLine, uint32 LineCount);

void DrawTile16(uint32 Tile, int32 Offset, uint32 StartLine,
                uint32 LineCount);
void DrawClippedTile16(uint32 Tile, int32 Offset,
                       uint32 StartPixel, uint32 Width,
                       uint32 StartLine, uint32 LineCount);
void DrawTile16x2(uint32 Tile, int32 Offset, uint32 StartLine,
                  uint32 LineCount);
void DrawClippedTile16x2(uint32 Tile, int32 Offset,
                         uint32 StartPixel, uint32 Width,
                         uint32 StartLine, uint32 LineCount);
void DrawTile16x2x2(uint32 Tile, int32 Offset, uint32 StartLine,
                    uint32 LineCount);
void DrawClippedTile16x2x2(uint32 Tile, int32 Offset,
                           uint32 StartPixel, uint32 Width,
                           uint32 StartLine, uint32 LineCount);
void DrawLargePixel16(uint32 Tile, int32 Offset,
                      uint32 StartPixel, uint32 Pixels,
                      uint32 StartLine, uint32 LineCount);

void DrawTile16Add(uint32 Tile, int32 Offset, uint32 StartLine,
                   uint32 LineCount);

void DrawClippedTile16Add(uint32 Tile, int32 Offset,
                          uint32 StartPixel, uint32 Width,
                          uint32 StartLine, uint32 LineCount);

void DrawTile16Add1_2(uint32 Tile, int32 Offset, uint32 StartLine,
                      uint32 LineCount);

void DrawClippedTile16Add1_2(uint32 Tile, int32 Offset,
                             uint32 StartPixel, uint32 Width,
                             uint32 StartLine, uint32 LineCount);

void DrawTile16FixedAdd1_2(uint32 Tile, int32 Offset, uint32 StartLine,
                           uint32 LineCount);

void DrawClippedTile16FixedAdd1_2(uint32 Tile, int32 Offset,
                                  uint32 StartPixel, uint32 Width,
                                  uint32 StartLine, uint32 LineCount);

void DrawTile16Sub(uint32 Tile, int32 Offset, uint32 StartLine,
                   uint32 LineCount);

void DrawClippedTile16Sub(uint32 Tile, int32 Offset,
                          uint32 StartPixel, uint32 Width,
                          uint32 StartLine, uint32 LineCount);

void DrawTile16Sub1_2(uint32 Tile, int32 Offset, uint32 StartLine,
                      uint32 LineCount);

void DrawClippedTile16Sub1_2(uint32 Tile, int32 Offset,
                             uint32 StartPixel, uint32 Width,
                             uint32 StartLine, uint32 LineCount);

void DrawTile16FixedSub1_2(uint32 Tile, int32 Offset, uint32 StartLine,
                           uint32 LineCount);

void DrawClippedTile16FixedSub1_2(uint32 Tile, int32 Offset,
                                  uint32 StartPixel, uint32 Width,
                                  uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Add(uint32 Tile, int32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Add1_2(uint32 Tile, int32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Sub(uint32 Tile, int32 Offset,
                         uint32 StartPixel, uint32 Pixels,
                         uint32 StartLine, uint32 LineCount);

void DrawLargePixel16Sub1_2(uint32 Tile, int32 Offset,
                            uint32 StartPixel, uint32 Pixels,
                            uint32 StartLine, uint32 LineCount);

void DrawHiResClippedTile16(uint32 Tile, int32 Offset,
                            uint32 StartPixel, uint32 Width,
                            uint32 StartLine, uint32 LineCount);

void DrawHiResTile16(uint32 Tile, int32 Offset,
                     uint32 StartLine, uint32 LineCount);

bool8_32 S9xGraphicsInit(void)
{
   uint8 bitshift;
   uint32 r, g, b;
   uint32 PixelOdd = 1;
   uint32 PixelEven = 2;

#ifdef GFX_MULTI_FORMAT
   if (GFX.BuildPixel == NULL)
      S9xSetRenderPixelFormat(RGB565);
#endif

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
   uint32 p, c;

   for (p = 0; p < 8; p++)
   {
      for (c = 0; c < 256; c++)
      {
         // XXX: Brightness
         DirectColourMaps [p][c] = BUILD_PIXEL(((c & 7) << 2) | ((p & 1) << 1),
                                               ((c & 0x38) >> 1) | (p & 2),
                                               ((c & 0xc0) >> 3) | (p & 4));
      }
   }
   IPPU.DirectColourMapsNeedRebuild = FALSE;
}

void S9xStartScreenRefresh()
{
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

      if (PPU.BGMode == 7)
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
      if (IPPU.ColorsChanged)
         IPPU.ColorsChanged = FALSE;


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

static INLINE void SelectTileRenderer(bool8_32 normal, bool NoZ)
{
   if (normal)
   {
      DrawTilePtr = DrawTile16;
      DrawClippedTilePtr = DrawClippedTile16;
      DrawLargePixelPtr = DrawLargePixel16;
   }
   else
   {
      if (GFX.r2131 & 0x80)
      {
         if (GFX.r2131 & 0x40)
         {
            if (GFX.r2130 & 2)
            {
               DrawTilePtr = DrawTile16Sub1_2;
               DrawClippedTilePtr = DrawClippedTile16Sub1_2;
            }
            else
            {
               // Fixed colour substraction
               DrawTilePtr = DrawTile16FixedSub1_2;
               DrawClippedTilePtr = DrawClippedTile16FixedSub1_2;
            }
            DrawLargePixelPtr = DrawLargePixel16Sub1_2;
         }
         else
         {
            DrawTilePtr = DrawTile16Sub;
            DrawClippedTilePtr = DrawClippedTile16Sub;
            DrawLargePixelPtr = DrawLargePixel16Sub;
         }
      }
      else
      {
         if (GFX.r2131 & 0x40)
         {
            if (GFX.r2130 & 2)
            {
               DrawTilePtr = DrawTile16Add1_2;
               DrawClippedTilePtr = DrawClippedTile16Add1_2;
            }
            else
            {
               // Fixed colour addition
               DrawTilePtr = DrawTile16FixedAdd1_2;
               DrawClippedTilePtr = DrawClippedTile16FixedAdd1_2;
            }
            DrawLargePixelPtr = DrawLargePixel16Add1_2;
         }
         else
         {
            DrawTilePtr = DrawTile16Add;
            DrawClippedTilePtr = DrawClippedTile16Add;
            DrawLargePixelPtr = DrawLargePixel16Add;
         }
      }
   }
}

void S9xSetupOBJ(void)
{
   int C = 0;
   int SmallSize;
   int LargeSize;
   int S;
   int FirstSprite;

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

   FirstSprite = PPU.FirstSprite & 0x7f;
   S           = FirstSprite;

   do
   {
      int Size;
      long VPos;

      if (PPU.OBJ [S].Size)
         Size = LargeSize;
      else
         Size = SmallSize;

      VPos = PPU.OBJ [S].VPos;

      if (VPos >= PPU.ScreenHeight)
         VPos -= 256;
      if (PPU.OBJ [S].HPos < 256 && PPU.OBJ [S].HPos > -Size &&
            VPos < PPU.ScreenHeight && VPos > -Size)
      {
         GFX.OBJList [C++] = S;
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
   uint32 O;
   uint32 BaseTile, Tile;
   int I = 0;
   int S;

   BG.BitShift = 4;
   BG.TileShift = 5;
   BG.TileAddress = PPU.OBJNameBase;
   BG.StartPalette = 128;
   BG.PaletteShift = 4;
   BG.PaletteMask = 7;
   BG.Buffer = IPPU.TileCache [TILE_4BIT];
   BG.Buffered = IPPU.TileCached [TILE_4BIT];
   BG.NameSelect = PPU.OBJNameSelect;
   BG.DirectColourMode = FALSE;

   SelectPalette();

   GFX.Z1 = D + 2;

   for (S = GFX.OBJList [I++]; S >= 0; S = GFX.OBJList [I++])
   {
      int clipcount;
      int clip, Offset;
      int VPos = GFX.VPositions [S];
      int Size = GFX.Sizes[S];
      int TileInc = 1;

      if (VPos + Size <= (int) GFX.StartY || VPos > (int) GFX.EndY)
         continue;

      if (OnMain && SUB_OR_ADD(4))
         SelectTileRenderer(!GFX.Pseudo && PPU.OBJ [S].Palette < 4, false);

      BaseTile = PPU.OBJ[S].Name | (PPU.OBJ[S].Palette << 10);

      if (PPU.OBJ[S].HFlip)
      {
         BaseTile += ((Size >> 3) - 1) | H_FLIP;
         TileInc = -1;
      }
      if (PPU.OBJ[S].VFlip)
         BaseTile |= V_FLIP;

      clipcount = GFX.pCurrentClip->Count [4];
      if (!clipcount)
         clipcount = 1;

      GFX.Z2 = (PPU.OBJ[S].Priority + 1) * 4 + D;

      for (clip = 0; clip < clipcount; clip++)
      {
         int Left, Right, Y;
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

         for (Y = 0; Y < Size; Y += 8)
         {
            if (VPos + Y + 7 >= (int) GFX.StartY && VPos + Y <= (int) GFX.EndY)
            {
               int X;
               int Middle;
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
               if (!PPU.OBJ[S].VFlip)
                  Tile = BaseTile + (Y << 1);
               else
                  Tile = BaseTile + ((Size - Y - 8) << 1);

               Middle = Size >> 3;
               if (PPU.OBJ[S].HPos < Left)
               {
                  Tile += ((Left - PPU.OBJ[S].HPos) >> 3) * TileInc;
                  Middle -= (Left - PPU.OBJ[S].HPos) >> 3;
                  O += Left * GFX_PIXSIZE;
                  if ((Offset = (Left - PPU.OBJ[S].HPos) & 7))
                  {
                     int W, Width;

                     O    -= Offset * GFX_PIXSIZE;
                     W     = 8 - Offset;
                     Width = Right - Left;
                     if (W > Width)
                        W = Width;
                     (*DrawClippedTilePtr)(Tile, O, Offset, W,
                                           TileLine, LineCount);

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

               for (X = 0; X < Middle; X++, O += 8 * GFX_PIXSIZE,
                     Tile += TileInc)
                  (*DrawTilePtr)(Tile, O, TileLine, LineCount);
               if (Offset)
                  (*DrawClippedTilePtr)(Tile, O, 0, Offset,
                                        TileLine, LineCount);
            }
         }
      }
   }
}

void DrawBackgroundMosaic(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
   uint32 Y;
   uint32 Lines;
   uint32 OffsetMask;
   uint32 OffsetShift;
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

   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      uint16* t;
      uint32 Left = 0;
      uint32 Right = 256;
      uint16* b1;
      uint16* b2;
      uint32 VirtAlign;
      uint32 ScreenLine;
      uint32 Rem16;
      uint32 MosaicLine;
      uint32 clip, x;
      uint32 ClipCount;
      uint32 HPos;
      uint32 PixWidth;
      uint32 VOffset = LineData [Y].BG[bg].VOffset;
      uint32 HOffset = LineData [Y].BG[bg].HOffset;
      uint32 MosaicOffset = Y % PPU.Mosaic;

      for (Lines = 1; Lines < PPU.Mosaic - MosaicOffset; Lines++)
         if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [Y + Lines].BG[bg].HOffset))
            break;

      MosaicLine = VOffset + Y - MosaicOffset;

      if (Y + Lines > GFX.EndY)
         Lines   = GFX.EndY + 1 - Y;
      VirtAlign  = (MosaicLine & 7) << 3;
      ScreenLine = MosaicLine >> OffsetShift;
      Rem16      = MosaicLine & 15;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      ClipCount = GFX.pCurrentClip->Count [bg];
      HPos = HOffset;
      PixWidth = PPU.Mosaic;

      if (!ClipCount)
         ClipCount = 1;

      for (clip = 0; clip < ClipCount; clip++)
      {
         uint32 s;
         if (GFX.pCurrentClip->Count [bg])
         {
            uint32 r;

            Left     = GFX.pCurrentClip->Left [clip][bg];
            Right    = GFX.pCurrentClip->Right [clip][bg];
            r        = Left % PPU.Mosaic;
            HPos     = HOffset + Left;
            PixWidth = PPU.Mosaic - r;
         }
         s = Y * GFX_PPL + Left * GFX_PIXSIZE;
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
   static const int Lines = 1;
   uint32 Y;
   int OffsetMask;
   int OffsetShift;
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
   int OffsetEnableMask;
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

   OffsetEnableMask = 1 << (bg + 13);

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

   for (Y = GFX.StartY; Y <= GFX.EndY; Y++)
   {
      int clip;
      uint32 VOff = LineData [Y].BG[2].VOffset - 1;
      uint32 HOff = LineData [Y].BG[2].HOffset;
      int VirtAlign;
      int clipcount;
      int ScreenLine = VOff >> 3;
      uint16* s0;
      uint16* s1;
      uint16* s2;

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
      clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;

      for (clip = 0; clip < clipcount; clip++)
      {
         uint32 Left;
         uint32 Right;
         uint32 VOffset;
         uint32 HOffset;
         int32 Offset;
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
         uint32 LineHOffset;
         uint32 s;
         bool8_32 left_hand_edge;

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

         LineHOffset    = LineData [Y].BG[bg].HOffset;
         s              = Left * GFX_PIXSIZE + Y * GFX_PPL;
         left_hand_edge = (Left == 0);
         Width          = Right - Left;

         if (Left & 7)
            MaxCount = 8 - (Left & 7);

         while (Left < Right)
         {
            int      tx_index;
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
   int Y;
   int endy;
   int Lines;
   int VOffsetShift = 3;
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

   if (BG.TileSize == 16)
      VOffsetShift = 4;
   endy = GFX.EndY;

   for (Y = GFX.StartY; Y <= endy; Y += Lines)
   {
      uint16* b1;
      uint16* b2;
      int ScreenLine;
      int t1;
      int t2;
      int y = Y;
      int clip;
      int clipcount;
      uint32 VOffset = LineData [y].BG[bg].VOffset;
      uint32 HOffset = LineData [y].BG[bg].HOffset;
      int VirtAlign = (Y + VOffset) & 7;

      for (Lines = 1; Lines < 8 - VirtAlign; Lines++)
         if ((VOffset != LineData [y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [y + Lines].BG[bg].HOffset))
            break;

      HOffset <<= 1;
      if (Y + Lines > endy)
         Lines = endy + 1 - Y;

      ScreenLine = (VOffset + Y) >> VOffsetShift;
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

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;
      for (clip = 0; clip < clipcount; clip++)
      {
         int C;
         int Middle;
         int Left;
         int Right;
         uint16* t;
         uint32 s;
         uint32 HPos;
         uint32 Quot;
         uint32 Count = 0;

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

         s            = (Left >> 1) * GFX_PIXSIZE + Y * GFX_PPL;
         HPos         = (HOffset + Left * GFX_PIXSIZE) & 0x3ff;
         Quot         = HPos >> 3;

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

         Middle = Count >> 3;
         Count &= 7;
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
   int Lines;
   uint32 Y;
   uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint32 Width;
   uint8 depths [2] = {Z1, Z2};

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   if (PPU.BG[bg].SCSize & 1)
      SC1 = SC0 + 1024;
   else
      SC1 = SC0;

   if (SC1 >= (unsigned short*)(Memory.VRAM + 0x10000))
      SC1 = (uint16*)&Memory.VRAM[((uint8*)SC1 - &Memory.VRAM[0]) % 0x10000];

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


   TileBlank = 0xFFFFFFFF;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      int clip;
      int clipcount;
      uint16* b1;
      uint16* b2;
      uint32 ScreenLine;
      uint32 VOffset = LineData [Y].BG[bg].VOffset;
      uint32 HOffset = LineData [Y].BG[bg].HOffset;
      int VirtAlign = (Y + VOffset) & 7;

      for (Lines = 1; Lines < 8 - VirtAlign; Lines++)
         if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [Y + Lines].BG[bg].HOffset))
            break;

      if (Y + Lines > GFX.EndY)
         Lines = GFX.EndY + 1 - Y;

      VirtAlign <<= 3;
      ScreenLine = (VOffset + Y) >> 3;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;
      for (clip = 0; clip < clipcount; clip++)
      {
         int C;
         uint32 Left;
         uint32 Right;
         uint32 s;
         uint16* t;
         uint32 Count = 0;
         uint32 HPos, Quot;

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

         s    = Left + Y * GFX_PPL;
         HPos = (HOffset + Left) & 0x1ff;
         Quot = HPos >> 3;

         if (Quot > 31)
            t = b2 + (Quot & 0x1f);
         else
            t = b1 +  Quot;

         Width = Right - Left;

         // Left hand edge clipped tile
         if (HPos & 7)
         {
            int32 Offset = (HPos & 7);
            Count = 8 - Offset;
            if (Count > Width)
               Count = Width;
            s -= Offset;
            Tile = READ_2BYTES(t);
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
            }
            t++;
            if (Quot == 31)   t = b2;
            else if (Quot == 63)  t = b1;
            Quot++;
            s += 8;
         }

         // Middle, unclipped tiles
         Count = Width - Count;
         for (C = Count >> 3; C > 0; s += 8, Quot++, C--)
         {
            Tile = READ_2BYTES(t);
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawTilePtr)(Tile, s, VirtAlign, Lines);
            }

            t++;
            if (Quot == 31) t = b2;
            else if (Quot == 63)  t = b1;
         }

         // Right-hand edge clipped tiles
         if (Count)
         {
            Tile = READ_2BYTES(t);
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, 0, Count & 7, VirtAlign, Lines);
            }
         }
      }
   }
   GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
}

void DrawBackground_16(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
   int Lines;
   uint32 Y;
   uint32 Tile;
   uint16* SC0;
   uint16* SC1;
   uint16* SC2;
   uint16* SC3;
   uint32 Width;
   uint8 depths [2] = {Z1, Z2};

   SC0 = (uint16*) &Memory.VRAM[PPU.BG[bg].SCBase << 1];

   if (PPU.BG[bg].SCSize & 1)
      SC1 = SC0 + 1024;
   else
      SC1 = SC0;

   if (SC1 >= (unsigned short*)(Memory.VRAM + 0x10000))
      SC1 = (uint16*)&Memory.VRAM[((uint8*)SC1 - &Memory.VRAM[0]) % 0x10000];

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


   TileBlank = 0xFFFFFFFF;
   for (Y = GFX.StartY; Y <= GFX.EndY; Y += Lines)
   {
      int clip;
      int clipcount;
      int tx_index;
      uint32 ScreenLine;
      uint16* b1;
      uint16* b2;
      uint32 VOffset = LineData [Y].BG[bg].VOffset;
      uint32 HOffset = LineData [Y].BG[bg].HOffset;
      int VirtAlign = (Y + VOffset) & 7;

      for (Lines = 1; Lines < 8 - VirtAlign; Lines++)
         if ((VOffset != LineData [Y + Lines].BG[bg].VOffset) ||
               (HOffset != LineData [Y + Lines].BG[bg].HOffset))
            break;

      if (Y + Lines > GFX.EndY)
         Lines = GFX.EndY + 1 - Y;

      VirtAlign <<= 3;


      ScreenLine = (VOffset + Y) >> 4;
      tx_index = (((VOffset + Y) & 15) <= 7) << 3;

      if (ScreenLine & 0x20)
         b1 = SC2, b2 = SC3;
      else
         b1 = SC0, b2 = SC1;

      b1 += (ScreenLine & 0x1f) << 5;
      b2 += (ScreenLine & 0x1f) << 5;

      clipcount = GFX.pCurrentClip->Count [bg];
      if (!clipcount)
         clipcount = 1;
      for (clip = 0; clip < clipcount; clip++)
      {
         int C;
         uint32 Left;
         uint32 Right;
         uint32 s;
         uint32 HPos;
         uint32 Quot;
         uint32 Count = 0;
         uint16* t;

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

         s = Left + Y * GFX_PPL;
         HPos = (HOffset + Left) & 0x3ff;
         Quot = HPos >> 3;

         if (Quot > 63) t = b2 + ((Quot >> 1) & 0x1f);
         else t = b1 + (Quot >> 1);

         Width = Right - Left;

         // Left hand edge clipped tile
         if (HPos & 7)
         {
            int32 Offset = (HPos & 7);
            Count = 8 - Offset;
            if (Count > Width) Count = Width;
            s -= Offset;
            Tile = READ_2BYTES(t);
            Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13) + (Quot & 1)];
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, Offset, Count, VirtAlign, Lines);
            }

            t += Quot & 1;
            if (Quot == 63) t = b2;
            else if (Quot == 127) t = b1;
            Quot++;
            s += 8;
         }

         // Middle, unclipped tiles
         Count = Width - Count;
         for (C = Count >> 3; C > 0; s += 8, Quot++, C--)
         {
            Tile = READ_2BYTES(t);
            Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13) + (Quot & 1)];
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawTilePtr)(Tile, s, VirtAlign, Lines);
            }

            t += Quot & 1;
            if (Quot == 63) t = b2;
            else if (Quot == 127) t = b1;
         }

         // Right-hand edge clipped tiles
         if (Count)
         {
            Tile = READ_2BYTES(t);
            Tile += tx_table[tx_index + ((Tile & (H_FLIP | V_FLIP)) >> 13) + (Quot & 1)];
            if (Tile != TileBlank)
            {
               GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
               (*DrawClippedTilePtr)(Tile, s, 0, Count & 7, VirtAlign, Lines);
            }
         }
      }
   }
   GFX.Z1 = GFX.Z2 = depths [(Tile & 0x2000) >> 13];
}

static INLINE void DrawBackground(uint32 BGMode, uint32 bg, uint8 Z1, uint8 Z2)
{
   //StartAnalyze();

   BG.TileSize = BGSizes [PPU.BG[bg].BGSize];
   BG.BitShift = BitShifts[BGMode][bg];
   BG.TileShift = TileShifts[BGMode][bg];
   BG.TileAddress = PPU.BG[bg].NameBase << 1;
   BG.NameSelect = 0;
   BG.Buffer = IPPU.TileCache [Depths [BGMode][bg]];
   BG.Buffered = IPPU.TileCached [Depths [BGMode][bg]];
   BG.PaletteShift = PaletteShifts[BGMode][bg];
   BG.PaletteMask = PaletteMasks[BGMode][bg];
   BG.DirectColourMode = (BGMode == 3 || BGMode == 4) && bg == 0 &&
                         (GFX.r2130 & 1);

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
      return;

   case 5:
   case 6: // XXX: is also offset per tile.
      DrawBackgroundMode5(BGMode, bg, Z1, Z2);
      return;
   }

   if (BGMode == 0)
      BG.StartPalette = bg << 5;
   else BG.StartPalette = 0;

   SelectPalette();

   if (BG.TileSize == 8)
      DrawBackground_8(BGMode, bg, Z1, Z2);
   else
      DrawBackground_16(BGMode, bg, Z1, Z2);
}

#define RENDER_BACKGROUND_MODE7(FUNC) \
    int aa, cc; \
    int dir; \
    int startx, endx; \
    uint32 Left = 0; \
    uint32 Right = 256; \
    uint32 clip, Line; \
    uint32 ClipCount; \
    SLineMatrixData *l; \
    uint8 *VRAM1 = Memory.VRAM + 1; \
    if (GFX.r2130 & 1) \
    { \
      if (IPPU.DirectColourMapsNeedRebuild) \
         S9xBuildDirectColourMaps (); \
      GFX.ScreenColors = DirectColourMaps [0]; \
    } \
    else \
      GFX.ScreenColors = IPPU.ScreenColors; \
\
    ClipCount = GFX.pCurrentClip->Count [bg]; \
    if (!ClipCount) \
      ClipCount = 1; \
\
    Screen += GFX.StartY * GFX_PITCH; \
    l       = &LineMatrixData [GFX.StartY]; \
\
    for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, l++) \
    { \
   int yy, BB, DD; \
\
   int32 HOffset = ((int32) LineData [Line].BG[0].HOffset << M7) >> M7; \
   int32 VOffset = ((int32) LineData [Line].BG[0].VOffset << M7) >> M7; \
\
   int32 CentreX = ((int32) l->CentreX << M7) >> M7; \
   int32 CentreY = ((int32) l->CentreY << M7) >> M7; \
\
   if (PPU.Mode7VFlip) \
       yy = 255 - (int) Line; \
   else \
       yy = Line; \
\
   if (PPU.Mode7Repeat == 0) \
       yy += (VOffset - CentreY) % 1023; \
   else \
       yy += VOffset - CentreY; \
   BB = l->MatrixB * yy + (CentreX << 8); \
   DD = l->MatrixD * yy + (CentreY << 8); \
\
   for (clip = 0; clip < ClipCount; clip++) \
   { \
       int xx; \
       int AA, CC; \
       uint16 *p; \
       if (GFX.pCurrentClip->Count [bg]) \
       { \
         Left = GFX.pCurrentClip->Left [clip][bg]; \
         Right = GFX.pCurrentClip->Right [clip][bg]; \
         if (Right <= Left) \
            continue; \
       } \
       p = (uint16 *) Screen + Left; \
\
       if (PPU.Mode7HFlip) \
       { \
         startx = Right - 1; \
         endx = Left - 1; \
         dir = -1; \
         aa = -l->MatrixA; \
         cc = -l->MatrixC; \
       } \
       else \
       { \
         startx = Left; \
         endx = Right; \
         dir = 1; \
         aa = l->MatrixA; \
         cc = l->MatrixC; \
       } \
       if (PPU.Mode7Repeat == 0) \
      xx = startx + (HOffset - CentreX) % 1023; \
       else \
      xx = startx + HOffset - CentreX; \
       AA = l->MatrixA * xx; \
       CC = l->MatrixC * xx; \
\
       if (!PPU.Mode7Repeat) \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++) \
      { \
         int X = ((AA + BB) >> 8) & 0x3ff; \
         int Y = ((CC + DD) >> 8) & 0x3ff; \
          uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
          uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
          if (b) \
          { \
            *p = (FUNC); \
          } \
      } \
       } \
       else \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++) \
      { \
          int X = ((AA + BB) >> 8); \
          int Y = ((CC + DD) >> 8); \
\
          if (Settings.Dezaemon && PPU.Mode7Repeat == 2) \
          { \
            X &= 0x7ff; \
            Y &= 0x7ff; \
          } \
\
          if (((X | Y) & ~0x3ff) == 0) \
          { \
            uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
            uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
            if (b) \
               *p = (FUNC); \
          } \
          else \
          { \
            if (PPU.Mode7Repeat == 3) \
            { \
               uint32 b; \
               X = (x + HOffset) & 7; \
               Y = (yy + CentreY) & 7; \
               b = *(VRAM1 + ((Y & 7) << 4) + ((X & 7) << 1)); \
             if (b ) \
                  *p = (FUNC); \
            } \
          } \
      } \
       } \
   } \
    }

#define RENDER_BACKGROUND_MODE7ADDSUB(DEPTH, FUNC) \
    int aa, cc; \
    int dir; \
    int startx, endx; \
    uint32 Left = 0; \
    uint32 Right = 256; \
   uint32 clip, Line; \
    uint8 *VRAM1 = Memory.VRAM + 1; \
    uint32 ClipCount; \
    uint8 *Depth; \
    SLineMatrixData *l; \
    if (GFX.r2130 & 1) \
    { \
      if (IPPU.DirectColourMapsNeedRebuild) \
         S9xBuildDirectColourMaps (); \
      GFX.ScreenColors = DirectColourMaps [0]; \
    } \
    else \
      GFX.ScreenColors = IPPU.ScreenColors; \
\
    ClipCount = GFX.pCurrentClip->Count [bg]; \
\
    if (!ClipCount) \
   ClipCount = 1; \
\
    Screen += GFX.StartY * GFX_PITCH; \
    Depth   = GFX.DB + GFX.StartY * GFX_PPL; \
    l       = &LineMatrixData [GFX.StartY]; \
\
    for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, Depth += GFX_PPL, l++) \
    { \
       int BB, DD; \
   int yy; \
\
   int32 HOffset = ((int32) LineData [Line].BG[0].HOffset << M7) >> M7; \
   int32 VOffset = ((int32) LineData [Line].BG[0].VOffset << M7) >> M7; \
\
   int32 CentreX = ((int32) l->CentreX << M7) >> M7; \
   int32 CentreY = ((int32) l->CentreY << M7) >> M7; \
\
   if (PPU.Mode7VFlip) \
       yy = 255 - (int) Line; \
   else \
       yy = Line; \
\
   if (PPU.Mode7Repeat == 0) \
       yy += (VOffset - CentreY) % 1023; \
   else \
       yy += VOffset - CentreY; \
   BB = l->MatrixB * yy + (CentreX << 8); \
   DD = l->MatrixD * yy + (CentreY << 8); \
\
   for (clip = 0; clip < ClipCount; clip++) \
   { \
      int AA, CC; \
       int xx; \
      uint16 *p; \
      uint8 *d; \
       if (GFX.pCurrentClip->Count [bg]) \
       { \
         Left = GFX.pCurrentClip->Left [clip][bg]; \
         Right = GFX.pCurrentClip->Right [clip][bg]; \
         if (Right <= Left) \
            continue; \
       } \
       p = (uint16 *) Screen + Left; \
       d = Depth + Left; \
\
       if (PPU.Mode7HFlip) \
       { \
         startx = Right - 1; \
         endx = Left - 1; \
         dir = -1; \
         aa = -l->MatrixA; \
         cc = -l->MatrixC; \
       } \
       else \
       { \
         startx = Left; \
         endx = Right; \
         dir = 1; \
         aa = l->MatrixA; \
         cc = l->MatrixC; \
       } \
       if (PPU.Mode7Repeat == 0) \
      xx = startx + (HOffset - CentreX) % 1023; \
       else \
      xx = startx + HOffset - CentreX; \
       AA = l->MatrixA * xx; \
       CC = l->MatrixC * xx; \
\
       if (!PPU.Mode7Repeat) \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++, d++) \
      { \
          int X = ((AA + BB) >> 8) & 0x3ff; \
          int Y = ((CC + DD) >> 8) & 0x3ff; \
          uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
          uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
         if (DEPTH > *d && (b) ) \
          { \
            *p = (FUNC); \
            *d = DEPTH; \
          } \
      } \
       } \
       else \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++, d++) \
      { \
          int X = ((AA + BB) >> 8); \
          int Y = ((CC + DD) >> 8); \
\
          if (Settings.Dezaemon && PPU.Mode7Repeat == 2) \
          { \
            X &= 0x7ff; \
            Y &= 0x7ff; \
          } \
\
          if (((X | Y) & ~0x3ff) == 0) \
          { \
            uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
            uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
            if (DEPTH > *d && (b) ) \
            { \
               *p = (FUNC); \
               *d = DEPTH; \
            } \
          } \
          else \
          { \
            if (PPU.Mode7Repeat == 3) \
            { \
               uint32 b; \
               X = (x + HOffset) & 7; \
               Y = (yy + CentreY) & 7; \
               b = *(VRAM1 + ((Y & 7) << 4) + ((X & 7) << 1)); \
               if (DEPTH > *d && (b) ) \
               { \
                  *p = (FUNC); \
                  *d = DEPTH; \
               } \
            } \
          } \
      } \
       } \
   } \
    }

#define RENDER_BACKGROUND_MODE7PRIO(FUNC) \
   SLineMatrixData *l; \
    int aa, cc; \
    int dir; \
    int startx, endx; \
    uint32 Left = 0; \
    uint32 Right = 256; \
   uint32 clip, Line; \
   uint32 ClipCount; \
   uint8 *Depth; \
    uint8 *VRAM1 = Memory.VRAM + 1; \
    if (GFX.r2130 & 1) \
    { \
      if (IPPU.DirectColourMapsNeedRebuild) \
         S9xBuildDirectColourMaps (); \
      GFX.ScreenColors = DirectColourMaps [0]; \
    } \
    else \
      GFX.ScreenColors = IPPU.ScreenColors; \
\
    ClipCount = GFX.pCurrentClip->Count [bg]; \
\
    if (!ClipCount) \
   ClipCount = 1; \
\
    Screen += GFX.StartY * GFX_PITCH; \
    Depth   = GFX.DB + GFX.StartY * GFX_PPL; \
    l       = &LineMatrixData [GFX.StartY]; \
\
    for (Line = GFX.StartY; Line <= GFX.EndY; Line++, Screen += GFX_PITCH, Depth += GFX_PPL, l++) \
    { \
       int BB, DD; \
       int yy; \
\
   int32 HOffset = ((int32) LineData [Line].BG[0].HOffset << M7) >> M7; \
   int32 VOffset = ((int32) LineData [Line].BG[0].VOffset << M7) >> M7; \
\
   int32 CentreX = ((int32) l->CentreX << M7) >> M7; \
   int32 CentreY = ((int32) l->CentreY << M7) >> M7; \
\
   if (PPU.Mode7VFlip) \
       yy = 255 - (int) Line; \
   else \
       yy = Line; \
\
   if (PPU.Mode7Repeat == 0) \
       yy += (VOffset - CentreY) % 1023; \
   else \
       yy += VOffset - CentreY; \
   BB = l->MatrixB * yy + (CentreX << 8); \
   DD = l->MatrixD * yy + (CentreY << 8); \
\
   for (clip = 0; clip < ClipCount; clip++) \
   { \
       int AA, CC; \
       int xx; \
      uint16 *p; \
      uint8 *d; \
       if (GFX.pCurrentClip->Count [bg]) \
       { \
         Left = GFX.pCurrentClip->Left [clip][bg]; \
         Right = GFX.pCurrentClip->Right [clip][bg]; \
         if (Right <= Left) \
            continue; \
       } \
       p = (uint16 *) Screen + Left; \
       d = Depth + Left; \
\
       if (PPU.Mode7HFlip) \
       { \
         startx = Right - 1; \
         endx = Left - 1; \
         dir = -1; \
         aa = -l->MatrixA; \
         cc = -l->MatrixC; \
       } \
       else \
       { \
         startx = Left; \
         endx = Right; \
         dir = 1; \
         aa = l->MatrixA; \
         cc = l->MatrixC; \
       } \
       if (PPU.Mode7Repeat == 0) \
      xx = startx + (HOffset - CentreX) % 1023; \
       else \
      xx = startx + HOffset - CentreX; \
       AA = l->MatrixA * xx; \
       CC = l->MatrixC * xx; \
\
       if (!PPU.Mode7Repeat) \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++, d++) \
      { \
          int X = ((AA + BB) >> 8) & 0x3ff; \
          int Y = ((CC + DD) >> 8) & 0x3ff; \
          uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
          uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
          GFX.Z1 = Mode7Depths [(b & 0x80) >> 7]; \
          if (GFX.Z1 > *d && (b & 0x7f) ) \
          { \
            *p = (FUNC); \
            *d = GFX.Z1; \
          } \
      } \
       } \
       else \
       { \
          int x; \
      for (x = startx; x != endx; x += dir, AA += aa, CC += cc, p++, d++) \
      { \
          int X = ((AA + BB) >> 8); \
          int Y = ((CC + DD) >> 8); \
\
          if (Settings.Dezaemon && PPU.Mode7Repeat == 2) \
          { \
            X &= 0x7ff; \
            Y &= 0x7ff; \
          } \
\
          if (((X | Y) & ~0x3ff) == 0) \
          { \
            uint8 *TileData = VRAM1 + (Memory.VRAM[((Y & ~7) << 5) + ((X >> 2) & ~1)] << 7); \
            uint32 b = *(TileData + ((Y & 7) << 4) + ((X & 7) << 1)); \
            GFX.Z1 = Mode7Depths [(b & 0x80) >> 7]; \
         if (GFX.Z1 > *d && (b & 0x7f) ) \
            { \
               *p = (FUNC); \
               *d = GFX.Z1; \
            } \
          } \
          else \
          { \
            if (PPU.Mode7Repeat == 3) \
            { \
               uint32 b; \
               X      = (x + HOffset) & 7; \
               Y      = (yy + CentreY) & 7; \
               b      = *(VRAM1 + ((Y & 7) << 4) + ((X & 7) << 1)); \
               GFX.Z1 = Mode7Depths [(b & 0x80) >> 7]; \
               if (GFX.Z1 > *d && (b & 0x7f) ) \
               { \
                  *p = (FUNC); \
                  *d = GFX.Z1; \
               } \
            } \
          } \
      } \
       } \
   } \
    }

void DrawBGMode7Background16New(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7(GFX.ScreenColors [b & 0xff]);
}

void DrawBGMode7Background16(uint8* Screen, int bg, int depth)
{
   RENDER_BACKGROUND_MODE7ADDSUB(depth, GFX.ScreenColors [b & 0xff]);
}

void DrawBGMode7Background16Add(uint8* Screen, int bg, int depth)
{
   RENDER_BACKGROUND_MODE7ADDSUB(depth, *(d + GFX.DepthDelta) ?
                                 (*(d + GFX.DepthDelta) != 1 ?
                                  COLOR_ADD(GFX.ScreenColors [b & 0xff],
                                        p [GFX.Delta]) :
                                  COLOR_ADD(GFX.ScreenColors [b & 0xff],
                                        GFX.FixedColour)) :
                                 GFX.ScreenColors [b & 0xff]);

}

void DrawBGMode7Background16Add1_2(uint8* Screen, int bg, int depth)
{
   RENDER_BACKGROUND_MODE7ADDSUB(depth, *(d + GFX.DepthDelta) ?
                                 (*(d + GFX.DepthDelta) != 1 ?
                                  COLOR_ADD1_2(GFX.ScreenColors [b & 0xff],
                                        p [GFX.Delta]) :
                                  COLOR_ADD(GFX.ScreenColors [b & 0xff],
                                        GFX.FixedColour)) :
                                 GFX.ScreenColors [b & 0xff]);
}

void DrawBGMode7Background16Sub(uint8* Screen, int bg, int depth)
{
   RENDER_BACKGROUND_MODE7ADDSUB(depth, *(d + GFX.DepthDelta) ?
                                 (*(d + GFX.DepthDelta) != 1 ?
                                  COLOR_SUB(GFX.ScreenColors [b & 0xff],
                                        p [GFX.Delta]) :
                                  COLOR_SUB(GFX.ScreenColors [b & 0xff],
                                        GFX.FixedColour)) :
                                 GFX.ScreenColors [b & 0xff]);
}

void DrawBGMode7Background16Sub1_2(uint8* Screen, int bg, int depth)
{
   RENDER_BACKGROUND_MODE7ADDSUB(depth, *(d + GFX.DepthDelta) ?
                                 (*(d + GFX.DepthDelta) != 1 ?
                                  COLOR_SUB1_2(GFX.ScreenColors [b & 0xff],
                                        p [GFX.Delta]) :
                                  COLOR_SUB(GFX.ScreenColors [b & 0xff],
                                        GFX.FixedColour)) :
                                 GFX.ScreenColors [b & 0xff]);
}

void DrawBGMode7Background16Prio(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7PRIO(GFX.ScreenColors [b & 0x7f]);
}

void DrawBGMode7Background16AddPrio(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7PRIO(*(d + GFX.DepthDelta) ?
                               (*(d + GFX.DepthDelta) != 1 ?
                                COLOR_ADD(GFX.ScreenColors [b & 0x7f],
                                          p [GFX.Delta]) :
                                COLOR_ADD(GFX.ScreenColors [b & 0x7f],
                                          GFX.FixedColour)) :
                               GFX.ScreenColors [b & 0x7f]);
}

void DrawBGMode7Background16Add1_2Prio(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7PRIO(*(d + GFX.DepthDelta) ?
                               (*(d + GFX.DepthDelta) != 1 ?
                                COLOR_ADD1_2(GFX.ScreenColors [b & 0x7f],
                                      p [GFX.Delta]) :
                                COLOR_ADD(GFX.ScreenColors [b & 0x7f],
                                          GFX.FixedColour)) :
                               GFX.ScreenColors [b & 0x7f]);
}

void DrawBGMode7Background16SubPrio(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7PRIO(*(d + GFX.DepthDelta) ?
                               (*(d + GFX.DepthDelta) != 1 ?
                                COLOR_SUB(GFX.ScreenColors [b & 0x7f],
                                          p [GFX.Delta]) :
                                COLOR_SUB(GFX.ScreenColors [b & 0x7f],
                                          GFX.FixedColour)) :
                               GFX.ScreenColors [b & 0x7f]);
}

void DrawBGMode7Background16Sub1_2Prio(uint8* Screen, int bg)
{
   RENDER_BACKGROUND_MODE7PRIO(*(d + GFX.DepthDelta) ?
                               (*(d + GFX.DepthDelta) != 1 ?
                                COLOR_SUB1_2(GFX.ScreenColors [b & 0x7f],
                                      p [GFX.Delta]) :
                                COLOR_SUB(GFX.ScreenColors [b & 0x7f],
                                          GFX.FixedColour)) :
                               GFX.ScreenColors [b & 0x7f]);
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

   sub |= force_no_add;

   if (PPU.BGMode <= 1)
   {
      if (OB)
      {
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
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
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
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
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
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
                     DrawBGMode7Background16Sub1_2Prio(Screen, bg);
                  else
                     DrawBGMode7Background16SubPrio(Screen, bg);
               }
               else
               {
                  if (GFX.r2131 & 0x40)
                     DrawBGMode7Background16Add1_2Prio(Screen, bg);
                  else
                     DrawBGMode7Background16AddPrio(Screen, bg);
               }
            }
         }
         else
         {
            bg = 0;
            if (sub || !SUB_OR_ADD(0))
            {
               if (D || !SNESGameFixes.Mode7Hack)
                  DrawBGMode7Background16(Screen, bg, D + 5);
               else
                  DrawBGMode7Background16New(Screen, bg);
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
         SelectTileRenderer(sub || !SUB_OR_ADD(4), false);
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

void S9xUpdateScreen(void)  // ~30-50ms! (called from FLUSH_REDRAW())
{
   uint32 black;
   uint32 starty, endy;
   uint8_t *memoryfillram;
   int32 x2 = 1;

   GFX.S = GFX.Screen;
   memoryfillram = Memory.FillRAM;

   // get local copies of vid registers to be used later
   GFX.r2131 = memoryfillram [0x2131]; // ADDITION/SUBTRACTION & SUBTRACTION DESIGNATION FOR EACH SCREEN
   GFX.r212c = memoryfillram [0x212c]; // MAIN SCREEN, DESIGNATION - used to enable BGS
   GFX.r212d = memoryfillram [0x212d]; // SUB SCREEN DESIGNATION - used to enable sub BGS
   GFX.r2130 = memoryfillram [0x2130]; // INITIAL SETTINGS FOR FIXED COLOR ADDITION OR SCREEN ADDITION

   // If external sync is off and
   // main screens have not been configured the same as the sub screen and
   // color addition and subtraction has been diabled then
   // Pseudo is 1
   // anything else it is 0
   GFX.Pseudo = (memoryfillram [0x2133] & 8) != 0 && // Use EXTERNAL SYNCHRONIZATION?
                (GFX.r212c & 15) != (GFX.r212d & 15) && // Are the main screens different from the sub screens?
                (GFX.r2131 & 0x3f) == 0; // Is colour data addition/subtraction disabled on all BGS?

   // If sprite data has been changed then go through and
   // refresh the sprites.
   if (IPPU.OBJChanged)
      S9xSetupOBJ();

   if (PPU.RecomputeClipWindows)
   {
      ComputeClipWindows();
      PPU.RecomputeClipWindows = FALSE;
   }

   GFX.StartY = IPPU.PreviousLine;
   if ((GFX.EndY = IPPU.CurrentLine - 1) >= PPU.ScreenHeight)
      GFX.EndY = PPU.ScreenHeight - 1;

   starty = GFX.StartY;
   endy = GFX.EndY;

   if (Settings.SupportHiRes &&
         (PPU.BGMode == 5 || PPU.BGMode == 6 || IPPU.LatchedInterlace))
   {
      if (PPU.BGMode == 5 || PPU.BGMode == 6)
      {
         IPPU.RenderedScreenWidth = 512;
         x2 = 2;
      }
      if (IPPU.LatchedInterlace)
      {
         starty = GFX.StartY * 2;
         endy = GFX.EndY * 2 + 1;
      }
      if (!IPPU.DoubleWidthPixels)
      {
         uint32 y;
         // The game has switched from lo-res to hi-res mode part way down
         // the screen. Scale any existing lo-res pixels on screen
         for (y = 0; y < GFX.StartY; y++)
         {
            int x;
            uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + 255;
            uint16* q = (uint16*)(GFX.Screen + y * GFX_PITCH) + 510;
            for (x = 255; x >= 0; x--, p--, q -= 2)
               * q = *(q + 1) = *p;
         }
         IPPU.DoubleWidthPixels = TRUE;
      }
   }

   black = BLACK | (BLACK << 16);

   // Are we worrying about transparencies?
   if (Settings.Transparency)
   {
      if (GFX.Pseudo)
      {
         GFX.r2131 = 0x5f;  //0101 1111 - enable addition/subtraction on all BGS and sprites and "1/2 OF COLOR DATA" DESIGNATION
         GFX.r212c &= (Memory.FillRAM [0x212d] | 0xf0);
         GFX.r212d |= (Memory.FillRAM [0x212c] & 0x0f);
         GFX.r2130 |= 2; // enable ADDITION/SUBTRACTION FOR SUB SCREEN
      }

      // Check to see if any transparency effects are currently in use
      if (!PPU.ForcedBlanking && ADD_OR_SUB_ON_ANYTHING &&
            (GFX.r2130 & 0x30) != 0x30 &&
            !((GFX.r2130 & 0x30) == 0x10 && IPPU.Clip[1].Count[5] == 0))
      {
         // transparency effects in use, so lets get busy!
         ClipData* pClip;
         uint32 fixedColour;
         GFX.FixedColour = BUILD_PIXEL(IPPU.XB [PPU.FixedColourRed],
                                       IPPU.XB [PPU.FixedColourGreen],
                                       IPPU.XB [PPU.FixedColourBlue]);
         fixedColour = (GFX.FixedColour << 16 | GFX.FixedColour);
         // Clear the z-buffer, marking areas 'covered' by the fixed
         // colour as depth 1.
         pClip = &IPPU.Clip [1];

         // Clear the z-buffer

         if (pClip->Count [5])
         {

            // Colour window enabled.

#ifdef RC_OPTIMIZED
            for (uint32 y = starty; y <= endy; y++)
            {

               memset(GFX.SubZBuffer + y * GFX_ZPITCH, 0,
                          IPPU.RenderedScreenWidth);
               memset(GFX.ZBuffer + y * GFX_ZPITCH, 0,
                          IPPU.RenderedScreenWidth);

               if (IPPU.Clip [0].Count [5])
                  memset((GFX.SubScreen + y * GFX_PITCH), black, IPPU.RenderedScreenWidth);
               for (uint32 c = 0; c < pClip->Count [5]; c++)
               {
                  if (pClip->Right [c][5] > pClip->Left [c][5])
                  {
                     memset(GFX.SubZBuffer + y * GFX_ZPITCH + pClip->Left [c][5] * x2,
                            1, (pClip->Right [c][5] - pClip->Left [c][5]) * x2);
                     if (IPPU.Clip [0].Count [5])
                     {
                        // Blast, have to clear the sub-screen to the fixed-colour
                        // because there is a colour window in effect clipping
                        // the main screen that will allow the sub-screen
                        // 'underneath' to show through.
                        memset((GFX.SubScreen + y * GFX_PITCH) + pClip->Left [c][5] * x2,
                               GFX.FixedColour,
                               pClip->Right[c][5]*x2 - pClip->Left [c][5] * x2);
                     }
                  }
               }
            }

#else // NOT RC_OPTIMIZED
            /* loop around all of the lines being updated */
            uint32 y;
            for (y = starty; y <= endy; y++)
            {
               uint32 c;
               // Clear the subZbuffer
               memset32((uint32_t*)(GFX.SubZBuffer + y * GFX_ZPITCH), 0,
                        IPPU.RenderedScreenWidth >> 2);
               // Clear the Zbuffer
               memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0,
                        IPPU.RenderedScreenWidth >> 2);

               // if there is clipping then clear subscreen to a black color
               if (IPPU.Clip [0].Count [5])
                  memset32((uint32_t*)(GFX.SubScreen + y * GFX_PITCH), black, IPPU.RenderedScreenWidth >> 1);

               // loop through all window clippings
               for (c = 0; c < pClip->Count [5]; c++)
               {
                  if (pClip->Right [c][5] > pClip->Left [c][5])
                  {
                     memset(GFX.SubZBuffer + y * GFX_ZPITCH + pClip->Left [c][5] * x2,
                            1, (pClip->Right [c][5] - pClip->Left [c][5]) * x2);
                     if (IPPU.Clip [0].Count [5])
                     {
                        // Blast, have to clear the sub-screen to the fixed-colour
                        // because there is a colour window in effect clipping
                        // the main screen that will allow the sub-screen
                        // 'underneath' to show through.

                        uint16* p = (uint16*)(GFX.SubScreen + y * GFX_PITCH);
                        uint16* q = p + pClip->Right [c][5] * x2;
                        p += pClip->Left [c][5] * x2;

                        while (p < q)
                           *p++ = (uint16) GFX.FixedColour;
                     }
                  }
               }
            }
#endif
            //#undef RC_OPTIMIZED

         }
         else
         {
            // No windows are clipping the main screen
            // this simplifies the screen clearing process
#ifdef RC_OPTIMIZED

            if (GFX_ZPITCH == (uint32)IPPU.RenderedScreenWidth)
            {

               memset(GFX.ZBuffer + starty * GFX_ZPITCH, 0, GFX_ZPITCH * (endy - starty - 1));
               memset(GFX.SubZBuffer + starty * GFX_ZPITCH, 1, GFX_ZPITCH * (endy - starty - 1));
            }
            else
            {
               for (uint32 y = starty; y <= endy; y++)
               {
                  memset(GFX.ZBuffer + y * GFX_ZPITCH, 0,
                             IPPU.RenderedScreenWidth);
                  memset(GFX.SubZBuffer + y * GFX_ZPITCH, 1,
                         IPPU.RenderedScreenWidth);
               }
            }

            if (IPPU.Clip [0].Count [5])
            {
               // Blast, have to clear the sub-screen to the fixed-colour
               // because there is a colour window in effect clipping
               // the main screen that will allow the sub-screen
               // 'underneath' to show through.
               if (GFX_PITCH == (uint32)IPPU.RenderedScreenWidth)
               {
                  memset((GFX.SubScreen + starty * GFX_PITCH),
                         GFX.FixedColour | (GFX.FixedColour << 16),
                         GFX_PITCH * (endy - starty - 1));
               }
               else
               {
                  for (uint32 y = starty; y <= endy; y++)
                  {
                     memset((GFX.SubScreen + y * GFX_PITCH),
                            GFX.FixedColour | (GFX.FixedColour << 16),
                            IPPU.RenderedScreenWidth);
                  }
               }
            }

#else // NOT RC_OPTIMIZED
            /* loop through all of the lines to be updated */
            uint32 y;
            for (y = starty; y <= endy; y++)
            {
               // Clear the Zbuffer
               memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0,
                        IPPU.RenderedScreenWidth >> 2);
               // clear the sub Zbuffer to 1
               memset32((uint32_t*)(GFX.SubZBuffer + y * GFX_ZPITCH), 0x01010101,
                        IPPU.RenderedScreenWidth >> 2);
               if (IPPU.Clip [0].Count [5])
               {
                  // Blast, have to clear the sub-screen to the fixed-colour
                  // because there is a colour window in effect clipping
                  // the main screen that will allow the sub-screen
                  // 'underneath' to show through.


                  memset32((uint32_t*)(GFX.SubScreen + y * GFX_PITCH), fixedColour,
                           IPPU.RenderedScreenWidth >> 1);
               }
            }
#endif

         }

         if (ANYTHING_ON_SUB)
         {
            GFX.DB = GFX.SubZBuffer;
            RenderScreen(GFX.SubScreen, TRUE, TRUE, SUB_SCREEN_DEPTH);
         }

         if (IPPU.Clip [0].Count [5])
         {
            uint32 y;
            for (y = starty; y <= endy; y++)
            {
               uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH);
               uint8* d = GFX.SubZBuffer + y * GFX_ZPITCH ;
               uint8* e = d + IPPU.RenderedScreenWidth;

               while (d < e)
               {
                  if (*d > 1)
                     *p = *(p + GFX.Delta);
                  else
                     *p = BLACK;
                  d++;
                  p++;
               }
            }
         }

         GFX.DB = GFX.ZBuffer;
         RenderScreen(GFX.Screen, FALSE, FALSE, MAIN_SCREEN_DEPTH);
         if (SUB_OR_ADD(5))
         {
            uint32 y;
            uint32 back = IPPU.ScreenColors [0];
            uint32 Left = 0;
            uint32 Right = 256;
            uint32 Count;

            pClip = &IPPU.Clip [0];

            for (y = starty; y <= endy; y++)
            {
               uint32 b;
               if (!(Count = pClip->Count [5]))
               {
                  Left = 0;
                  Right = 256 * x2;
                  Count = 1;
               }

               for (b = 0; b < Count; b++)
               {
                  if (pClip->Count [5])
                  {
                     Left = pClip->Left [b][5] * x2;
                     Right = pClip->Right [b][5] * x2;
                     if (Right <= Left)
                        continue;
                  }

                  if (GFX.r2131 & 0x80)
                  {
                     if (GFX.r2131 & 0x40)
                     {
                        // Subtract, halving the result.
                        uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                        uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                        uint8* s = GFX.SubZBuffer + y * GFX_ZPITCH + Left;
                        uint8* e = d + Right;
                        uint16 back_fixed = COLOR_SUB(back, GFX.FixedColour);

                        d += Left;
                        while (d < e)
                        {
                           if (*d == 0)
                           {
                              if (*s)
                              {
                                 if (*s != 1)
                                    *p = COLOR_SUB1_2(back, *(p + GFX.Delta));
                                 else
                                    *p = back_fixed;
                              }
                              else
                                 *p = (uint16) back;
                           }
                           d++;
                           p++;
                           s++;
                        }
                     }
                     else
                     {
                        // Subtract
                        uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                        uint8* s = GFX.SubZBuffer + y * GFX_ZPITCH + Left;
                        uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                        uint8* e = d + Right;
                        uint16 back_fixed = COLOR_SUB(back, GFX.FixedColour);

                        d += Left;
                        while (d < e)
                        {
                           if (*d == 0)
                           {
                              if (*s)
                              {
                                 if (*s != 1)
                                    *p = COLOR_SUB(back, *(p + GFX.Delta));
                                 else
                                    *p = back_fixed;
                              }
                              else
                                 *p = (uint16) back;
                           }
                           d++;
                           p++;
                           s++;
                        }
                     }
                  }
                  else if (GFX.r2131 & 0x40)
                  {
                     uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                     uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                     uint8* s = GFX.SubZBuffer + y * GFX_ZPITCH + Left;
                     uint8* e = d + Right;
                     uint16 back_fixed = COLOR_ADD(back, GFX.FixedColour);
                     d += Left;
                     while (d < e)
                     {
                        if (*d == 0)
                        {
                           if (*s)
                           {
                              if (*s != 1)
                                 *p = COLOR_ADD1_2(back, *(p + GFX.Delta));
                              else
                                 *p = back_fixed;
                           }
                           else
                              *p = (uint16) back;
                        }
                        d++;
                        p++;
                        s++;
                     }
                  }
                  else if (back != 0)
                  {
                     uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                     uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                     uint8* s = GFX.SubZBuffer + y * GFX_ZPITCH + Left;
                     uint8* e = d + Right;
                     uint16 back_fixed = COLOR_ADD(back, GFX.FixedColour);
                     d += Left;
                     while (d < e)
                     {
                        if (*d == 0)
                        {
                           if (*s)
                           {
                              if (*s != 1)
                                 *p = COLOR_ADD(back, *(p + GFX.Delta));
                              else
                                 *p = back_fixed;
                           }
                           else
                              *p = (uint16) back;
                        }
                        d++;
                        p++;
                        s++;
                     }
                  }
                  else
                  {
                     if (!pClip->Count [5])
                     {
                        // The backdrop has not been cleared yet - so
                        // copy the sub-screen to the main screen
                        // or fill it with the back-drop colour if the
                        // sub-screen is clear.
                        uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                        uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                        uint8* s = GFX.SubZBuffer + y * GFX_ZPITCH + Left;
                        uint8* e = d + Right;
                        d += Left;
                        while (d < e)
                        {
                           if (*d == 0)
                           {
                              if (*s)
                              {
                                 if (*s != 1)
                                    *p = *(p + GFX.Delta);
                                 else
                                    *p = GFX.FixedColour;
                              }
                              else
                                 *p = (uint16) back;
                           }
                           d++;
                           p++;
                           s++;
                        }
                     }
                  }
               }
            }

         }
         else
         {
            uint32 y;
            // Subscreen not being added to back
            uint32 back = IPPU.ScreenColors [0] | (IPPU.ScreenColors [0] << 16);
            pClip = &IPPU.Clip [0];

            if (pClip->Count [5])
            {
               for (y = starty; y <= endy; y++)
               {
                  uint32 b;
                  for (b = 0; b < pClip->Count [5]; b++)
                  {
                     uint32 Left = pClip->Left [b][5] * x2;
                     uint32 Right = pClip->Right [b][5] * x2;
                     uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + Left;
                     uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                     uint8* e = d + Right;
                     d += Left;

                     while (d < e)
                     {
                        if (*d++ == 0)
                           *p = (int16) back;
                        p++;
                     }
                  }
               }
            }
            else
            {
               for (y = starty; y <= endy; y++)
               {
                  uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH);
                  uint8* d = GFX.ZBuffer + y * GFX_ZPITCH;
                  uint8* e = d + 256 * x2;

                  while (d < e)
                  {
                     if (*d == 0)
#ifdef RC_OPTIMIZED
                        *p++ = back;
                     d++;
#else
                        *p = (int16) back;
                     d++;
                     p++;
#endif
                  }
               }
            }
         }
      }
      else
      {
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

#ifdef RC_OPTIMIZED
            if (GFX_PITCH == (uint32)IPPU.RenderedScreenWidth)
            {
               memset(GFX.Screen + starty * GFX_PITCH, black,
                      GFX_PITCH * (endy - starty - 1));
            }
            else
            {
               for (uint32 y = starty; y <= endy; y++)
               {
                  memset(GFX.Screen + y * GFX_PITCH, black,
                         GFX_PITCH);
               }
            }
            for (uint32 y = starty; y <= endy; y++)
            {
               for (uint32 c = 0; c < IPPU.Clip [0].Count [5]; c++)
               {
                  if (IPPU.Clip [0].Right [c][5] > IPPU.Clip [0].Left [c][5])
                  {

                     memset((GFX.Screen + y * GFX_PITCH) + IPPU.Clip [0].Left [c][5] * x2,
                            back,
                            IPPU.Clip [0].Right [c][5] * x2 - IPPU.Clip [0].Left [c][5] * x2);
                  }
               }
            }
#else
            /* loop through all of the lines that are going to be updated as part of this screen update */
            uint32 y;
            for (y = starty; y <= endy; y++)
            {
               memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), black,
                        IPPU.RenderedScreenWidth >> 1);

               if (black != back)
               {
                  uint32 c;
                  for (c = 0; c < IPPU.Clip [0].Count [5]; c++)
                  {
                     if (IPPU.Clip [0].Right [c][5] > IPPU.Clip [0].Left [c][5])
                     {
                        uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH);   // get pointer to current line in screen buffer
                        uint16* q = p + IPPU.Clip [0].Right [c][5] * x2; // get pointer to end of line
                        p += IPPU.Clip [0].Left [c][5] * x2;

                        while (p < q)
                           *p++ = (uint16) back; // fill all pixels in clipped section with the back colour
                     }
                  }
               }
            }
#endif
         }
         else
         {
#ifdef RC_OPTIMIZED
            if (GFX_PITCH == (uint32)IPPU.RenderedScreenWidth)
            {
               memset(GFX.Screen + starty * GFX_PITCH, back,
                      GFX_PITCH * (endy - starty - 1));
            }
            else
            {
               for (uint32 y = starty; y <= endy; y++)
               {
                  memset(GFX.Screen + y * GFX_PITCH, back,
                         GFX_PITCH);
               }
            }
#else
            /* there is no clipping to worry about so just fill with the back colour */
            uint32 y;

            for (y = starty; y <= endy; y++)
            {
               memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), back,
                        IPPU.RenderedScreenWidth >> 1);
            }
#endif
         }

         // If Forced blanking is not in effect
         if (!PPU.ForcedBlanking)
         {
#ifdef RC_OPTIMIZED
            if (GFX_ZPITCH == (uint32)IPPU.RenderedScreenWidth)
            {
               memset(GFX.ZBuffer + starty * GFX_ZPITCH, 0,
                      GFX_ZPITCH * (endy - starty - 1));
            }
            else
            {
               for (uint32 y = starty; y <= endy; y++)
               {
                  memset(GFX.ZBuffer + y * GFX_ZPITCH, 0,
                         GFX_ZPITCH);
               }
            }
#else
            /* Clear the Zbuffer for each of the lines which are going to be updated */
            uint32 y;
            for (y = starty; y <= endy; y++)
            {
               memset32((uint32_t*)(GFX.ZBuffer + y * GFX_ZPITCH), 0,
                        IPPU.RenderedScreenWidth >> 2);
            }
#endif
            GFX.DB = GFX.ZBuffer;  // save pointer to Zbuffer in GFX object
            RenderScreen(GFX.Screen, FALSE, TRUE, SUB_SCREEN_DEPTH);
         }
      }
   }
   else // Transparencys are disabled, ahh lovely ... nice and easy.
   {
      uint32 y;
      // get back colour to be used in clearing the screen
      uint32 back;
      if (!(Memory.FillRAM [0x2131] & 0x80) && (Memory.FillRAM[0x2131] & 0x20) &&
            (PPU.FixedColourRed || PPU.FixedColourGreen || PPU.FixedColourBlue))
      {
         back = (IPPU.XB[PPU.FixedColourRed] << 11) |
                (IPPU.XB[PPU.FixedColourGreen] << 6) |
                (IPPU.XB[PPU.FixedColourBlue] << 1) | 1;
         back = (back << 16) | back;
      }
      else
         back = IPPU.ScreenColors [0] | (IPPU.ScreenColors [0] << 16);

      // if Forcedblanking in use then back colour becomes black
      if (PPU.ForcedBlanking)
         back = black;
      else
      {
         SelectTileRenderer(TRUE, FALSE);   //selects the tile renderers to be used
         // TRUE means to use the default
         // FALSE means use best renderer based on current
         // graphics register settings
      }

      // now clear all graphics lines which are being updated using the back colour
      for (y = starty; y <= endy; y++)
      {
         memset32((uint32_t*)(GFX.Screen + y * GFX_PITCH), back,
                  IPPU.RenderedScreenWidth >> 1);
      }

      if (!PPU.ForcedBlanking)
      {
         uint32 y;
         uint8 subadd;
         bool8_32 BG0, BG1, BG2, BG3, OB;

         // Loop through all lines being updated and clear the
         // zbuffer for each of the lines
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

         subadd = GFX.r2131 & 0x3f;

         // go through all BGS are check if they need to be displayed
         BG0 = DISPLAY(1) && !(Settings.os9x_hack & GFX_IGNORE_BG0);
         BG1 = DISPLAY(2) && !(Settings.os9x_hack & GFX_IGNORE_BG1);
         BG2 = DISPLAY(4) && !(Settings.os9x_hack & GFX_IGNORE_BG2);
         BG3 = DISPLAY(8) && !(Settings.os9x_hack & GFX_IGNORE_BG3);
         OB  = DISPLAY(16) && !(Settings.os9x_hack & GFX_IGNORE_OBJ);

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
            int bg = 0;

            // screen mode 7
            GFX.Mode7Mask = 0xff;
            GFX.Mode7PriorityMask = 0;
            bg = 0;
            DrawBGMode7Background16New(GFX.Screen, bg);
            if (OB)
            {
               FIXCLIP(4);
               DrawOBJS(FALSE, 0);
            }
         }
      }
   }
#ifndef RC_OPTIMIZE // no hi res
   if (Settings.SupportHiRes && PPU.BGMode != 5 && PPU.BGMode != 6)
   {
      if (IPPU.DoubleWidthPixels)
      {
         uint32 y;
         // Mixure of background modes used on screen - scale width
         // of all non-mode 5 and 6 pixels.
         for (y = GFX.StartY; y <= GFX.EndY; y++)
         {
            int x;
            uint16* p = (uint16*)(GFX.Screen + y * GFX_PITCH) + 255;
            uint16* q = (uint16*)(GFX.Screen + y * GFX_PITCH) + 510;

            for (x = 255; x >= 0; x--, p--, q -= 2)
               * q = *(q + 1) = *p;
         }

      }

      if (IPPU.LatchedInterlace)
      {
         uint32 y;

         // Interlace is enabled - double the height of all non-mode 5 and 6
         // pixels.
         for (y = GFX.StartY; y <= GFX.EndY; y++)
         {
            memcpy32((uint32_t*)(GFX.Screen + (y * 2 + 1) * GFX_PITCH),
                     (uint32_t*)(GFX.Screen + y * 2 * GFX_PITCH),
                     GFX_PITCH >> 2);
         }
      }
   }
#endif
   IPPU.PreviousLine = IPPU.CurrentLine;
}

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
