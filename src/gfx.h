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
#ifndef _GFX_H_
#define _GFX_H_

#include "port.h"
#include "ppu.h"

#define GFX_PIXSIZE 1
#define GFX_PITCH 640
#define GFX_ZPITCH 320
#define GFX_PPL 320

typedef struct
{
   // Initialize these variables
   uint8*  Screen_buffer;
   uint8*  ZBuffer_buffer;
   uint8*  SubZBuffer_buffer;

   uint8*  Screen;
   uint8*  SubScreen;
   uint8*  ZBuffer;
   uint8*  SubZBuffer;
   uint32 Pitch;

   // Setup in call to S9xGraphicsInit()
   int   Delta;
#if defined(USE_OLD_COLOUR_OPS)
   /* Pre-1.60 colour operations */
   uint16* X2;
   uint16* ZERO_OR_X2;
#endif
   uint16* ZERO;
   uint8*  S;
   uint8*  DB;
   uint32* ScreenColors;
   uint32* ScreenColorsPre;
   uint32 PaletteMask;
   uint32 PaletteShift;
   intptr_t DepthDelta;
   uint8  Z1;
   uint8  Z2;
   uint32 FixedColour;
   uint32 StartY;
   uint32 EndY;
   ClipData* pCurrentClip;
   uint32 Mode7Mask;
   uint32 Mode7PriorityMask;

   uint8  r212c;
   uint8  r212c_s;
   uint8  r212d;
   uint8  r212d_s;
   uint8  r212e_s;
   uint8  r212f_s;
   uint8  r2130;
   uint8  r2130_s;
   uint8  r2131;
   uint8  r2131_s;
   bool8  Pseudo;

   int     OBJList [129];
   uint32 Sizes [129];
   int    VPositions [129];

#ifdef GFX_MULTI_FORMAT
   uint32 PixelFormat;
   uint32(*BuildPixel)(uint32 R, uint32 G, uint32 B);
   uint32(*BuildPixel2)(uint32 R, uint32 G, uint32 B);
   void (*DecomposePixel)(uint32 Pixel, uint32 &R, uint32 &G, uint32 &B);
#endif
} SGFX;

typedef struct
{
   struct
   {
      uint16 VOffset;
      uint16 HOffset;
   } BG [4];
} SLineData;

#define H_FLIP 0x4000
#define V_FLIP 0x8000
#define BLANK_TILE 2

typedef struct
{
   uint32 TileSize;
   uint32 BitShift;
   uint32 TileShift;
   uint32 TileAddress;
   uint32 NameSelect;
   uint32 SCBase;

   uint32 StartPalette;
   uint32 PaletteShift;
   uint32 PaletteMask;

   uint8* Buffer;
   uint8* Buffered;
   bool8  DirectColourMode;
} SBG;

typedef struct
{
   short MatrixA;
   short MatrixB;
   short MatrixC;
   short MatrixD;
   short CentreX;
   short CentreY;
} SLineMatrixData;

extern uint32_t odd_high [4][16];
extern uint32_t odd_low [4][16];
extern uint32_t even_high [4][16];
extern uint32_t even_low [4][16];
extern SBG BG;
extern uint32 DirectColourMaps [8][256];

//extern uint8 add32_32 [32][32];
//extern uint8 add32_32_half [32][32];
//extern uint8 sub32_32 [32][32];
//extern uint8 sub32_32_half [32][32];
extern uint8 mul_brightness [16][32];

// Could use BSWAP instruction on Intel port...
//#define SWAP_DWORD(dw) dw = ((dw & 0xff) << 24) | ((dw & 0xff00) << 8) | \
//                ((dw & 0xff0000) >> 8) | ((dw & 0xff000000) >> 24)
// by Harald Kipp, from http://www.ethernut.de/en/documents/arm-inline-asm.html
#ifdef ARM_ASM
#define SWAP_DWORD(val) \
    __asm__ __volatile__ ( \
        "eor     r3, %1, %1, ror #16\n\t" \
        "bic     r3, r3, #0x00FF0000\n\t" \
        "mov     %0, %1, ror #8\n\t" \
        "eor     %0, %0, r3, lsr #8" \
        : "=r" (val) \
        : "0"(val) \
        : "r3", "cc" \
    );
#else
#define SWAP_DWORD(dword) ((((unsigned int)(dword) & 0x000000ff) << 24) \
                         | (((unsigned int)(dword) & 0x0000ff00) <<  8) \
                         | (((unsigned int)(dword) & 0x00ff0000) >>  8) \
                         | (((unsigned int)(dword) & 0xff000000) >> 24))
#endif

#ifdef FAST_LSB_WORD_ACCESS
#define READ_2BYTES(s) (*(uint16 *) (s))
#define WRITE_2BYTES(s, d) *(uint16 *) (s) = (d)
#else

#ifdef MSB_FIRST
#define READ_2BYTES(s) (*(uint8 *) (s) | (*((uint8 *) (s) + 1) << 8))
#define WRITE_2BYTES(s, d) *(uint8 *) (s) = (d), \
            *((uint8 *) (s) + 1) = (d) >> 8
#else
#define READ_2BYTES(s) (*(uint16 *) (s))
#define WRITE_2BYTES(s, d) *(uint16 *) (s) = (d)
#endif

#endif // i386

#define SUB_SCREEN_DEPTH 0
#define MAIN_SCREEN_DEPTH 32

