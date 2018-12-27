/*******************************************************************************
  Snes9x - Portable Super Nintendo Entertainment System (TM) emulator.

  (c) Copyright 1996 - 2003 Gary Henderson (gary.henderson@ntlworld.com) and
                            Jerremy Koot (jkoot@snes9x.com)

  (c) Copyright 2002 - 2003 Matthew Kendora and
                            Brad Jorsch (anomie@users.sourceforge.net)



  C4 x86 assembler and some C emulation code
  (c) Copyright 2000 - 2003 zsKnight (zsknight@zsnes.com),
                            _Demo_ (_demo_@zsnes.com), and
                            Nach (n-a-c-h@users.sourceforge.net)

  C4 C++ code
  (c) Copyright 2003 Brad Jorsch

  DSP-1 emulator code
  (c) Copyright 1998 - 2003 Ivar (ivar@snes9x.com), _Demo_, Gary Henderson,
                            John Weidman (jweidman@slip.net),
                            neviksti (neviksti@hotmail.com), and
                            Kris Bleakley (stinkfish@bigpond.com)

  DSP-2 emulator code
  (c) Copyright 2003 Kris Bleakley, John Weidman, neviksti, Matthew Kendora, and
                     Lord Nightmare (lord_nightmare@users.sourceforge.net

  OBC1 emulator code
  (c) Copyright 2001 - 2003 zsKnight, pagefault (pagefault@zsnes.com)
  Ported from x86 assembler to C by sanmaiwashi

  SPC7110 and RTC C++ emulator code
  (c) Copyright 2002 Matthew Kendora with research by
                     zsKnight, John Weidman, and Dark Force

  S-RTC C emulator code
  (c) Copyright 2001 John Weidman

  Super FX x86 assembler emulator code
  (c) Copyright 1998 - 2003 zsKnight, _Demo_, and pagefault

  Super FX C emulator code
  (c) Copyright 1997 - 1999 Ivar and Gary Henderson.

  (c) Copyright 2014 - 2016 Daniel De Matteis. (UNDER NO CIRCUMSTANCE 
  WILL COMMERCIAL RIGHTS EVER BE APPROPRIATED TO ANY PARTY)

  Specific ports contains the works of other authors. See headers in
  individual files.

  Snes9x homepage: http://www.snes9x.com

  Permission to use, copy, modify and distribute Snes9x in both binary and
  source form, for non-commercial purposes, is hereby granted without fee,
  providing that this license information and copyright notice appear with
  all copies and any derived work.

  This software is provided 'as-is', without any express or implied
  warranty. In no event shall the authors be held liable for any damages
  arising from the use of this software.

  Snes9x is freeware for PERSONAL USE only. Commercial users should
  seek permission of the copyright holders first. Commercial use includes
  charging money for Snes9x or software derived from Snes9x.

  The copyright holders request that bug fixes and improvements to the code
  should be forwarded to them so everyone can benefit from the modifications
  in future versions.

  Super NES and Super Nintendo Entertainment System are trademarks of
  Nintendo Co., Limited and its subsidiary companies.
*******************************************************************************/

#ifndef __GP32__
#include <stdlib.h>
#endif

#include <math.h>
#include "c4.h"
//#include "memmap.h"

short C4WFXVal;
short C4WFYVal;
short C4WFZVal;
short C4WFX2Val;
short C4WFY2Val;
short C4WFDist;
short C4WFScale;

static long tanval;
static long c4x, c4y, c4z;
static long c4x2, c4y2, c4z2;

