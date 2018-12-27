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
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "snes9x.h"
#include "cheats.h"
#include "memmap.h"

static bool8 S9xAllHex(const char* code, int len)
{
   int i;
   for (i = 0; i < len; i++)
      if ((code [i] < '0' || code [i] > '9') &&
            (code [i] < 'a' || code [i] > 'f') &&
            (code [i] < 'A' || code [i] > 'F'))
         return (FALSE);

   return (TRUE);
}

const char* S9xProActionReplayToRaw(const char* code, uint32* address, uint8* byte)
{
   uint32 data = 0;
   if (strlen(code) != 8 || !S9xAllHex(code, 8) ||
         sscanf(code, "%x", &data) != 1)
      return ("Invalid Pro Action Replay code - should be 8 hex digits in length.");

   *address = data >> 8;
   *byte = (uint8) data;
   return (NULL);
}

const char* S9xGoldFingerToRaw(const char* code, uint32* address, bool8* sram,
                               uint8* num_bytes, uint8 bytes[3])
{
   char tmp [15];
   int i;
   if (strlen(code) != 14)
      return ("Invalid Gold Finger code should be 14 hex digits in length.");

   strncpy(tmp, code, 5);
   tmp [5] = 0;

   if (sscanf(tmp, "%x", address) != 1)
      return ("Invalid Gold Finger code.");

   for (i = 0; i < 3; i++)
   {
      int byte;
      strncpy(tmp, code + 5 + i * 2, 2);
      tmp [2] = 0;
      if (sscanf(tmp, "%x", &byte) != 1)
         break;
      bytes [i] = (uint8) byte;
   }
   *num_bytes = i;
   *sram = code [13] == '1';
   return (NULL);
}

const char* S9xGameGenieToRaw(const char* code, uint32* address, uint8* byte)
{
   uint32 data = 0;
   char new_code [12];
   static char* real_hex  = "0123456789ABCDEF";
   static char* genie_hex = "DF4709156BC8A23E";
   int i;

   if (strlen(code) != 9 || *(code + 4) != '-' || !S9xAllHex(code, 4) ||
         !S9xAllHex(code + 5, 4))
      return ("Invalid Game Genie(tm) code - should be 'xxxx-xxxx'.");

   strcpy(new_code, "0x");
   strncpy(new_code + 2, code, 4);
   strcpy(new_code + 6, code + 5);

   for (i = 2; i < 10; i++)
   {
      int j;
      if (islower(new_code [i]))
         new_code [i] = toupper(new_code [i]);
      for (j = 0; j < 16; j++)
      {
         if (new_code [i] == genie_hex [j])
         {
            new_code [i] = real_hex [j];
            break;
         }
      }
      if (j == 16)
         return ("Invalid hex-character in Game Genie(tm) code");
   }
   sscanf(new_code, "%x", &data);
   *byte = (uint8)(data >> 24);
   *address = data & 0xffffff;
   *address = ((*address & 0x003c00) << 10) +
              ((*address & 0x00003c) << 14) +
              ((*address & 0xf00000) >>  8) +
              ((*address & 0x000003) << 10) +
              ((*address & 0x00c000) >>  6) +
              ((*address & 0x0f0000) >> 12) +
              ((*address & 0x0003c0) >>  6);

   return (NULL);
}