#if defined(USE_OLD_COLOUR_OPS)
/* Pre-1.60 colour operations */
#if defined(OLD_COLOUR_BLENDING)
#define COLOR_ADD(C1, C2) \
GFX.X2 [((((C1) & RGB_REMOVE_LOW_BITS_MASK) + \
     ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1) + \
   ((C1) & (C2) & RGB_LOW_BITS_MASK)]
#else
#define COLOR_ADD(C1, C2) \
(GFX.X2 [((((C1) & RGB_REMOVE_LOW_BITS_MASK) + \
     ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1) + \
    ((C1) & (C2) & RGB_LOW_BITS_MASK)] | \
 (((C1) ^ (C2)) & RGB_LOW_BITS_MASK))
#endif
#else
static INLINE uint16_t COLOR_ADD(uint16_t C1, uint16_t C2)
{
	const int RED_MASK   = 0x1F << RED_SHIFT_BITS;
	const int GREEN_MASK = 0x1F << GREEN_SHIFT_BITS;
	const int BLUE_MASK  = 0x1F << BLUE_SHIFT_BITS;

	int rb          = (C1 & (RED_MASK | BLUE_MASK)) + (C2 & (RED_MASK | BLUE_MASK));
	int rbcarry     = rb & ((0x20 << RED_SHIFT_BITS) | (0x20 << 0));
	int g           = (C1 & (GREEN_MASK)) + (C2 & (GREEN_MASK));
	int rgbsaturate = (((g & (0x20 << GREEN_SHIFT_BITS)) | rbcarry) >> 5) * 0x1f;
	uint16_t retval = (rb & (RED_MASK | BLUE_MASK)) | (g & GREEN_MASK) | rgbsaturate;

#if GREEN_SHIFT_BITS == 6
	retval         |= (retval & 0x0400) >> 5;
#endif

	return retval;
}
#endif

#define COLOR_ADD1_2(C1, C2) \
(((((C1) & RGB_REMOVE_LOW_BITS_MASK) + \
          ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1) + \
         ((C1) & (C2) & RGB_LOW_BITS_MASK) | ALPHA_BITS_MASK)

#if defined(USE_OLD_COLOUR_OPS)
/* Pre-1.60 colour operations */
#if defined(OLD_COLOUR_BLENDING)
#define COLOR_SUB(C1, C2) \
GFX.ZERO_OR_X2 [(((C1) | RGB_HI_BITS_MASKx2) - \
       ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1]
#else
#define COLOR_SUB(C1, C2) \
(GFX.ZERO_OR_X2 [(((C1) | RGB_HI_BITS_MASKx2) - \
                  ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1] + \
((C1) & RGB_LOW_BITS_MASK) - ((C2) & RGB_LOW_BITS_MASK))
#endif
#else
static INLINE uint16_t COLOR_SUB(uint16_t C1, uint16_t C2)
{
	int rb1         = (C1 & (THIRD_COLOR_MASK | FIRST_COLOR_MASK)) | ((0x20 << 0) | (0x20 << RED_SHIFT_BITS));
	int rb2         = C2 & (THIRD_COLOR_MASK | FIRST_COLOR_MASK);
	int rb          = rb1 - rb2;
	int rbcarry     = rb & ((0x20 << RED_SHIFT_BITS) | (0x20 << 0));
	int g           = ((C1 & (SECOND_COLOR_MASK)) | (0x20 << GREEN_SHIFT_BITS)) - (C2 & (SECOND_COLOR_MASK));
	int rgbsaturate = (((g & (0x20 << GREEN_SHIFT_BITS)) | rbcarry) >> 5) * 0x1f;
	uint16_t retval = ((rb & (THIRD_COLOR_MASK | FIRST_COLOR_MASK)) | (g & SECOND_COLOR_MASK)) & rgbsaturate;

#if GREEN_SHIFT_BITS == 6
	retval         |= (retval & 0x0400) >> 5;
#endif

	return retval;
}
#endif

#define COLOR_SUB1_2(C1, C2) \
GFX.ZERO [(((C1) | RGB_HI_BITS_MASKx2) - \
      ((C2) & RGB_REMOVE_LOW_BITS_MASK)) >> 1]

typedef void (*NormalTileRenderer)(uint32 Tile, int32 Offset,
                                   uint32 StartLine, uint32 LineCount);
typedef void (*ClippedTileRenderer)(uint32 Tile, int32 Offset,
                                    uint32 StartPixel, uint32 Width,
                                    uint32 StartLine, uint32 LineCount);
typedef void (*LargePixelRenderer)(uint32 Tile, int32 Offset,
                                   uint32 StartPixel, uint32 Pixels,
                                   uint32 StartLine, uint32 LineCount);


typedef struct
{
   NormalTileRenderer Normal;
   ClippedTileRenderer Clipped;
   LargePixelRenderer Large;
} TileRendererSet;

void S9xStartScreenRefresh();
void S9xDrawScanLine(uint8 Line);
void S9xEndScreenRefresh();
void S9xSetupOBJ();
void S9xUpdateScreen();
//extern void (*S9xUpdateScreen)();
//void SelectUpdateScreen();
void RenderLine(uint8 line);
void S9xBuildDirectColourMaps();

// External port interface which must be implemented or initialised for each
// port.
extern SGFX GFX;

bool8_32 S9xGraphicsInit();
void S9xGraphicsDeinit();
bool8_32 S9xDeinitUpdate(int Width, int Height);
void S9xSetPalette();
void S9xSyncSpeed();

#ifdef GFX_MULTI_FORMAT
bool8_32 S9xSetRenderPixelFormat(int format);
#endif

#endif