const short C4_MulTable[256] =
{
   0x0000,  0x0003,  0x0006,  0x0009,  0x000c,  0x000f,  0x0012,  0x0015,
   0x0019,  0x001c,  0x001f,  0x0022,  0x0025,  0x0028,  0x002b,  0x002f,
   0x0032,  0x0035,  0x0038,  0x003b,  0x003e,  0x0041,  0x0045,  0x0048,
   0x004b,  0x004e,  0x0051,  0x0054,  0x0057,  0x005b,  0x005e,  0x0061,
   0x0064,  0x0067,  0x006a,  0x006d,  0x0071,  0x0074,  0x0077,  0x007a,
   0x007d,  0x0080,  0x0083,  0x0087,  0x008a,  0x008d,  0x0090,  0x0093,
   0x0096,  0x0099,  0x009d,  0x00a0,  0x00a3,  0x00a6,  0x00a9,  0x00ac,
   0x00af,  0x00b3,  0x00b6,  0x00b9,  0x00bc,  0x00bf,  0x00c2,  0x00c5,
   0x00c9,  0x00cc,  0x00cf,  0x00d2,  0x00d5,  0x00d8,  0x00db,  0x00df,
   0x00e2,  0x00e5,  0x00e8,  0x00eb,  0x00ee,  0x00f1,  0x00f5,  0x00f8,
   0x00fb,  0x00fe,  0x0101,  0x0104,  0x0107,  0x010b,  0x010e,  0x0111,
   0x0114,  0x0117,  0x011a,  0x011d,  0x0121,  0x0124,  0x0127,  0x012a,
   0x012d,  0x0130,  0x0133,  0x0137,  0x013a,  0x013d,  0x0140,  0x0143,
   0x0146,  0x0149,  0x014d,  0x0150,  0x0153,  0x0156,  0x0159,  0x015c,
   0x015f,  0x0163,  0x0166,  0x0169,  0x016c,  0x016f,  0x0172,  0x0175,
   0x0178,  0x017c,  0x017f,  0x0182,  0x0185,  0x0188,  0x018b,  0x018e,
   0x0192,  0x0195,  0x0198,  0x019b,  0x019e,  0x01a1,  0x01a4,  0x01a8,
   0x01ab,  0x01ae,  0x01b1,  0x01b4,  0x01b7,  0x01ba,  0x01be,  0x01c1,
   0x01c4,  0x01c7,  0x01ca,  0x01cd,  0x01d0,  0x01d4,  0x01d7,  0x01da,
   0x01dd,  0x01e0,  0x01e3,  0x01e6,  0x01ea,  0x01ed,  0x01f0,  0x01f3,
   0x01f6,  0x01f9,  0x01fc,  0x0200,  0x0203,  0x0206,  0x0209,  0x020c,
   0x020f,  0x0212,  0x0216,  0x0219,  0x021c,  0x021f,  0x0222,  0x0225,
   0x0228,  0x022c,  0x022f,  0x0232,  0x0235,  0x0238,  0x023b,  0x023e,
   0x0242,  0x0245,  0x0248,  0x024b,  0x024e,  0x0251,  0x0254,  0x0258,
   0x025b,  0x025e,  0x0261,  0x0264,  0x0267,  0x026a,  0x026e,  0x0271,
   0x0274,  0x0277,  0x027a,  0x027d,  0x0280,  0x0284,  0x0287,  0x028a,
   0x028d,  0x0290,  0x0293,  0x0296,  0x029a,  0x029d,  0x02a0,  0x02a3,
   0x02a6,  0x02a9,  0x02ac,  0x02b0,  0x02b3,  0x02b6,  0x02b9,  0x02bc,
   0x02bf,  0x02c2,  0x02c6,  0x02c9,  0x02cc,  0x02cf,  0x02d2,  0x02d5,
   0x02d8,  0x02db,  0x02df,  0x02e2,  0x02e5,  0x02e8,  0x02eb,  0x02ee,
   0x02f1,  0x02f5,  0x02f8,  0x02fb,  0x02fe,  0x0301,  0x0304,  0x0307,
   0x030b,  0x030e,  0x0311,  0x0314,  0x0317,  0x031a,  0x031d,  0x0321
};

