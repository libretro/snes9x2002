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

extern SCheatData Cheat;

void S9xInitCheatData()
{
   Cheat.RAM = Memory.RAM;
   Cheat.SRAM = SRAM;
   Cheat.FillRAM = Memory.FillRAM;
}

void S9xAddCheat(bool8 enable, bool8 save_current_value,
                 uint32 address, uint8 byte)
{
   if (Cheat.num_cheats < sizeof(Cheat.c) / sizeof(Cheat. c [0]))
   {
      Cheat.c [Cheat.num_cheats].address = address;
      Cheat.c [Cheat.num_cheats].byte = byte;
      Cheat.c [Cheat.num_cheats].enabled = TRUE;
      if (save_current_value)
      {
         Cheat.c [Cheat.num_cheats].saved_byte = S9xGetByte(address);
         Cheat.c [Cheat.num_cheats].saved = TRUE;
      }
      Cheat.num_cheats++;
   }
}

void S9xDeleteCheat(uint32 which1)
{
   if (which1 < Cheat.num_cheats)
   {
      if (Cheat.c [which1].enabled)
         S9xRemoveCheat(which1);

      memmove(&Cheat.c [which1], &Cheat.c [which1 + 1],
              sizeof(Cheat.c [0]) * (Cheat.num_cheats - which1 - 1));
      Cheat.num_cheats = 0;
   }
}

void S9xDeleteCheats()
{
   S9xRemoveCheats();
   Cheat.num_cheats = 0;
}

void S9xEnableCheat(uint32 which1)
{
   if (which1 < Cheat.num_cheats && !Cheat.c [which1].enabled)
   {
      Cheat.c [which1].enabled = TRUE;
      S9xApplyCheat(which1);
   }
}

void S9xDisableCheat(uint32 which1)
{
   if (which1 < Cheat.num_cheats && Cheat.c [which1].enabled)
   {
      S9xRemoveCheat(which1);
      Cheat.c [which1].enabled = FALSE;
   }
}

void S9xRemoveCheat(uint32 which1)
{
   if (Cheat.c [which1].saved)
   {
      uint32 address = Cheat.c [which1].address;

      int block = (address >> MEMMAP_SHIFT) & MEMMAP_MASK;
      uint8* ptr = Memory.Map [block];

      if (ptr >= (uint8*) MAP_LAST)
         *(ptr + (address & 0xffff)) = Cheat.c [which1].saved_byte;
      else
         S9xSetByte(address, Cheat.c [which1].saved_byte);
   }
}

void S9xApplyCheat(uint32 which1)
{
   int block;
   uint8 *ptr;
   uint32 address = Cheat.c [which1].address;

   if (!Cheat.c [which1].saved)
      Cheat.c [which1].saved_byte = S9xGetByte(address);

   block = (address >> MEMMAP_SHIFT) & MEMMAP_MASK;
   ptr   = Memory.Map [block];

   if (ptr >= (uint8*) MAP_LAST)
      *(ptr + (address & 0xffff)) = Cheat.c [which1].byte;
   else
      S9xSetByte(address, Cheat.c [which1].byte);
   Cheat.c [which1].saved = TRUE;
}

void S9xApplyCheats()
{
   if (Settings.ApplyCheats)
   {
      uint32 i;
      for (i = 0; i < Cheat.num_cheats; i++)
         if (Cheat.c [i].enabled)
            S9xApplyCheat(i);
   }
}

void S9xRemoveCheats()
{
   uint32 i;
   for (i = 0; i < Cheat.num_cheats; i++)
      if (Cheat.c [i].enabled)
         S9xRemoveCheat(i);
}

bool8 S9xLoadCheatFile(const char* filename)
{
   Cheat.num_cheats = 0;

   return (TRUE);
}