const short C4_SinTable[256] =
{
   0x0000,  0x0324,  0x0647,  0x096a,  0x0c8b,  0x0fab,  0x12c8,  0x15e2,
   0x18f8,  0x1c0b,  0x1f19,  0x2223,  0x2528,  0x2826,  0x2b1f,  0x2e11,
   0x30fb,  0x33de,  0x36ba,  0x398c,  0x3c56,  0x3f17,  0x41ce,  0x447a,
   0x471c,  0x49b4,  0x4c3f,  0x4ebf,  0x5133,  0x539b,  0x55f5,  0x5842,
   0x5a82,  0x5cb4,  0x5ed7,  0x60ec,  0x62f2,  0x64e8,  0x66cf,  0x68a6,
   0x6a6d,  0x6c24,  0x6dca,  0x6f5f,  0x70e2,  0x7255,  0x73b5,  0x7504,
   0x7641,  0x776c,  0x7884,  0x798a,  0x7a7d,  0x7b5d,  0x7c29,  0x7ce3,
   0x7d8a,  0x7e1d,  0x7e9d,  0x7f09,  0x7f62,  0x7fa7,  0x7fd8,  0x7ff6,
   0x7fff,  0x7ff6,  0x7fd8,  0x7fa7,  0x7f62,  0x7f09,  0x7e9d,  0x7e1d,
   0x7d8a,  0x7ce3,  0x7c29,  0x7b5d,  0x7a7d,  0x798a,  0x7884,  0x776c,
   0x7641,  0x7504,  0x73b5,  0x7255,  0x70e2,  0x6f5f,  0x6dca,  0x6c24,
   0x6a6d,  0x68a6,  0x66cf,  0x64e8,  0x62f2,  0x60ec,  0x5ed7,  0x5cb4,
   0x5a82,  0x5842,  0x55f5,  0x539b,  0x5133,  0x4ebf,  0x4c3f,  0x49b4,
   0x471c,  0x447a,  0x41ce,  0x3f17,  0x3c56,  0x398c,  0x36ba,  0x33de,
   0x30fb,  0x2e11,  0x2b1f,  0x2826,  0x2528,  0x2223,  0x1f19,  0x1c0b,
   0x18f8,  0x15e2,  0x12c8,  0x0fab,  0x0c8b,  0x096a,  0x0647,  0x0324,
   -0x0000, -0x0324, -0x0647, -0x096a, -0x0c8b, -0x0fab, -0x12c8, -0x15e2,
   -0x18f8, -0x1c0b, -0x1f19, -0x2223, -0x2528, -0x2826, -0x2b1f, -0x2e11,
   -0x30fb, -0x33de, -0x36ba, -0x398c, -0x3c56, -0x3f17, -0x41ce, -0x447a,
   -0x471c, -0x49b4, -0x4c3f, -0x4ebf, -0x5133, -0x539b, -0x55f5, -0x5842,
   -0x5a82, -0x5cb4, -0x5ed7, -0x60ec, -0x62f2, -0x64e8, -0x66cf, -0x68a6,
   -0x6a6d, -0x6c24, -0x6dca, -0x6f5f, -0x70e2, -0x7255, -0x73b5, -0x7504,
   -0x7641, -0x776c, -0x7884, -0x798a, -0x7a7d, -0x7b5d, -0x7c29, -0x7ce3,
   -0x7d8a, -0x7e1d, -0x7e9d, -0x7f09, -0x7f62, -0x7fa7, -0x7fd8, -0x7ff6,
   -0x7fff, -0x7ff6, -0x7fd8, -0x7fa7, -0x7f62, -0x7f09, -0x7e9d, -0x7e1d,
   -0x7d8a, -0x7ce3, -0x7c29, -0x7b5d, -0x7a7d, -0x798a, -0x7884, -0x776c,
   -0x7641, -0x7504, -0x73b5, -0x7255, -0x70e2, -0x6f5f, -0x6dca, -0x6c24,
   -0x6a6d, -0x68a6, -0x66cf, -0x64e8, -0x62f2, -0x60ec, -0x5ed7, -0x5cb4,
   -0x5a82, -0x5842, -0x55f5, -0x539b, -0x5133, -0x4ebf, -0x4c3f, -0x49b4,
   -0x471c, -0x447a, -0x41ce, -0x3f17, -0x3c56, -0x398c, -0x36ba, -0x33de,
   -0x30fb, -0x2e11, -0x2b1f, -0x2826, -0x2528, -0x2223, -0x1f19, -0x1c0b,
   -0x18f8, -0x15e2, -0x12c8, -0x0fab, -0x0c8b, -0x096a, -0x0647, -0x0324
};

short C4_Sin(short Angle)
{
   int S;
   if (Angle < 0)
   {
      if (Angle == -32768) return 0;
      return -C4_Sin(-Angle);
   }
   S = C4_SinTable[Angle >> 8] + (C4_MulTable[Angle & 0xff] * C4_SinTable[0x40 + (Angle >> 8)] >> 15);
   if (S > 32767) S = 32767;
   return (short) S;
}

short C4_Cos(short Angle)
{
   int S;
   if (Angle < 0)
   {
      if (Angle == -32768) return -32768;
      Angle = -Angle;
   }
   S = C4_SinTable[0x40 + (Angle >> 8)] - (C4_MulTable[Angle & 0xff] * C4_SinTable[Angle >> 8] >> 15);
   if (S < -32768) S = -32767;
   return (short) S;
}
const short atantbl[] = { 0, 1, 1, 2, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9, 10, 10, 11, 11, 12, 13, 13, 14, 15, 15, 16, 16, 17, 18, 18, 19, 20, 20, 21, 21, 22, 23, 23, 24, 25, 25, 26, 26, 27, 28, 28, 29, 29, 30, 31, 31, 32, 33, 33, 34, 34, 35, 36, 36, 37, 37, 38, 39, 39, 40, 40, 41, 42, 42, 43, 43, 44, 44, 45, 46, 46, 47, 47, 48, 49, 49, 50, 50, 51, 51, 52, 53, 53, 54, 54, 55, 55, 56, 57, 57, 58, 58, 59, 59, 60, 60, 61, 62, 62, 63, 63, 64, 64, 65, 65, 66, 66, 67, 67, 68, 69, 69, 70, 70, 71, 71, 72, 72, 73, 73, 74, 74, 75, 75, 76, 76, 77, 77, 78, 78, 79, 79, 80, 80, 81, 81, 82, 82, 83, 83, 84, 84, 85, 85, 86, 86, 86, 87, 87, 88, 88, 89, 89, 90, 90, 91, 91, 92, 92, 92, 93, 93, 94, 94, 95, 95, 96, 96, 96, 97, 97, 98, 98, 99, 99, 99, 100, 100, 101, 101, 101, 102, 102, 103, 103, 104, 104, 104, 105, 105, 106, 106, 106, 107, 107, 108, 108, 108, 109, 109, 109, 110, 110, 111, 111, 111, 112, 112, 113, 113, 113, 114, 114, 114, 115, 115, 115, 116, 116, 117, 117, 117, 118, 118, 118, 119, 119, 119, 120, 120, 120, 121, 121, 121, 122, 122, 122, 123, 123, 123, 124, 124, 124, 125, 125, 125, 126, 126, 126, 127, 127 };

short _abs(short val)
{
   return ((val >= 0) ? val : -val);
}

short _atan2(short x, short y)
{
   int x1, y1;
   x1 = _abs(x);
   y1 = _abs(y);

   if (x == 0) return 0;

   if (((x >= 0) && (y >= 0)) || ((x < 0) && (y < 0)))
   {
      if (x1 > y1)
         return atantbl[(unsigned char)((y1 << 8) / x1)];
      else
         return atantbl[(unsigned char)((x1 << 8) / y1)];
   }
   else
   {
      if (x1 > y1)
         return -atantbl[(unsigned char)((y1 << 8) / x1)];
      else
         return -atantbl[(unsigned char)((x1 << 8) / y1)];
   }
}

/*long _isqrt(long x)
{
   long s, t;

   if (x <= 0) return 0;

   s = 1;  t = x;
   while (s < t) {  s <<= 1;  t >>= 1;  }
   do {
      t = s;
      s = (x / s + s) >> 1;
   } while (s < t);

   return t;
}
*/

static unsigned int _isqrt(unsigned long val)
{
   unsigned int temp, g = 0;

   if (val >= 0x40000000)
   {
      g = 0x8000;
      val -= 0x40000000;
   }

#define INNER_ISQRT(s)                        \
   temp = (g << (s)) + (1 << ((s) * 2 - 2));   \
   if (val >= temp) {                          \
     g += 1 << ((s)-1);                        \
     val -= temp;                              \
   }

   INNER_ISQRT(15)
   INNER_ISQRT(14)
   INNER_ISQRT(13)
   INNER_ISQRT(12)
   INNER_ISQRT(11)
   INNER_ISQRT(10)
   INNER_ISQRT(9)
   INNER_ISQRT(8)
   INNER_ISQRT(7)
   INNER_ISQRT(6)
   INNER_ISQRT(5)
   INNER_ISQRT(4)
   INNER_ISQRT(3)
   INNER_ISQRT(2)

#undef INNER_ISQRT

   temp = g + g + 1;
   if (val >= temp) g++;
   return g;
}

void C4TransfWireFrame()
{
   c4x = C4WFXVal;
   c4y = C4WFYVal;
   c4z = C4WFZVal - 0x95;

   // Rotate X
   tanval = -C4WFX2Val << 9;
   c4y2 = (c4y * C4_Cos(tanval) - c4z * C4_Sin(tanval)) >> 15;
   c4z2 = (c4y * C4_Sin(tanval) + c4z * C4_Cos(tanval)) >> 15;

   // Rotate Y
   tanval = -C4WFY2Val << 9;
   c4x2 = (c4x * C4_Cos(tanval) + c4z2 * C4_Sin(tanval)) >> 15;
   c4z = (c4x * -C4_Sin(tanval) + c4z2 * C4_Cos(tanval)) >> 15;

   // Rotate Z
   tanval = -C4WFDist << 9;
   c4x = (c4x2 * C4_Cos(tanval) - c4y2 * C4_Sin(tanval)) >> 15;
   c4y = (c4x2 * C4_Sin(tanval) + c4y2 * C4_Cos(tanval)) >> 15;

   // Scale
   C4WFXVal = (short)(((long)c4x * C4WFScale * 0x95) / (0x90 * (c4z + 0x95)));
   C4WFYVal = (short)(((long)c4y * C4WFScale * 0x95) / (0x90 * (c4z + 0x95)));

}

void C4TransfWireFrame2()
{
   c4x = C4WFXVal;
   c4y = C4WFYVal;
   c4z = C4WFZVal;

   // Rotate X
   tanval = -C4WFX2Val << 9;
   c4y2 = (c4y * C4_Cos(tanval) - c4z * C4_Sin(tanval)) >> 15;
   c4z2 = (c4y * C4_Sin(tanval) + c4z * C4_Cos(tanval)) >> 15;

   // Rotate Y
   tanval = -C4WFY2Val << 9;
   c4x2 = (c4x * C4_Cos(tanval) + c4z2 * C4_Sin(tanval)) >> 15;
   c4z = (c4x * -C4_Sin(tanval) + c4z2 * C4_Cos(tanval)) >> 15;

   // Rotate Z
   tanval = -C4WFDist << 9;
   c4x = (c4x2 * C4_Cos(tanval) - c4y2 * C4_Sin(tanval)) >> 15;
   c4y = (c4x2 * C4_Sin(tanval) + c4y2 * C4_Cos(tanval)) >> 15;

   // Scale
   C4WFXVal = (short)(((long)c4x * C4WFScale) / 0x100);
   C4WFYVal = (short)(((long)c4y * C4WFScale) / 0x100);

}

void C4CalcWireFrame()
{
   C4WFXVal = C4WFX2Val - C4WFXVal;
   C4WFYVal = C4WFY2Val - C4WFYVal;
   if (_abs(C4WFXVal) > _abs(C4WFYVal))
   {
      C4WFDist = _abs(C4WFXVal) + 1;
      C4WFYVal = (short)(((long)C4WFYVal << 8) / _abs(C4WFXVal));
      if (C4WFXVal < 0)
         C4WFXVal = -256;
      else
         C4WFXVal = 256;
   }
   else
   {
      if (C4WFYVal != 0)
      {
         C4WFDist = _abs(C4WFYVal) + 1;
         C4WFXVal = (short)(((long)C4WFXVal << 8) / _abs(C4WFYVal));
         if (C4WFYVal < 0)
            C4WFYVal = -256;
         else
            C4WFYVal = 256;
      }
      else
         C4WFDist = 0;
   }
}

short C41FXVal;
short C41FYVal;
short C41FAngleRes;
short C41FDist;
short C41FDistVal;

void C4Op1F()
{
   if (C41FXVal == 0)
   {
      if (C41FYVal > 0)
         C41FAngleRes = 0x80;
      else
         C41FAngleRes = 0x180;
   }
   else
   {
      C41FAngleRes = (short)(_atan2(C41FYVal, C41FXVal) / 2);
      C41FAngleRes = C41FAngleRes;
      if (C41FXVal < 0)
         C41FAngleRes += 0x100;
      C41FAngleRes &= 0x1FF;
   }
   /*
       if (C41FXVal == 0)
       {
           if (C41FYVal > 0)
               C41FAngleRes = 0x80;
           else
               C41FAngleRes = 0x180;
       }
       else
       {
           tanval = (double) C41FYVal / C41FXVal;
           C41FAngleRes = (short) (atan (tanval) / (3.141592675 * 2) * 512);
           C41FAngleRes = C41FAngleRes;
           if (C41FXVal< 0)
               C41FAngleRes += 0x100;
           C41FAngleRes &= 0x1FF;
       }
   */
}

void C4Op15()
{
   tanval = (short)_isqrt((long) C41FYVal * C41FYVal + (long) C41FXVal * C41FXVal);
   C41FDist = tanval;
   /*
       tanval = sqrt ((double) C41FYVal * C41FYVal + (double) C41FXVal * C41FXVal);
       C41FDist = (short) tanval;
   */
}

void C4Op0D()
{
   tanval = (short)_isqrt((long) C41FYVal * C41FYVal + (long) C41FXVal * C41FXVal);
   tanval = C41FDistVal / tanval;
   C41FYVal = (short)(((long)C41FYVal * tanval * 99) / 100);
   C41FXVal = (short)(((long)C41FXVal * tanval * 98) / 100);
   /*
       tanval = sqrt ((double) C41FYVal * C41FYVal + (double) C41FXVal * C41FXVal);
       tanval = C41FDistVal / tanval;
       C41FYVal = (short) (C41FYVal * tanval * 0.99);
       C41FXVal = (short) (C41FXVal * tanval * 0.98);
   */
}
