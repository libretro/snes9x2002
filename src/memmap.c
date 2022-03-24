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
#include <string.h>
#include <ctype.h>

#include "snes9x.h"
#include "memmap.h"
#include "cpuexec.h"
#include "ppu.h"
#include "display.h"
#include "cheats.h"
#include "apu.h"
#include "sa1.h"
#include "srtc.h"
#include "sdd1.h"

#include "fxemu.h"
extern FxInit_s SuperFX;

static uint8 bytes0x2000 [0x2000];

extern bool8  ROMAPUEnabled;

static bool8_32 AllASCII (uint8 *b, int size)
{
   int i;
   for (i = 0; i < size; i++)
   {
      if (b[i] < 32 || b[i] > 126)
         return (FALSE);
   }
   return (TRUE);
}

static int ScoreHiROM (bool8_32 skip_header)
{
    int score = 0;
    int o = skip_header ? 0xff00 + 0x200 : 0xff00;

    if ((Memory.ROM [o + 0xdc] + (Memory.ROM [o + 0xdd] << 8) +
	 Memory.ROM [o + 0xde] + (Memory.ROM [o + 0xdf] << 8)) == 0xffff)
	score += 2;

    if (Memory.ROM [o + 0xda] == 0x33)
	score += 2;
    if ((Memory.ROM [o + 0xd5] & 0xf) < 4)
	score += 2;
    if (!(Memory.ROM [o + 0xfd] & 0x80))
	score -= 4;
    if (Memory.CalculatedSize > 1024 * 1024 * 3)
	score += 4;
    if ((1 << (Memory.ROM [o + 0xd7] - 7)) > 48)
	score -= 1;
    if (!AllASCII (&Memory.ROM [o + 0xb0], 6))
	score -= 1;
    if (!AllASCII (&Memory.ROM [o + 0xc0], ROM_NAME_LEN - 1))
	score -= 1;

    return (score);
}

static int ScoreLoROM (bool8_32 skip_header)
{
    int score = 0;
    int o = skip_header ? 0x7f00 + 0x200 : 0x7f00;

    if ((Memory.ROM [o + 0xdc] + (Memory.ROM [o + 0xdd] << 8) +
	 Memory.ROM [o + 0xde] + (Memory.ROM [o + 0xdf] << 8)) == 0xffff)
	score += 2;

    if (Memory.ROM [o + 0xda] == 0x33)
	score += 2;
    if ((Memory.ROM [o + 0xd5] & 0xf) < 4)
	score += 2;
    if (Memory.CalculatedSize <= 1024 * 1024 * 16)
	score += 2;
    if (!(Memory.ROM [o + 0xfd] & 0x80))
	score -= 4;
    if ((1 << (Memory.ROM [o + 0xd7] - 7)) > 48)
	score -= 1;
    if (!AllASCII (&Memory.ROM [o + 0xb0], 6))
	score -= 1;
    if (!AllASCII (&Memory.ROM [o + 0xc0], ROM_NAME_LEN - 1))
	score -= 1;

    return (score);
}
	
static char *Safe (const char *s)
{
   int i, len;
   static char *safe = NULL;
   static int safe_len = 0;

   if (s == NULL)
   {
      if (safe)
      {
         free(safe);
         safe = NULL;
         safe_len = 0;
      }
      return NULL;
   }

   len = strlen (s);

   if (!safe || len + 1 > safe_len)
   {
      if (safe)
         free ((char *) safe);
      safe = (char *) malloc (safe_len = len + 1);
   }

   for (i = 0; i < len; i++)
   {
      if (s [i] >= 32 && s [i] < 127)
         safe [i] = s[i];
      else
         safe [i] = '?';
   }
   safe [len] = 0;
   return (safe);
}

/**********************************************************************************************/
/* Init()                                                                                     */
/* This function allocates all the memory needed by the emulator                              */
/**********************************************************************************************/
bool8_32 MemoryInit ()
{
    Memory.RAM	    = (uint8 *) malloc (0x20000);
    Memory.SRAM    = (uint8 *) malloc (0x20000);
    Memory.VRAM    = (uint8 *) malloc (0x10000);
    Memory.ROM     = (uint8 *) malloc (MAX_ROM_SIZE + 0x200 + 0x8000);
    Memory.FillRAM = NULL;

    IPPU.TileCache [TILE_2BIT] = (uint8 *) malloc (MAX_2BIT_TILES * 128);
    IPPU.TileCache [TILE_4BIT] = (uint8 *) malloc (MAX_4BIT_TILES * 128);
    IPPU.TileCache [TILE_8BIT] = (uint8 *) malloc (MAX_8BIT_TILES * 128);
    
    IPPU.TileCached [TILE_2BIT] = (uint8 *) malloc (MAX_2BIT_TILES);
    IPPU.TileCached [TILE_4BIT] = (uint8 *) malloc (MAX_4BIT_TILES);
    IPPU.TileCached [TILE_8BIT] = (uint8 *) malloc (MAX_8BIT_TILES);
    
    if (!Memory.RAM || !Memory.SRAM || !Memory.VRAM || !Memory.ROM ||
        !IPPU.TileCache [TILE_2BIT] || !IPPU.TileCache [TILE_4BIT] ||
	!IPPU.TileCache [TILE_8BIT] || !IPPU.TileCached [TILE_2BIT] ||
	!IPPU.TileCached [TILE_4BIT] ||	!IPPU.TileCached [TILE_8BIT])
    {
	MemoryDeinit ();
	return (FALSE);
    }
	
    // FillRAM uses first 32K of ROM image area, otherwise space just
    // wasted. Might be read by the SuperFX code.

    Memory.FillRAM = Memory.ROM;

    // Add 0x8000 to ROM image pointer to stop SuperFX code accessing
    // unallocated memory (can cause crash on some ports).
    Memory.ROM += 0x8000;

    Memory.C4RAM    = Memory.ROM + 0x400000 + 8192 * 8;
    ROM    = Memory.ROM;
    SRAM   = Memory.SRAM;
    RegRAM = Memory.FillRAM;

    SuperFX.pvRegisters = &Memory.FillRAM [0x3000];
    SuperFX.nRamBanks = 1;
    SuperFX.pvRam = SRAM;
    SuperFX.nRomBanks = (2 * 1024 * 1024) / (32 * 1024);
    SuperFX.pvRom = (uint8 *) Memory.ROM;

    memset (IPPU.TileCached [TILE_2BIT], 0, MAX_2BIT_TILES);
    memset (IPPU.TileCached [TILE_4BIT], 0, MAX_4BIT_TILES);
    memset (IPPU.TileCached [TILE_8BIT], 0, MAX_8BIT_TILES);
    
    Memory.SDD1Data = NULL;
    Memory.SDD1Index = NULL;

    return (TRUE);
}

void MemoryDeinit ()
{
    if (Memory.RAM)
    {
	free ((char *) Memory.RAM);
	Memory.RAM = NULL;
    }
    if (Memory.SRAM)
    {
	free ((char *) Memory.SRAM);
	Memory.SRAM = NULL;
    }
    if (Memory.VRAM)
    {
	free ((char *) Memory.VRAM);
	Memory.VRAM = NULL;
    }
    if (Memory.ROM)
    {
	Memory.ROM -= 0x8000;
	free ((char *) Memory.ROM);
	Memory.ROM = NULL;
    }

    if (IPPU.TileCache [TILE_2BIT])
    {
	free ((char *) IPPU.TileCache [TILE_2BIT]);
	IPPU.TileCache [TILE_2BIT] = NULL;
    }
    if (IPPU.TileCache [TILE_4BIT])
    {
	free ((char *) IPPU.TileCache [TILE_4BIT]);
	IPPU.TileCache [TILE_4BIT] = NULL;
    }
    if (IPPU.TileCache [TILE_8BIT])
    {
	free ((char *) IPPU.TileCache [TILE_8BIT]);
	IPPU.TileCache [TILE_8BIT] = NULL;
    }

    if (IPPU.TileCached [TILE_2BIT])
    {
	free ((char *) IPPU.TileCached [TILE_2BIT]);
	IPPU.TileCached [TILE_2BIT] = NULL;
    }
    if (IPPU.TileCached [TILE_4BIT])
    {
	free ((char *) IPPU.TileCached [TILE_4BIT]);
	IPPU.TileCached [TILE_4BIT] = NULL;
    }
    if (IPPU.TileCached [TILE_8BIT])
    {
	free ((char *) IPPU.TileCached [TILE_8BIT]);
	IPPU.TileCached [TILE_8BIT] = NULL;
    }

    FreeSDD1Data ();

    /* Ensure that we free the static char
     * array allocated by Safe() */
    Safe(NULL);
}

void FreeSDD1Data ()
{
    if (Memory.SDD1Index)
    {
	free ((char *) Memory.SDD1Index);
	Memory.SDD1Index = NULL;
    }
    if (Memory.SDD1Data)
    {
	free ((char *) Memory.SDD1Data);
	Memory.SDD1Data = NULL;
    }
}

/**********************************************************************************************/
/* LoadROM()                                                                                  */
/* This function loads a Snes-Backup image                                                    */
/**********************************************************************************************/
bool8_32 LoadROM (void)
{
   int hi_score, lo_score;
   int32 TotalFileSize = 0;
   unsigned long FileSize = 0;
   int retry_count = 0;
   STREAM ROMFile;
   bool8_32 Interleaved = FALSE; 
   bool8_32 Tales = FALSE;
   int i;

   memset (&SNESGameFixes, 0, sizeof(SNESGameFixes));
   SNESGameFixes.SRAMInitialValue = 0x60;

   memset (bytes0x2000, 0, 0x2000);
   CPU.TriedInterleavedMode2 = FALSE;

   Memory.CalculatedSize = 0;
again:
   {
      int calc_size;
      uint8 *ptr;

      if ((ROMFile = OPEN_STREAM ("rb")) == NULL)
         return (FALSE);

      Memory.HeaderCount = 0;
      ptr      = Memory.ROM;

      FileSize = READ_STREAM (ptr, MAX_ROM_SIZE + 0x200 - (ptr - Memory.ROM), ROMFile);
      CLOSE_STREAM (ROMFile);
      calc_size = (FileSize / 0x2000) * 0x2000;

      if ((FileSize - calc_size == 512 && !Settings.ForceNoHeader) ||
            Settings.ForceHeader)
      {
         memmove (ptr, ptr + 512, calc_size);
         Memory.HeaderCount++;
         FileSize -= 512;
      }
      ptr           += FileSize;
      TotalFileSize += FileSize;
   }

   hi_score = ScoreHiROM (FALSE);
   lo_score = ScoreLoROM (FALSE);

   if (Memory.HeaderCount == 0 && !Settings.ForceNoHeader &&
         ((hi_score > lo_score && ScoreHiROM (TRUE) > hi_score) ||
          (hi_score <= lo_score && ScoreLoROM (TRUE) > lo_score)))
   {
      memmove (Memory.ROM, Memory.ROM + 512, TotalFileSize - 512);
      TotalFileSize -= 512;
      S9xMessage (S9X_INFO, S9X_HEADER_WARNING, 
            "Try specifying the -nhd command line option if the game doesn't work\n");
   }

   Memory.CalculatedSize = (TotalFileSize / 0x2000) * 0x2000;
   memset (Memory.ROM + Memory.CalculatedSize, 0, MAX_ROM_SIZE - Memory.CalculatedSize);

   // Check for altered DAIKAIJYUMONOGATARI2

   if (Memory.CalculatedSize == 0x500000 &&
         strncmp ((const char *)&Memory.ROM [0x40ffc0], "DAIKAIJYUMONOGATARI2", 20) == 0 &&
         strncmp ((const char *)&Memory.ROM [0x40ffb0], "18AE6J", 6) == 0 &&
         memcmp (&Memory.ROM[0x40ffb0], &Memory.ROM [0xffb0], 0x30))
   {
      memmove (&Memory.ROM[0x100000], Memory.ROM, 0x500000);
      memmove (Memory.ROM, &Memory.ROM[0x500000], 0x100000);
   }

   Interleaved = Settings.ForceInterleaved || Settings.ForceInterleaved2;
   if (Settings.ForceLoROM || (!Settings.ForceHiROM && lo_score >= hi_score))
   {
      Memory.LoROM = TRUE;
      Memory.HiROM = FALSE;

      // Ignore map type byte if not 0x2x or 0x3x
      if ((Memory.ROM [0x7fd5] & 0xf0) == 0x20 || (Memory.ROM [0x7fd5] & 0xf0) == 0x30)
      {
         switch (Memory.ROM [0x7fd5] & 0xf)
         {
            case 1:
               if (strncmp ((char *) &Memory.ROM [0x7fc0], "TREASURE HUNTER G", 17) != 0)
                  Interleaved = TRUE;
               break;
            case 2:
#if 0
               if (!Settings.ForceLoROM &&
                     strncmp ((char *) &ROM [0x7fc0], "SUPER FORMATION SOCCE", 21) != 0 &&
                     strncmp ((char *) &ROM [0x7fc0], "Star Ocean", 10) != 0)
               {
                  LoROM = FALSE;
                  HiROM = TRUE;
               }
#endif
               break;
            case 5:
               Interleaved = TRUE;
               Tales = TRUE;
               break;
         }
      }
   }
   else
   {
      if ((Memory.ROM [0xffd5] & 0xf0) == 0x20 || (Memory.ROM [0xffd5] & 0xf0) == 0x30)
      {
         switch (Memory.ROM [0xffd5] & 0xf)
         {
            case 0:
            case 3:
               Interleaved = TRUE;
               break;
         }
      }
      Memory.LoROM = FALSE;
      Memory.HiROM = TRUE;
   }

   // More 
   if (!Settings.ForceHiROM && !Settings.ForceLoROM &&
         !Settings.ForceInterleaved && !Settings.ForceInterleaved2 &&
         !Settings.ForceNotInterleaved && !Settings.ForcePAL &&
         !Settings.ForceSuperFX && !Settings.ForceDSP1 &&
         !Settings.ForceSA1 && !Settings.ForceC4 &&
         !Settings.ForceSDD1)
   {
      if (strncmp ((char *) &Memory.ROM [0x7fc0], "YUYU NO QUIZ DE GO!GO!", 22) == 0)
      {
         Memory.LoROM = TRUE;
         Memory.HiROM = FALSE;
         Interleaved = FALSE;
      }
      else 
         if (strncmp ((char *) &Memory.ROM [0x7fc0], "SP MOMOTAROU DENTETSU2", 22) == 0)
         {
            Memory.LoROM = TRUE;
            Memory.HiROM = FALSE;
            Interleaved = FALSE;
         }
         else 
            if (Memory.CalculatedSize == 0x100000 &&
                  strncmp ((char *) &Memory.ROM [0xffc0], "WWF SUPER WRESTLEMANIA", 22) == 0)
            {
               int cvcount;

               memmove (&Memory.ROM[0x100000] , Memory.ROM, 0x100000);
               for (cvcount = 0; cvcount < 16; cvcount++)
               {
                  memmove (&Memory.ROM[0x8000 * cvcount], &Memory.ROM[0x10000 * cvcount + 0x100000 + 0x8000], 0x8000);
                  memmove (&Memory.ROM[0x8000 * cvcount + 0x80000], &Memory.ROM[0x10000 * cvcount + 0x100000], 0x8000);
               }
               Memory.LoROM = TRUE;
               Memory.HiROM = FALSE;
               memset (Memory.ROM + Memory.CalculatedSize, 0, MAX_ROM_SIZE - Memory.CalculatedSize);
            }
   }

   if (!Settings.ForceNotInterleaved && Interleaved)
   {
      uint8 *tmp;
      int nblocks;
      uint8 blocks [256];

      CPU.TriedInterleavedMode2 = TRUE;
      S9xMessage (S9X_INFO, S9X_ROM_INTERLEAVED_INFO,
            "ROM image is in interleaved format - converting...");

      nblocks = Memory.CalculatedSize >> 16;
#if 0
      int step = 64;

      while (nblocks <= step)
         step >>= 1;

      nblocks = step;
#endif

      if (Tales)
      {
         nblocks = 0x60;
         for (i = 0; i < 0x40; i += 2)
         {
            blocks [i + 0] = (i >> 1) + 0x20;
            blocks [i + 1] = (i >> 1) + 0x00;
         }
         for (i = 0; i < 0x80; i += 2)
         {
            blocks [i + 0x40] = (i >> 1) + 0x80;
            blocks [i + 0x41] = (i >> 1) + 0x40;
         }
         Memory.LoROM = FALSE;
         Memory.HiROM = TRUE;
      }
      else
         if (Settings.ForceInterleaved2)
         {
            for (i = 0; i < nblocks * 2; i++)
            {
               blocks [i] = (i & ~0x1e) | ((i & 2) << 2) | ((i & 4) << 2) |
                  ((i & 8) >> 2) | ((i & 16) >> 2);
            }
         }
         else
         {
            bool8_32 t = Memory.LoROM;

            Memory.LoROM = Memory.HiROM;
            Memory.HiROM = t;

            for (i = 0; i < nblocks; i++)
            {
               blocks [i * 2] = i + nblocks;
               blocks [i * 2 + 1] = i;
            }
         }

      tmp = (uint8 *) malloc (0x8000);
      if (tmp)
      {
         for (i = 0; i < nblocks * 2; i++)
         {
            int j;
            for (j = i; j < nblocks * 2; j++)
            {
               if (blocks [j] == i)
               {
                  uint8 b;

                  memmove (tmp, &Memory.ROM [blocks [j] * 0x8000], 0x8000);
                  memmove (&Memory.ROM [blocks [j] * 0x8000],
                        &Memory.ROM [blocks [i] * 0x8000], 0x8000);
                  memmove (&Memory.ROM [blocks [i] * 0x8000], tmp, 0x8000);
                  b          = blocks [j];
                  blocks [j] = blocks [i];
                  blocks [i] = b;
                  break;
               }
            }
         }
         free ((char *) tmp);
      }

      hi_score = ScoreHiROM (FALSE);
      lo_score = ScoreLoROM (FALSE);

      if ((Memory.HiROM &&
               (lo_score >= hi_score || hi_score < 0)) ||
            (Memory.LoROM &&
             (hi_score > lo_score || lo_score < 0)))
      {
         if (retry_count == 0)
         {
            S9xMessage (S9X_INFO, S9X_ROM_CONFUSING_FORMAT_INFO,
                  "ROM lied about its type! Trying again.");
            Settings.ForceNotInterleaved = TRUE;
            Settings.ForceInterleaved = FALSE;
            retry_count++;
            goto again;
         }
      }
   }
   FreeSDD1Data ();
   InitROM (Tales);

   S9xInitCheatData ();
   S9xApplyCheats ();

   S9xReset ();

   return (TRUE);
}

void S9xDeinterleaveMode2(void)
{
   int nblocks;
   int step = 64;
   uint8 blocks [256];
   int i;
   uint8 *tmp;

   S9xMessage (S9X_INFO, S9X_ROM_INTERLEAVED_INFO,
         "ROM image is in interleaved format - converting...");

   nblocks = Memory.CalculatedSize >> 15;

   while (nblocks <= step)
      step >>= 1;

   nblocks = step;

   for (i = 0; i < nblocks * 2; i++)
   {
      blocks [i] = (i & ~0x1e) | ((i & 2) << 2) | ((i & 4) << 2) |
         ((i & 8) >> 2) | ((i & 16) >> 2);
   }

   tmp = (uint8 *) malloc (0x8000);

   if (tmp)
   {
      for (i = 0; i < nblocks * 2; i++)
      {
         int j;
         for (j = i; j < nblocks * 2; j++)
         {
            if (blocks [j] == i)
            {
               uint8 b;

               memmove (tmp, &Memory.ROM [blocks [j] * 0x8000], 0x8000);
               memmove (&Memory.ROM [blocks [j] * 0x8000], 
                     &Memory.ROM [blocks [i] * 0x8000], 0x8000);
               memmove (&Memory.ROM [blocks [i] * 0x8000], tmp, 0x8000);
               b          = blocks [j];
               blocks [j] = blocks [i];
               blocks [i] = b;
               break;
            }
         }
      }
      free ((char *) tmp);
   }
   InitROM (FALSE);
   S9xReset ();
}

void InitROM (bool8_32 Interleaved)
{
   uint32 remainder;
   int size;
   int power2 = 0;
   uint32 sum1 = 0;
   uint32 sum2 = 0;

   int i;

   SuperFX.nRomBanks = Memory.CalculatedSize >> 15;
   Settings.MultiPlayer5Master = Settings.MultiPlayer5;
   Settings.MouseMaster = Settings.Mouse;
   Settings.SuperScopeMaster = Settings.SuperScope;
   Settings.DSP1Master = Settings.ForceDSP1;
   Settings.SuperFX = FALSE;
   Settings.SA1 = FALSE;
   Settings.C4 = FALSE;
   Settings.SDD1 = FALSE;
   Settings.SRTC = FALSE;

   memset (Memory.BlockIsRAM, 0, MEMMAP_NUM_BLOCKS);
   memset (Memory.BlockIsROM, 0, MEMMAP_NUM_BLOCKS);

   SRAM = Memory.SRAM;
   memset (Memory.ROMId, 0, 5);
   memset (Memory.CompanyId, 0, 3);

   if (Memory.HiROM)
   {
      Memory.SRAMSize = Memory.ROM [0xffd8];
      strncpy (Memory.ROMName, (char *) &Memory.ROM[0xffc0], ROM_NAME_LEN - 1);
      Memory.ROMSpeed = Memory.ROM [0xffd5];
      Memory.ROMType = Memory.ROM [0xffd6];
      Memory.ROMSize = Memory.ROM [0xffd7];
      Memory.ROMChecksum = Memory.ROM [0xffde] + (Memory.ROM [0xffdf] << 8);
      Memory.ROMComplementChecksum = Memory.ROM [0xffdc] + (Memory.ROM [0xffdd] << 8);

      memmove (Memory.ROMId, &Memory.ROM [0xffb2], 4);
      memmove (Memory.CompanyId, &Memory.ROM [0xffb0], 2);

      // Try to auto-detect the DSP1 chip
      if (!Settings.ForceNoDSP1 &&
            (Memory.ROMType & 0xf) >= 3 && (Memory.ROMType & 0xf0) == 0)
         Settings.DSP1Master = TRUE;

      Settings.SDD1 = Settings.ForceSDD1;
      if ((Memory.ROMType & 0xf0) == 0x40)
         Settings.SDD1 = !Settings.ForceNoSDD1;

      if (Settings.BS)
         BSHiROMMap ();
      else
         if ((Memory.ROMSpeed & ~0x10) == 0x25)
            TalesROMMap (Interleaved);
         else 
            if ((Memory.ROMSpeed & ~0x10) == 0x22 &&
                  strncmp (Memory.ROMName, "Super Street Fighter", 20) != 0)
            {
               AlphaROMMap ();
            }
            else
               HiROMMap ();
   }
   else
   {
      Memory.HiROM = FALSE;
      Memory.SRAMSize = Memory.ROM [0x7fd8];
      Memory.ROMSpeed = Memory.ROM [0x7fd5];
      Memory.ROMType = Memory.ROM [0x7fd6];
      Memory.ROMSize = Memory.ROM [0x7fd7];
      Memory.ROMChecksum = Memory.ROM [0x7fde] + (Memory.ROM [0x7fdf] << 8);
      Memory.ROMComplementChecksum = Memory.ROM [0x7fdc] + (Memory.ROM [0x7fdd] << 8);
      memmove (Memory.ROMId, &Memory.ROM [0x7fb2], 4);
      memmove (Memory.CompanyId, &Memory.ROM [0x7fb0], 2);

      strncpy (Memory.ROMName, (char *) &Memory.ROM[0x7fc0], ROM_NAME_LEN - 1);
      Settings.SuperFX = Settings.ForceSuperFX;

      if ((Memory.ROMType & 0xf0) == 0x10)
         Settings.SuperFX = !Settings.ForceNoSuperFX;

      // Try to auto-detect the DSP1 chip
      if (!Settings.ForceNoDSP1 &&
            (Memory.ROMType & 0xf) >= 3 && (Memory.ROMType & 0xf0) == 0)
         Settings.DSP1Master = TRUE;

      Settings.SDD1 = Settings.ForceSDD1;
      if ((Memory.ROMType & 0xf0) == 0x40)
         Settings.SDD1 = !Settings.ForceNoSDD1;

      if (Settings.SDD1)
         S9xLoadSDD1Data ();

      Settings.C4 = Settings.ForceC4;
      if ((Memory.ROMType & 0xf0) == 0xf0 &&
            (strncmp (Memory.ROMName, "MEGAMAN X", 9) == 0 ||
             strncmp (Memory.ROMName, "ROCKMAN X", 9) == 0))
      {
         Settings.C4 = !Settings.ForceNoC4;
      }

      if (Settings.SuperFX)
      {
         //SRAM = ROM + 1024 * 1024 * 4;
         SuperFXROMMap ();
         Settings.MultiPlayer5Master = FALSE;
         //Settings.MouseMaster = FALSE;
         //Settings.SuperScopeMaster = FALSE;
         Settings.DSP1Master = FALSE;
         Settings.SA1 = FALSE;
         Settings.C4 = FALSE;
         Settings.SDD1 = FALSE;
      }
      else
         if (Settings.ForceSA1 ||
               (!Settings.ForceNoSA1 && (Memory.ROMSpeed & ~0x10) == 0x23 &&
                (Memory.ROMType & 0xf) > 3 && (Memory.ROMType & 0xf0) == 0x30))
         {
            Settings.SA1 = TRUE;
            Settings.MultiPlayer5Master = FALSE;
            //Settings.MouseMaster = FALSE;
            //Settings.SuperScopeMaster = FALSE;
            Settings.DSP1Master = FALSE;
            Settings.C4 = FALSE;
            Settings.SDD1 = FALSE;
            SA1ROMMap ();
         }
         else
            if ((Memory.ROMSpeed & ~0x10) == 0x25)
               TalesROMMap (Interleaved);
            else
               if (strncmp ((char *) &Memory.ROM [0x7fc0], "SOUND NOVEL-TCOOL", 17) == 0 ||
                     strncmp ((char *) &Memory.ROM [0x7fc0], "DERBY STALLION 96", 17) == 0)
               {
                  LoROM24MBSMap ();
                  Settings.DSP1Master = FALSE;
               }
               else
                  if (strncmp ((char *) &Memory.ROM [0x7fc0], "THOROUGHBRED BREEDER3", 21) == 0 ||
                        strncmp ((char *) &Memory.ROM [0x7fc0], "RPG-TCOOL 2", 11) == 0)
                  {
                     SRAM512KLoROMMap ();
                     Settings.DSP1Master = FALSE;
                  }
                  else
                     if (strncmp ((char *) &Memory.ROM [0x7fc0], "DEZAEMON  ", 10) == 0)
                     {
                        Settings.DSP1Master = FALSE;
                        SRAM1024KLoROMMap ();
                     }
                     else
                        if (strncmp ((char *) &Memory.ROM [0x7fc0], "ADD-ON BASE CASSETE", 19) == 0)
                        {
                           Settings.MultiPlayer5Master = FALSE;
                           Settings.MouseMaster = FALSE;
                           Settings.SuperScopeMaster = FALSE;
                           Settings.DSP1Master = FALSE;
                           SufamiTurboLoROMMap(); 
                           Memory.SRAMSize = 3;
                        }
                        else
                           if ((Memory.ROMSpeed & ~0x10) == 0x22 &&
                                 strncmp (Memory.ROMName, "Super Street Fighter", 20) != 0)
                           {
                              AlphaROMMap ();
                           }
                           else
                              LoROMMap ();
   }

   size = Memory.CalculatedSize;

   while (size >>= 1)
      power2++;

   size      = 1 << power2;
   remainder = Memory.CalculatedSize - size;

   for (i = 0; i < size; i++)
      sum1 += Memory.ROM [i];

   for (i = 0; i < (int) remainder; i++)
      sum2 += Memory.ROM [size + i];

   if (remainder)
   {
      //for Tengai makyou
      if (Memory.CalculatedSize == 0x500000 && Memory.HiROM &&
            strncmp ((const char *)&Memory.ROM[0xffb0], "18AZ", 4) == 0 &&
            !memcmp(&Memory.ROM[0xffd5], "\x3a\xf9\x0d\x03\x00\x33\x00", 7))
         sum1 += sum2;
      else
         sum1 += sum2 * (size / remainder);
   }

   sum1 &= 0xffff;

   Memory.CalculatedChecksum = caCRC32(&Memory.ROM[0], Memory.CalculatedSize);
   if (Settings.ForceNTSC)
      Settings.PAL = FALSE;
   else
      if (Settings.ForcePAL)
         Settings.PAL = TRUE;
      else
         if (Memory.HiROM)
            // Country code
            Settings.PAL = Memory.ROM [0xffd9] >= 2;
         else
            Settings.PAL = Memory.ROM [0x7fd9] >= 2;

   if (Settings.PAL)
   {
      Settings.FrameTime = Settings.FrameTimePAL;
      Memory.ROMFramesPerSecond = 50;
   }
   else
   {
      Settings.FrameTime = Settings.FrameTimeNTSC;
      Memory.ROMFramesPerSecond = 60;
   }

   Memory.ROMName[ROM_NAME_LEN - 1] = 0;
   if (strlen (Memory.ROMName))
   {
      char *p = Memory.ROMName + strlen (Memory.ROMName) - 1;

      while (p > Memory.ROMName && *(p - 1) == ' ')
         p--;
      *p = 0;
   }

   if (Settings.SuperFX)
   {
      CPU.Memory_SRAMMask = 0xffff;
      Memory.SRAMSize = 16;
   }
   else
   {
      CPU.Memory_SRAMMask = Memory.SRAMSize ?
         ((1 << (Memory.SRAMSize + 3)) * 128) - 1 : 0;
   }

   IAPU.OneCycle = ONE_APU_CYCLE;
   Settings.Shutdown = Settings.ShutdownMaster;

   SetDSP = &DSP1SetByte;
   GetDSP = &DSP1GetByte;

   ApplyROMFixes ();
   sprintf (Memory.ROMName, "%s", Safe (Memory.ROMName));
   sprintf (Memory.ROMId, "%s", Safe (Memory.ROMId));
   sprintf (Memory.CompanyId, "%s", Safe (Memory.CompanyId));

   sprintf (String, "\"%s\" [%s] %s, %s, Type: %s, Mode: %s, TV: %s, S-RAM: %s, ROMId: %s Company: %2.2s",
         Memory.ROMName,
         (Memory.ROMChecksum + Memory.ROMComplementChecksum != 0xffff ||
          Memory.ROMChecksum != sum1) ? "bad checksum" : "checksum ok",
         MapType (),
         Size (),
         KartContents (),
         MapMode (),
         TVStandard (),
         StaticRAMSize (),
         Memory.ROMId,
         Memory.CompanyId);

   S9xMessage (S9X_INFO, S9X_ROM_INFO, String);
}

void FixROMSpeed ()
{
    int c;

    for (c = 0x800; c < 0x1000; c++)
    {
	if (Memory.BlockIsROM [c])
	    Memory.MemorySpeed [c] = (uint8) CPU.FastROMSpeed;
    }
}

void WriteProtectROM(void)
{
   int c;

   memmove ((void *) Memory.WriteMap, (void *) Memory.Map, sizeof (Memory.Map));
   for (c = 0; c < 0x1000; c++)
   {
      if (Memory.BlockIsROM [c])
         Memory.WriteMap [c] = (uint8 *) MAP_NONE;
   }
}

void MapRAM(void)
{
   int c;

   // Banks 7e->7f, RAM
   for (c = 0; c < 16; c++)
   {
      Memory.Map [c + 0x7e0] = Memory.RAM;
      Memory.Map [c + 0x7f0] = Memory.RAM + 0x10000;
      Memory.BlockIsRAM [c + 0x7e0] = TRUE;
      Memory.BlockIsRAM [c + 0x7f0] = TRUE;
      Memory.BlockIsROM [c + 0x7e0] = FALSE;
      Memory.BlockIsROM [c + 0x7f0] = FALSE;
   }

   // Banks 70->77, S-RAM
   for (c = 0; c < 0x80; c++)
   {
      Memory.Map [c + 0x700] = (uint8 *) MAP_LOROM_SRAM;
      Memory.BlockIsRAM [c + 0x700] = TRUE;
      Memory.BlockIsROM [c + 0x700] = FALSE;
   }
}

void MapExtraRAM(void)
{
   int c;

   // Banks 7e->7f, RAM
   for (c = 0; c < 16; c++)
   {
      Memory.Map [c + 0x7e0] = Memory.RAM;
      Memory.Map [c + 0x7f0] = Memory.RAM + 0x10000;
      Memory.BlockIsRAM [c + 0x7e0] = TRUE;
      Memory.BlockIsRAM [c + 0x7f0] = TRUE;
      Memory.BlockIsROM [c + 0x7e0] = FALSE;
      Memory.BlockIsROM [c + 0x7f0] = FALSE;
   }

   // Banks 70->73, S-RAM
   for (c = 0; c < 16; c++)
   {
      Memory.Map [c + 0x700] = SRAM;
      Memory.Map [c + 0x710] = SRAM + 0x8000;
      Memory.Map [c + 0x720] = SRAM + 0x10000;
      Memory.Map [c + 0x730] = SRAM + 0x18000;

      Memory.BlockIsRAM [c + 0x700] = TRUE;
      Memory.BlockIsROM [c + 0x700] = FALSE;
      Memory.BlockIsRAM [c + 0x710] = TRUE;
      Memory.BlockIsROM [c + 0x710] = FALSE;
      Memory.BlockIsRAM [c + 0x720] = TRUE;
      Memory.BlockIsROM [c + 0x720] = FALSE;
      Memory.BlockIsRAM [c + 0x730] = TRUE;
      Memory.BlockIsROM [c + 0x730] = FALSE;
   }
}

void LoROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	if (Settings.DSP1Master)
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_DSP;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_DSP;
	}
	else
	if (Settings.C4)
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_C4;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_C4;
	}
	else
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) bytes0x2000 - 0x6000;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) bytes0x2000 - 0x6000;
	}

	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [(c << 11) % Memory.CalculatedSize] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    if (Settings.DSP1Master)
    {
	// Banks 30->3f and b0->bf
	for (c = 0x300; c < 0x400; c += 16)
	{
	    for (i = c + 8; i < c + 16; i++)
	    {
		Memory.Map [i] = Memory.Map [i + 0x800] = (uint8 *) MAP_DSP;
		Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = FALSE;
	    }
	}
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 8; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) % Memory.CalculatedSize];

	for (i = c + 8; i < c + 16; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [((c << 11) + 0x200000) % Memory.CalculatedSize - 0x8000];

	for (i = c; i < c + 16; i++)	
	{
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    if (Settings.DSP1Master)
    {
	for (c = 0; c < 0x100; c++)
	{
	    Memory.Map [c + 0xe00] = (uint8 *) MAP_DSP;
	    Memory.MemorySpeed [c + 0xe00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [c + 0xe00] = FALSE;
	}
    }
    MapRAM ();
    WriteProtectROM ();
}

void HiROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	if (Settings.DSP1Master)
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_DSP;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_DSP;
	}
	else
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;
	}
	    
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 30->3f and b0->bf, address ranges 6000->7fff is S-RAM.
    for (c = 0; c < 16; c++)
    {
	Memory.Map [0x306 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0x307 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0xb06 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0xb07 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.BlockIsRAM [0x306 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0x307 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0xb06 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0xb07 + (c << 4)] = TRUE;
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 16; i++)
	{
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    MapRAM ();
    WriteProtectROM ();
}

void TalesROMMap (bool8_32 Interleaved)
{
    int c;
    int i;

    uint32 OFFSET0 = 0x400000;
    uint32 OFFSET1 = 0x400000;
    uint32 OFFSET2 = 0x000000;

    if (Interleaved)
    {
	OFFSET0 = 0x000000;
	OFFSET1 = 0x000000;
	OFFSET2 = 0x200000;
    }

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = &Memory.ROM [((c << 12) + OFFSET0) % Memory.CalculatedSize];
	    Memory.Map [i + 0x800] = &Memory.ROM [((c << 12) + OFFSET0) % Memory.CalculatedSize];
	    Memory.BlockIsROM [i] = TRUE;
	    Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }
    
    // Banks 30->3f and b0->bf, address ranges 6000->7ffff is S-RAM.
    for (c = 0; c < 16; c++)
    {
	Memory.Map [0x306 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0x307 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0xb06 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.Map [0xb07 + (c << 4)] = (uint8 *) MAP_HIROM_SRAM;
	Memory.BlockIsRAM [0x306 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0x307 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0xb06 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0xb07 + (c << 4)] = TRUE;
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 8; i++)
	{
	    Memory.Map [i + 0x400] = &Memory.ROM [((c << 12) + OFFSET1) % Memory.CalculatedSize];
	    Memory.Map [i + 0x408] = &Memory.ROM [((c << 12) + OFFSET1) % Memory.CalculatedSize];
	    Memory.Map [i + 0xc00] = &Memory.ROM [((c << 12) + OFFSET2) % Memory.CalculatedSize];
	    Memory.Map [i + 0xc08] = &Memory.ROM [((c << 12) + OFFSET2) % Memory.CalculatedSize];
	    Memory.BlockIsROM [i + 0x400] = TRUE;
	    Memory.BlockIsROM [i + 0x408] = TRUE;
	    Memory.BlockIsROM [i + 0xc00] = TRUE;
	    Memory.BlockIsROM [i + 0xc08] = TRUE;
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.MemorySpeed [i + 0x408] = Memory.MemorySpeed [i + 0xc08] = SLOW_ONE_CYCLE;
	}
    }
    MapRAM ();
    WriteProtectROM ();
}

void AlphaROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_DSP;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_DSP;

	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 40->7f and c0->ff

    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 16; i++)
	{
	    Memory.Map [i + 0x400] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.Map [i + 0xc00] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    MapRAM ();
    WriteProtectROM ();
}

void SuperFXROMMap ()
{
    int c;
    int i;
    
    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_DSP;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_DSP;
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 8; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }
    
    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 16; i++)
	{
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    // Banks 7e->7f, RAM
    for (c = 0; c < 16; c++)
    {
	Memory.Map [c + 0x7e0] = Memory.RAM;
	Memory.Map [c + 0x7f0] = Memory.RAM + 0x10000;
	Memory.BlockIsRAM [c + 0x7e0] = TRUE;
	Memory.BlockIsRAM [c + 0x7f0] = TRUE;
	Memory.BlockIsROM [c + 0x7e0] = FALSE;
	Memory.BlockIsROM [c + 0x7f0] = FALSE;
    }

    // Banks 70->71, S-RAM
    for (c = 0; c < 32; c++)
    {
	Memory.Map [c + 0x700] = SRAM + (((c >> 4) & 1) << 16);
	Memory.BlockIsRAM [c + 0x700] = TRUE;
	Memory.BlockIsROM [c + 0x700] = FALSE;
    }

    // Banks 00->3f and 80->bf address ranges 6000->7fff is RAM.
    for (c = 0; c < 0x40; c++)
    {
	Memory.Map [0x006 + (c << 4)] = (uint8 *) SRAM - 0x6000;
	Memory.Map [0x007 + (c << 4)] = (uint8 *) SRAM - 0x6000;
	Memory.Map [0x806 + (c << 4)] = (uint8 *) SRAM - 0x6000;
	Memory.Map [0x807 + (c << 4)] = (uint8 *) SRAM - 0x6000;
	Memory.BlockIsRAM [0x006 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0x007 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0x806 + (c << 4)] = TRUE;
	Memory.BlockIsRAM [0x807 + (c << 4)] = TRUE;
    }
    // Replicate the first 2Mb of the ROM at ROM + 2MB such that each 32K
    // block is repeated twice in each 64K block.
    for (c = 0; c < 64; c++)
    {
	memmove (&Memory.ROM [0x200000 + c * 0x10000], &Memory.ROM [c * 0x8000], 0x8000);
	memmove (&Memory.ROM [0x208000 + c * 0x10000], &Memory.ROM [c * 0x8000], 0x8000);
    }

    WriteProtectROM ();
}

void SA1ROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) &Memory.FillRAM [0x3000] - 0x3000;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_BWRAM;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_BWRAM;
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 40->7f
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 16; i++)
	    Memory.Map [i + 0x400] = (uint8 *) &Memory.SRAM [(c << 12) & 0x1ffff];

	for (i = c; i < c + 16; i++)
	{
	    Memory.MemorySpeed [i + 0x400] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = FALSE;
	}
    }

    // c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c;  i < c + 16; i++)
	{
	    Memory.Map [i + 0xc00] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    for (c = 0; c < 16; c++)
    {
	Memory.Map [c + 0x7e0] = Memory.RAM;
	Memory.Map [c + 0x7f0] = Memory.RAM + 0x10000;
	Memory.BlockIsRAM [c + 0x7e0] = TRUE;
	Memory.BlockIsRAM [c + 0x7f0] = TRUE;
	Memory.BlockIsROM [c + 0x7e0] = FALSE;
	Memory.BlockIsROM [c + 0x7f0] = FALSE;
    }
    WriteProtectROM ();

#ifdef USE_SA1
    // Now copy the map and correct it for the SA1 CPU.
    memmove ((void *) SA1_WriteMap, (void *) Memory.WriteMap, sizeof (Memory.WriteMap));
    memmove ((void *) SA1_Map, (void *) Memory.Map, sizeof (Memory.Map));

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	SA1_Map [c + 0] = SA1_Map [c + 0x800] = &Memory.FillRAM [0x3000];
	SA1_Map [c + 1] = SA1_Map [c + 0x801] = (uint8 *) MAP_NONE;
	SA1_WriteMap [c + 0] = SA1_WriteMap [c + 0x800] = &Memory.FillRAM [0x3000];
	SA1_WriteMap [c + 1] = SA1_WriteMap [c + 0x801] = (uint8 *) MAP_NONE;
    }

    // Banks 60->6f
    for (c = 0; c < 0x100; c++)
	SA1_Map [c + 0x600] = SA1_WriteMap [c + 0x600] = (uint8 *) MAP_BWRAM_BITMAP;
#endif // USE_SA1    

    Memory.BWRAM = Memory.SRAM;
}

void LoROM24MBSMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
        Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
        Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;

	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x200; c += 16)
    {
	Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
        Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;

	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000 + 0x200000;
	    Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 8; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000];

	for (i = c + 8; i < c + 16; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000 - 0x8000];

	for (i = c; i < c + 16; i++)
	{
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    MapExtraRAM ();
    WriteProtectROM ();
}

void SufamiTurboLoROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	if (Settings.DSP1Master)
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_DSP;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_DSP;
	}
	else
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;
	}
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    if (Settings.DSP1Master)
    {
	// Banks 30->3f and b0->bf
	for (c = 0x300; c < 0x400; c += 16)
	{
	    for (i = c + 8; i < c + 16; i++)
	    {
		Memory.Map [i] = Memory.Map [i + 0x800] = (uint8 *) MAP_DSP;
		Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = FALSE;
	    }
	}
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 8; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000];

	for (i = c + 8; i < c + 16; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000 - 0x8000];

	for (i = c; i < c + 16; i++)
	{
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    if (Settings.DSP1Master)
    {
	for (c = 0; c < 0x100; c++)
	{
	    Memory.Map [c + 0xe00] = (uint8 *) MAP_DSP;
	    Memory.MemorySpeed [c + 0xe00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [c + 0xe00] = FALSE;
	}
    }

    // Banks 7e->7f, RAM
    for (c = 0; c < 16; c++)
    {
	Memory.Map [c + 0x7e0] = Memory.RAM;
	Memory.Map [c + 0x7f0] = Memory.RAM + 0x10000;
	Memory.BlockIsRAM [c + 0x7e0] = TRUE;
	Memory.BlockIsRAM [c + 0x7f0] = TRUE;
	Memory.BlockIsROM [c + 0x7e0] = FALSE;
	Memory.BlockIsROM [c + 0x7f0] = FALSE;
    }

    // Banks 60->67, S-RAM
    for (c = 0; c < 0x80; c++)
    {
	Memory.Map [c + 0x600] = (uint8 *) MAP_LOROM_SRAM;
	Memory.BlockIsRAM [c + 0x600] = TRUE;
	Memory.BlockIsROM [c + 0x600] = FALSE;
    }

    WriteProtectROM ();
}

void SRAM512KLoROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;

	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 8; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000];

	for (i = c + 8; i < c + 16; i++)
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 11) + 0x200000 - 0x8000];

	for (i = c; i < c + 16; i++)
	{
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;


	}
    }

    MapExtraRAM ();
    WriteProtectROM ();
}

void SRAM1024KLoROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.Map [c + 0x400] = Memory.Map [c + 0xc00] = Memory.RAM;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.Map [c + 0x401] = Memory.Map [c + 0xc01] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = Memory.BlockIsRAM [c + 0x400] = Memory.BlockIsRAM [c + 0xc00] = TRUE;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = Memory.BlockIsRAM [c + 0x401] = Memory.BlockIsRAM [c + 0xc01] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = Memory.Map [c + 0x402] = Memory.Map [c + 0xc02] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = Memory.Map [c + 0x403] = Memory.Map [c + 0xc03] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = Memory.Map [c + 0x404] = Memory.Map [c + 0xc04] = (uint8 *) MAP_CPU;
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = Memory.Map [c + 0x405] = Memory.Map [c + 0xc05] = (uint8 *) MAP_CPU;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = Memory.Map [c + 0x406] = Memory.Map [c + 0xc06] = (uint8 *) MAP_NONE;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = Memory.Map [c + 0x407] = Memory.Map [c + 0xc07] = (uint8 *) MAP_NONE;
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [c << 11] - 0x8000;
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] = Memory.MemorySpeed [i + 0x800] =
		Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    MapExtraRAM ();
    WriteProtectROM ();
}

void BSHiROMMap ()
{
    int c;
    int i;

    // Banks 00->3f and 80->bf
    for (c = 0; c < 0x400; c += 16)
    {
	Memory.Map [c + 0] = Memory.Map [c + 0x800] = Memory.RAM;
	Memory.BlockIsRAM [c + 0] = Memory.BlockIsRAM [c + 0x800] = TRUE;
	Memory.Map [c + 1] = Memory.Map [c + 0x801] = Memory.RAM;
	Memory.BlockIsRAM [c + 1] = Memory.BlockIsRAM [c + 0x801] = TRUE;

	Memory.Map [c + 2] = Memory.Map [c + 0x802] = (uint8 *) MAP_PPU;
	Memory.Map [c + 3] = Memory.Map [c + 0x803] = (uint8 *) MAP_PPU;
	Memory.Map [c + 4] = Memory.Map [c + 0x804] = (uint8 *) MAP_CPU;
	// XXX: How large is SRAM??
	Memory.Map [c + 5] = Memory.Map [c + 0x805] = (uint8 *) Memory.SRAM;
	Memory.BlockIsRAM [c + 5] = Memory.BlockIsRAM [c + 0x805] = TRUE;
	Memory.Map [c + 6] = Memory.Map [c + 0x806] = (uint8 *) MAP_NONE;
	Memory.Map [c + 7] = Memory.Map [c + 0x807] = (uint8 *) MAP_NONE;
	    
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = Memory.Map [i + 0x800] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.BlockIsROM [i] = Memory.BlockIsROM [i + 0x800] = TRUE;
	}

	for (i = c; i < c + 16; i++)
	{
	    int ppu = i & 15;
	    
	    Memory.MemorySpeed [i] =
		Memory.MemorySpeed [i + 0x800] = ppu >= 2 && ppu <= 3 ? ONE_CYCLE : SLOW_ONE_CYCLE;
	}
    }

    // Banks 60->7d offset 0000->7fff & 60->7f offset 8000->ffff PSRAM
    // XXX: How large is PSRAM?
    for (c = 0x600; c < 0x7e0; c += 16)
    {
	for (i = c; i < c + 8; i++)
	{
	    Memory.Map [i] = &Memory.ROM [0x400000 + (c << 11)];
	    Memory.BlockIsRAM [i] = TRUE;
	}
	for (i = c + 8; i < c + 16; i++)
	{
	    Memory.Map [i] = &Memory.ROM [0x400000 + (c << 11) - 0x8000];
	    Memory.BlockIsRAM [i] = TRUE;
	}
    }

    // Banks 40->7f and c0->ff
    for (c = 0; c < 0x400; c += 16)
    {
	for (i = c; i < c + 16; i++)
	{
	    Memory.Map [i + 0x400] = Memory.Map [i + 0xc00] = &Memory.ROM [(c << 12) % Memory.CalculatedSize];
	    Memory.MemorySpeed [i + 0x400] = Memory.MemorySpeed [i + 0xc00] = SLOW_ONE_CYCLE;
	    Memory.BlockIsROM [i + 0x400] = Memory.BlockIsROM [i + 0xc00] = TRUE;
	}
    }

    MapRAM ();
    WriteProtectROM ();
}

const char *TVStandard ()
{
    return (Settings.PAL ? "PAL" : "NTSC");
}

const char *Speed ()
{
    return (Memory.ROMSpeed & 0x10 ? "120ns" : "200ns");
}

const char *MapType ()
{
    return (Memory.HiROM ? "HiROM" : "LoROM");
}

const char *StaticRAMSize ()
{
    static char tmp [20];

    if (Memory.SRAMSize > 16)
	return ("Corrupt");
    sprintf (tmp, "%dKb", (CPU.Memory_SRAMMask + 1) / 1024);
    return (tmp);
}

const char *Size ()
{
    static char tmp [20];

    if (Memory.ROMSize < 7 || Memory.ROMSize - 7 > 23)
	return ("Corrupt");
    sprintf (tmp, "%dMbits", 1 << (Memory.ROMSize - 7));
    return (tmp);
}

const char *KartContents ()
{
    static char tmp [30];
    static const char *CoPro [16] = {
	"DSP1", "SuperFX", "OBC1", "SA-1", "S-DD1", "S-RTC", "CoPro#6",
	"CoPro#7", "CoPro#8", "CoPro#9", "CoPro#10", "CoPro#11", "CoPro#12",
	"CoPro#13", "CoPro#14", "CoPro-Custom"
    };
    static const char *Contents [3] = {
	"ROM", "ROM+RAM", "ROM+RAM+BAT"
    };
    if (Memory.ROMType == 0)
	return ("ROM only");

    sprintf (tmp, "%s", Contents [(Memory.ROMType & 0xf) % 3]);

    if ((Memory.ROMType & 0xf) >= 3)
	sprintf (tmp, "%s+%s", tmp, CoPro [(Memory.ROMType & 0xf0) >> 4]);

    return (tmp);
}

const char *MapMode ()
{
    static char tmp [4];
    sprintf (tmp, "%02x", Memory.ROMSpeed & ~0x10);
    return (tmp);
}

const char *ROMID ()
{
    return (Memory.ROMId);
}

void ApplyROMFixes ()
{
	ROMAPUEnabled = 0;
	DSP1.version = 0;
	//Settings.HBlankStart = (256 * Settings.H_Max) / SNES_HCOUNTER_MAX;
	if (strncmp(Memory.ROMName, "DUNGEON MASTER", 14) == 0)
	{
		DSP1.version = 1;
		SetDSP=&DSP2SetByte;
		GetDSP=&DSP2GetByte;
	}

	//OAM hacks because we don't fully understand the
	//behavior of the SNES.

	//possibly an RTO issue?
	//part of Fred's club is drawn over his face.
	if(strncmp(Memory.ROMName, "THE FLINTSTONES TTOSM", 21)==0)
	{
		SNESGameFixes.Flintstones=true;
	}

	if(strncmp(Memory.ROMName, "SUPER MARIO KART", 16)==0
		|| strncmp(Memory.ROMName, "F-ZERO", 6)==0)
	{
		SNESGameFixes.Mode7Hack=true;
	}

	//Totally wacky display...
	//seems to need a disproven behavior, so
	//we're definitely overlooking some other bug?
	if(strncmp(Memory.ROMName, "UNIRACERS", 9)==0)
		SNESGameFixes.Uniracers=true;

    // Enable S-RTC (Real Time Clock) emulation for Dai Kaijyu Monogatari 2
    Settings.SRTC = ((Memory.ROMType & 0xf0) >> 4) == 5;

    Settings.StrikeGunnerOffsetHack = strcmp (Memory.ROMName, "STRIKE GUNNER") == 0 ? 7 : 0;

    CPU.NMITriggerPoint = 4;
    if (strcmp (Memory.ROMName, "CACOMA KNIGHT") == 0)
	CPU.NMITriggerPoint = 25;

    // These games complain if the multi-player adaptor is 'connected'
    if (strcmp (Memory.ROMName, "TETRIS&Dr.MARIO") == 0 ||
        strcmp (Memory.ROMName, "JIGSAW PARTY") == 0 ||
        strcmp (Memory.ROMName, "SUPER PICROSS") == 0 ||
        strcmp (Memory.ROMName, "KIRBY NO KIRA KIZZU") == 0 ||
        strcmp (Memory.ROMName, "BLOCK") == 0 ||
        strncmp (Memory.ROMName, "SUPER BOMBLISS", 14) == 0 ||
	strcmp (Memory.ROMId, "ABOJ") == 0)
    {
	Settings.MultiPlayer5Master = FALSE;
	Settings.MouseMaster = FALSE;
	Settings.SuperScopeMaster = FALSE;
    }

    // Games which spool sound samples between the SNES and sound CPU using
    // H-DMA as the sample is playing.
    if (strcmp (Memory.ROMName, "EARTHWORM JIM 2") == 0 ||
	strcmp (Memory.ROMName, "PRIMAL RAGE") == 0 ||
	strcmp (Memory.ROMName, "CLAY FIGHTER") == 0 ||
	strcmp (Memory.ROMName, "ClayFighter 2") == 0 ||
	strncasecmp (Memory.ROMName, "MADDEN", 6) == 0 ||
	strncmp (Memory.ROMName, "NHL", 3) == 0 ||
	strcmp (Memory.ROMName, "WEAPONLORD") == 0)
    {
	Settings.Shutdown = FALSE;
    }


    // Stunt Racer FX
    if (strcmp (Memory.ROMId, "CQ  ") == 0 ||
    // Illusion of Gaia
        strncmp (Memory.ROMId, "JG", 2) == 0 ||
	strcmp (Memory.ROMName, "GAIA GENSOUKI 1 JPN") == 0)
    {
	IAPU.OneCycle = 13;
		ROMAPUEnabled  |= 2;
		CPU.APU_APUExecuting |= 2;
    }

    // RENDERING RANGER R2
    if (strcmp (Memory.ROMId, "AVCJ") == 0 ||
    // Star Ocean
	strncmp (Memory.ROMId, "ARF", 3) == 0 ||
    // Tales of Phantasia
	strncmp (Memory.ROMId, "ATV", 3) == 0 ||
    // Act Raiser 1 & 2
	strncasecmp (Memory.ROMName, "ACTRAISER", 9) == 0 ||
	strncasecmp (Memory.ROMName, "ActRaiser", 9) == 0 ||  // I kown both sentences are supposed to be equivalent each other but they aren't on my compiler
    // Soulblazer
	strcmp (Memory.ROMName, "SOULBLAZER - 1 USA") == 0 ||
	strcmp (Memory.ROMName, "SOULBLADER - 1") == 0 ||
	strncmp (Memory.ROMName, "SOULBLAZER 1",12) == 0 ||
    // Terranigma
	strncmp (Memory.ROMId, "AQT", 3) == 0 ||
    // Robotrek
	strncmp (Memory.ROMId, "E9 ", 3) == 0 ||
	strcmp (Memory.ROMName, "SLAP STICK 1 JPN") == 0 ||
    // ZENNIHON PURORESU2
	strncmp (Memory.ROMId, "APR", 3) == 0 ||
    // Bomberman 4
	strncmp (Memory.ROMId, "A4B", 3) == 0 ||
    // UFO KAMEN YAKISOBAN
	strncmp (Memory.ROMId, "Y7 ", 3) == 0 ||
	strncmp (Memory.ROMId, "Y9 ", 3) == 0 ||
    // Panic Bomber World
	strncmp (Memory.ROMId, "APB", 3) == 0 ||
	((strncmp (Memory.ROMName, "Parlor", 6) == 0 ||
          strcmp (Memory.ROMName, "HEIWA PARLOR!MINI8") == 0 ||
	  strncmp (Memory.ROMName, "SANKYO Fever! ﾌｨｰﾊﾞｰ!", 21) == 0) &&
	 strcmp (Memory.CompanyId, "A0") == 0) ||
	strcmp (Memory.ROMName, "DARK KINGDOM") == 0 ||
	strcmp (Memory.ROMName, "ZAN3 SFC") == 0 ||
	strcmp (Memory.ROMName, "HIOUDEN") == 0 ||
	strcmp (Memory.ROMName, "ﾃﾝｼﾉｳﾀ") == 0 ||
	strcmp (Memory.ROMName, "FORTUNE QUEST") == 0 ||
	strcmp (Memory.ROMName, "FISHING TO BASSING") == 0 ||
	strncmp (Memory.ROMName, "TOKYODOME '95BATTLE 7", 21) == 0 ||
	strcmp (Memory.ROMName, "OHMONO BLACKBASS") == 0)
    {
	IAPU.OneCycle = 15;
		// notaz: strangely enough, these games work properly with my hack enabled
		if (strcmp (Memory.ROMId, "AVCJ") != 0)
			ROMAPUEnabled |= 2;
		CPU.APU_APUExecuting |= 2;
    }
    
    if (strcmp (Memory.ROMName, "BATMAN--REVENGE JOKER") == 0)
    {
	Memory.HiROM = FALSE;
	Memory.LoROM = TRUE;
	LoROMMap ();
    }
    Settings.StarfoxHack = strcmp (Memory.ROMName, "STAR FOX") == 0 ||
			   strcmp (Memory.ROMName, "STAR WING") == 0;
    Settings.WinterGold = strcmp (Memory.ROMName, "FX SKIING NINTENDO 96") == 0 ||
                          strcmp (Memory.ROMName, "DIRT RACER") == 0 ||
			  strcmp (Memory.ROMName, "Stunt Race FX") == 0 ||
			  Settings.StarfoxHack;
    Settings.ChuckRock = strcmp (Memory.ROMName, "CHUCK ROCK") == 0;
    Settings.Dezaemon = strcmp (Memory.ROMName, "DEZAEMON") == 0;
    
    if (strcmp (Memory.ROMName, "RADICAL DREAMERS") == 0 ||
	strcmp (Memory.ROMName, "TREASURE CONFLIX") == 0)
    {
	int c;

	for (c = 0; c < 0x80; c++)
	{
	    Memory.Map [c + 0x700] = Memory.ROM + 0x200000 + 0x1000 * (c & 0xf0);
	    Memory.BlockIsRAM [c + 0x700] = TRUE;
	    Memory.BlockIsROM [c + 0x700] = FALSE;
	}
	for (c = 0; c < 0x400; c += 16)
	{
	    Memory.Map [c + 5] = Memory.Map [c + 0x805] = Memory.ROM + 0x300000;
	    Memory.BlockIsRAM [c + 5] = Memory.BlockIsRAM [c + 0x805] = TRUE;
	}
	WriteProtectROM ();
    }

    Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 
		      Settings.CyclesPercentage) / 100;

	// A Couple of HDMA related hacks - Lantus
	if ((strcmp(Memory.ROMName, "SFX SUPERBUTOUDEN2")==0) ||
	    (strcmp(Memory.ROMName, "ALIEN vs. PREDATOR")==0) ||
		(strcmp(Memory.ROMName, "STONE PROTECTORS")==0) ||
	    (strcmp(Memory.ROMName, "SUPER BATTLETANK 2")==0))
		Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 130) / 100;

    if (strcmp (Memory.ROMId, "ASRJ") == 0 && Settings.CyclesPercentage == 100)
	// Street Racer
	Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 95) / 100;

        // Power Rangers Fight
    if (strncmp (Memory.ROMId, "A3R", 3) == 0 ||
        // Clock Tower
	strncmp (Memory.ROMId, "AJE", 3) == 0)
		Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 103) / 100;
    
    if (strcmp (Memory.ROMId, "AWVP") == 0 || strcmp (Memory.ROMId, "AWVE") == 0 ||
	strcmp (Memory.ROMId, "AWVJ") == 0)
    {
	// Wrestlemania Arcade
#if 0
	if (Settings.CyclesPercentage == 100)
	    Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 140) / 100; // Fixes sound
#endif
	Settings.WrestlemaniaArcade = TRUE;
    }
    // Theme Park - disable offset-per-tile mode.
    if (strcmp (Memory.ROMId, "ATQP") == 0)
	Settings.WrestlemaniaArcade = TRUE;

    if (strncmp (Memory.ROMId, "A3M", 3) == 0 && Settings.CyclesPercentage == 100)
	// Mortal Kombat 3. Fixes cut off speech sample
	Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 110) / 100;

    if (strcmp (Memory.ROMName, "\x0bd\x0da\x0b2\x0d4\x0b0\x0bd\x0de") == 0 &&
	Settings.CyclesPercentage == 100)
		Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 101) / 100;

    if (strcmp (Memory.ROMName, "WILD TRAX") == 0 ||
	strcmp (Memory.ROMName, "YOSSY'S ISLAND") == 0 ||
	strcmp (Memory.ROMName, "YOSHI'S ISLAND") == 0)
	CPU.TriedInterleavedMode2 = TRUE;

    // Start Trek: Deep Sleep 9
    if (strncmp (Memory.ROMId, "A9D", 3) == 0 && Settings.CyclesPercentage == 100)
	Settings.H_Max = (SNES_CYCLES_PER_SCANLINE * 110) / 100;
    
    Settings.APURAMInitialValue = 0xff;

    if (strcmp (Memory.ROMName, "ｷｭｳﾔｸ･ﾒｶﾞﾐﾃﾝｾｲ") == 0 ||
    	strcmp (Memory.ROMName, "KENTOUOU WORLDCHAMPIO") == 0 ||
    	strcmp (Memory.ROMName, "TKO SUPERCHAMPIONSHIP") == 0 ||
    	strcmp (Memory.ROMName, "TKO SUPER CHAMPIONSHI") == 0 ||
    	strcmp (Memory.ROMName, "IHATOVO STORY") == 0 ||
    	strcmp (Memory.ROMName, "WANDERERS FROM YS") == 0 ||
    	strcmp (Memory.ROMName, "SUPER GENTYOUHISHI") == 0 ||
    // Panic Bomber World
	strncmp (Memory.ROMId, "APB", 3) == 0)
    {
        Settings.APURAMInitialValue = 0;
    }

    Settings.DaffyDuck = strcmp (Memory.ROMName, "DAFFY DUCK: MARV MISS") == 0;
    Settings.HBlankStart = (256 * Settings.H_Max) / SNES_HCOUNTER_MAX;

#ifdef USE_SA1
    SA1.WaitAddress = NULL;
    SA1.WaitByteAddress1 = NULL;
    SA1.WaitByteAddress2 = NULL;

    /* Bass Fishing */
    if (strcmp (Memory.ROMId, "ZBPJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0093f1 >> MEMMAP_SHIFT] + 0x93f1;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x304a;
    }
    /* DAISENRYAKU EXPERTWW2 */
    if (strcmp (Memory.ROMId, "AEVJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0ed18d >> MEMMAP_SHIFT] + 0xd18d;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3000;
    }
    /* debjk2 */
    if (strcmp (Memory.ROMId, "A2DJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x008b62 >> MEMMAP_SHIFT] + 0x8b62;
    }
    /* Dragon Ballz HD */
    if (strcmp (Memory.ROMId, "AZIJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x008083 >> MEMMAP_SHIFT] + 0x8083;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3020;
    }
    /* SFC SDGUNDAMGNEXT */
    if (strcmp (Memory.ROMId, "ZX3J") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0087f2 >> MEMMAP_SHIFT] + 0x87f2;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x30c4;
    }
    /* ShougiNoHanamichi */
    if (strcmp (Memory.ROMId, "AARJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc1f85a >> MEMMAP_SHIFT] + 0xf85a;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x0c64;
	SA1.WaitByteAddress2 = Memory.SRAM + 0x0c66;
    }
    /* KATO HIFUMI9DAN SYOGI */
    if (strcmp (Memory.ROMId, "A23J") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc25037 >> MEMMAP_SHIFT] + 0x5037;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x0c06;
	SA1.WaitByteAddress2 = Memory.SRAM + 0x0c08;
    }
    /* idaten */
    if (strcmp (Memory.ROMId, "AIIJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc100be >> MEMMAP_SHIFT] + 0x00be;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x1002;
	SA1.WaitByteAddress2 = Memory.SRAM + 0x1004;
    }
    /* igotais */
    if (strcmp (Memory.ROMId, "AITJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0080b7 >> MEMMAP_SHIFT] + 0x80b7;
    }
    /* J96 DREAM STADIUM */
    if (strcmp (Memory.ROMId, "AJ6J") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc0f74a >> MEMMAP_SHIFT] + 0xf74a;
    }
    /* JumpinDerby */
    if (strcmp (Memory.ROMId, "AJUJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00d926 >> MEMMAP_SHIFT] + 0xd926;
    }
    /* JKAKINOKI SHOUGI */
    if (strcmp (Memory.ROMId, "AKAJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00f070 >> MEMMAP_SHIFT] + 0xf070;
    }
    /* HOSHI NO KIRBY 3 & KIRBY'S DREAM LAND 3 JAP & US */
    if (strcmp (Memory.ROMId, "AFJJ") == 0 || strcmp (Memory.ROMId, "AFJE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0082d4 >> MEMMAP_SHIFT] + 0x82d4;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x72a4;
    }
    /* KIRBY SUPER DELUXE JAP */
    if (strcmp (Memory.ROMId, "AKFJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x008c93 >> MEMMAP_SHIFT] + 0x8c93;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x300a;
	SA1.WaitByteAddress2 = Memory.FillRAM + 0x300e;
    }
    /* KIRBY SUPER DELUXE US */
    if (strcmp (Memory.ROMId, "AKFE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x008cb8 >> MEMMAP_SHIFT] + 0x8cb8;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x300a;
	SA1.WaitByteAddress2 = Memory.FillRAM + 0x300e;
    }
    /* SUPER MARIO RPG JAP & US */
    if (strcmp (Memory.ROMId, "ARWJ") == 0 || strcmp (Memory.ROMId, "ARWE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc0816f >> MEMMAP_SHIFT] + 0x816f;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3000;
    }
    /* marvelous.zip */
    if (strcmp (Memory.ROMId, "AVRJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0085f2 >> MEMMAP_SHIFT] + 0x85f2;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3024;
    }
    /* AUGUSTA3 MASTERS NEW */
    if (strcmp (Memory.ROMId, "AO3J") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00dddb >> MEMMAP_SHIFT] + 0xdddb;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x37b4;
    }
    /* OSHABERI PARODIUS */
    if (strcmp (Memory.ROMId, "AJOJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x8084e5 >> MEMMAP_SHIFT] + 0x84e5;
    }
    /* PANIC BOMBER WORLD */
    if (strcmp (Memory.ROMId, "APBJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00857a >> MEMMAP_SHIFT] + 0x857a;
    }
    /* PEBBLE BEACH NEW */
    if (strcmp (Memory.ROMId, "AONJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00df33 >> MEMMAP_SHIFT] + 0xdf33;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x37b4;
    }
    /* PGA EUROPEAN TOUR */
    if (strcmp (Memory.ROMId, "AEPE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x003700 >> MEMMAP_SHIFT] + 0x3700;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3102;
    }
    /* PGA TOUR 96 */
    if (strcmp (Memory.ROMId, "A3GE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x003700 >> MEMMAP_SHIFT] + 0x3700;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3102;
    }
    /* POWER RANGERS 4 */
    if (strcmp (Memory.ROMId, "A4RE") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x009899 >> MEMMAP_SHIFT] + 0x9899;
	SA1.WaitByteAddress1 = Memory.FillRAM + 0x3000;
    }
    /* PACHISURO PALUSUPE */
    if (strcmp (Memory.ROMId, "AGFJ") == 0)
    {
	// Never seems to turn on the SA-1!
    }
    /* SD F1 GRAND PRIX */
    if (strcmp (Memory.ROMId, "AGFJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x0181bc >> MEMMAP_SHIFT] + 0x81bc;
    }
    /* SHOUGI MARJONG */
    if (strcmp (Memory.ROMId, "ASYJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00f2cc >> MEMMAP_SHIFT] + 0xf2cc;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x7ffe;
	SA1.WaitByteAddress2 = Memory.SRAM + 0x7ffc;
    }
    /* shogisai2 */
    if (strcmp (Memory.ROMId, "AX2J") == 0)
    {
	SA1.WaitAddress = SA1_Map [0x00d675 >> MEMMAP_SHIFT] + 0xd675;
    }

    /* SHINING SCORPION */
    if (strcmp (Memory.ROMId, "A4WJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc048be >> MEMMAP_SHIFT] + 0x48be;
    }
    /* SHIN SHOUGI CLUB */
    if (strcmp (Memory.ROMId, "AHJJ") == 0)
    {
	SA1.WaitAddress = SA1_Map [0xc1002a >> MEMMAP_SHIFT] + 0x002a;
	SA1.WaitByteAddress1 = Memory.SRAM + 0x0806;
	SA1.WaitByteAddress2 = Memory.SRAM + 0x0808;
    }
#endif // USE_SA1

    // Additional game fixes by sanmaiwashi ...
    if (strcmp (Memory.ROMName, "SFX ﾅｲﾄｶﾞﾝﾀﾞﾑﾓﾉｶﾞﾀﾘ 1") == 0)
    {
	bytes0x2000 [0xb18] = 0x4c;
	bytes0x2000 [0xb19] = 0x4b;
	bytes0x2000 [0xb1a] = 0xea;
    }

    if (strcmp (Memory.ROMName, "GOGO ACKMAN3") == 0 ||
	strcmp (Memory.ROMName, "HOME ALONE") == 0)
    {
	// Banks 00->3f and 80->bf
       int c;
	for (c = 0; c < 0x400; c += 16)
	{
	    Memory.Map [c + 6] = Memory.Map [c + 0x806] = Memory.SRAM;
	    Memory.Map [c + 7] = Memory.Map [c + 0x807] = Memory.SRAM;
	    Memory.BlockIsROM [c + 6] = Memory.BlockIsROM [c + 0x806] = FALSE;
	    Memory.BlockIsROM [c + 7] = Memory.BlockIsROM [c + 0x807] = FALSE;
	    Memory.BlockIsRAM [c + 6] = Memory.BlockIsRAM [c + 0x806] = TRUE;
	    Memory.BlockIsRAM [c + 7] = Memory.BlockIsRAM [c + 0x807] = TRUE;
	}
	WriteProtectROM ();
    }

    if (strncmp (Memory.ROMName, "SWORD WORLD SFC", 15) == 0 ||
        strcmp (Memory.ROMName, "SFC ｶﾒﾝﾗｲﾀﾞｰ") == 0)
    {
	IAPU.OneCycle = 15;
	SNESGameFixes.NeedInit0x2137 = TRUE;
	ROMAPUEnabled  |= 2;
	CPU.APU_APUExecuting |= 2;
    }

    if (strncmp (Memory.ROMName, "SHIEN THE BLADE CHASE", 21) == 0)
	SNESGameFixes.Old_Read0x4200 = TRUE;

    if (strcmp (Memory.ROMName, "ｺﾞｼﾞﾗ ｶｲｼﾞｭｳﾀﾞｲｹｯｾﾝ") == 0)
	SNESGameFixes.NeedInit0x2137 = TRUE;

    if (strcmp (Memory.ROMName, "UMIHARAKAWASE") == 0)
	SNESGameFixes.umiharakawaseFix = TRUE;

    if (strcmp (Memory.ROMName, "ALIENS vs. PREDATOR") == 0)
	SNESGameFixes.alienVSpredetorFix = TRUE;

    if (strcmp (Memory.ROMName, "demon's blazon") == 0 ||
	strcmp (Memory.ROMName, "demon's crest") == 0 ||
	strcmp (Memory.ROMName, "ROCKMAN X") == 0 ||
	strcmp (Memory.ROMName, "MEGAMAN X") == 0)
    {

	// CAPCOM's protect
	// Banks 0x808000, 0x408000 are mirroring.
       int c;
	for (c = 0; c < 8; c++)
	    Memory.Map [0x408 + c] = Memory.ROM - 0x8000;
    }

    if (strcmp (Memory.ROMName, "ｽｰﾊﾟｰﾌｧﾐｽﾀ") == 0 ||
	strcmp (Memory.ROMName, "ｽｰﾊﾟｰﾌｧﾐｽﾀ 2") == 0 ||
	strcmp (Memory.ROMName, "ZENKI TENCHIMEIDOU") == 0 ||
	strcmp (Memory.ROMName, "GANBA LEAGUE") == 0)
    {
	SNESGameFixes.APU_OutPorts_ReturnValueFix = TRUE;
    }

    // HITOMI3
    if (strcmp (Memory.ROMName, "HITOMI3") == 0)
    {
	Memory.SRAMSize = 1;
	CPU.Memory_SRAMMask = Memory.SRAMSize ?
			((1 << (Memory.SRAMSize + 3)) * 128) - 1 : 0;
    }

    if (strcmp (Memory.ROMName, "goemon 4") == 0)
	SNESGameFixes.SRAMInitialValue = 0x00;

    if (strcmp (Memory.ROMName, "PACHISLO ｹﾝｷｭｳ") == 0)
	SNESGameFixes._0x213E_ReturnValue = 1;

    if (strcmp (Memory.ROMName, "ｻﾞ ﾏｰｼﾞｬﾝ ﾄｳﾊｲﾃﾞﾝ") == 0)
	SNESGameFixes.TouhaidenControllerFix = TRUE;

    if (strcmp (Memory.ROMName, "DRAGON KNIGHT 4") == 0)
    {
	// Banks 70->7e, S-RAM
       int c;
	for (c = 0; c < 0xe0; c++)
	{
	    Memory.Map [c + 0x700] = (uint8 *) MAP_LOROM_SRAM;
	    Memory.BlockIsRAM [c + 0x700] = TRUE;
	    Memory.BlockIsROM [c + 0x700] = FALSE;
	}
	WriteProtectROM ();
    }

    if (strncmp (Memory.ROMName, "LETs PACHINKO(", 14) == 0)
    {
	IAPU.OneCycle = 15;
	ROMAPUEnabled  |= 2;
	CPU.APU_APUExecuting |= 2;
	if (!Settings.ForceNTSC && !Settings.ForcePAL)
	{
	    Settings.PAL = FALSE;
	    Settings.FrameTime = Settings.FrameTimeNTSC;
	    Memory.ROMFramesPerSecond = 60;
	}
    }

    if (strcmp (Memory.ROMName, "FURAI NO SIREN") == 0)
	SNESGameFixes.SoundEnvelopeHeightReading2 = TRUE;
#if 0
    if(strcmp (ROMName, "XBAND JAPANESE MODEM") == 0)
    {
	for (c = 0x200; c < 0x400; c += 16)
	{
	    for (int i = c; i < c + 16; i++)
	    {
		Map [i + 0x400] = Map [i + 0xc00] = &ROM[c * 0x1000];
		MemorySpeed [i + 0x400] = MemorySpeed [i + 0xc00] = 8;
		BlockIsRAM [i + 0x400] = BlockIsRAM [i + 0xc00] = TRUE;
		BlockIsROM [i + 0x400] = BlockIsROM [i + 0xc00] = FALSE;
	    }
	}
	WriteProtectROM ();
    }
#endif

#define RomPatch(adr,ov,nv) \
if (ROM [adr] == ov) \
    ROM [adr] = nv

    // Love Quest
    if (strcmp (Memory.ROMName, "LOVE QUEST") == 0)
    {
	RomPatch (0x1385ec, 0xd0, 0xea);
	RomPatch (0x1385ed, 0xb2, 0xea);
    }

    // Nangoku Syonen Papuwa Kun
    if (strcmp (Memory.ROMName, "NANGOKUSYONEN PAPUWA") == 0)
	RomPatch (0x1f0d1, 0xa0, 0x6b);

    // Tetsuwan Atom
    if (strcmp (Memory.ROMName, "Tetsuwan Atom") == 0)
    {
	RomPatch (0xe24c5, 0x90, 0xea);
	RomPatch (0xe24c6, 0xf3, 0xea);
    }

    // Oda Nobunaga
    if (strcmp (Memory.ROMName, "SFC ODA NOBUNAGA") == 0)
    {
	RomPatch (0x7497, 0x80, 0xea);
	RomPatch (0x7498, 0xd5, 0xea);
    }

    // Super Batter Up
    if (strcmp (Memory.ROMName, "Super Batter Up") == 0)
    {
	RomPatch (0x27ae0, 0xd0, 0xea);
	RomPatch (0x27ae1, 0xfa, 0xea);
    }

    // Super Professional Baseball 2
    if (strcmp (Memory.ROMName, "SUPER PRO. BASE BALL2") == 0)
    {
	RomPatch (0x1e4, 0x50, 0xea);
	RomPatch (0x1e5, 0xfb, 0xea);
    }

}

const uint32 crc32Table[256] = {
  0x00000000, 0x77073096, 0xee0e612c, 0x990951ba, 0x076dc419, 0x706af48f,
  0xe963a535, 0x9e6495a3, 0x0edb8832, 0x79dcb8a4, 0xe0d5e91e, 0x97d2d988,
  0x09b64c2b, 0x7eb17cbd, 0xe7b82d07, 0x90bf1d91, 0x1db71064, 0x6ab020f2,
  0xf3b97148, 0x84be41de, 0x1adad47d, 0x6ddde4eb, 0xf4d4b551, 0x83d385c7,
  0x136c9856, 0x646ba8c0, 0xfd62f97a, 0x8a65c9ec, 0x14015c4f, 0x63066cd9,
  0xfa0f3d63, 0x8d080df5, 0x3b6e20c8, 0x4c69105e, 0xd56041e4, 0xa2677172,
  0x3c03e4d1, 0x4b04d447, 0xd20d85fd, 0xa50ab56b, 0x35b5a8fa, 0x42b2986c,
  0xdbbbc9d6, 0xacbcf940, 0x32d86ce3, 0x45df5c75, 0xdcd60dcf, 0xabd13d59,
  0x26d930ac, 0x51de003a, 0xc8d75180, 0xbfd06116, 0x21b4f4b5, 0x56b3c423,
  0xcfba9599, 0xb8bda50f, 0x2802b89e, 0x5f058808, 0xc60cd9b2, 0xb10be924,
  0x2f6f7c87, 0x58684c11, 0xc1611dab, 0xb6662d3d, 0x76dc4190, 0x01db7106,
  0x98d220bc, 0xefd5102a, 0x71b18589, 0x06b6b51f, 0x9fbfe4a5, 0xe8b8d433,
  0x7807c9a2, 0x0f00f934, 0x9609a88e, 0xe10e9818, 0x7f6a0dbb, 0x086d3d2d,
  0x91646c97, 0xe6635c01, 0x6b6b51f4, 0x1c6c6162, 0x856530d8, 0xf262004e,
  0x6c0695ed, 0x1b01a57b, 0x8208f4c1, 0xf50fc457, 0x65b0d9c6, 0x12b7e950,
  0x8bbeb8ea, 0xfcb9887c, 0x62dd1ddf, 0x15da2d49, 0x8cd37cf3, 0xfbd44c65,
  0x4db26158, 0x3ab551ce, 0xa3bc0074, 0xd4bb30e2, 0x4adfa541, 0x3dd895d7,
  0xa4d1c46d, 0xd3d6f4fb, 0x4369e96a, 0x346ed9fc, 0xad678846, 0xda60b8d0,
  0x44042d73, 0x33031de5, 0xaa0a4c5f, 0xdd0d7cc9, 0x5005713c, 0x270241aa,
  0xbe0b1010, 0xc90c2086, 0x5768b525, 0x206f85b3, 0xb966d409, 0xce61e49f,
  0x5edef90e, 0x29d9c998, 0xb0d09822, 0xc7d7a8b4, 0x59b33d17, 0x2eb40d81,
  0xb7bd5c3b, 0xc0ba6cad, 0xedb88320, 0x9abfb3b6, 0x03b6e20c, 0x74b1d29a,
  0xead54739, 0x9dd277af, 0x04db2615, 0x73dc1683, 0xe3630b12, 0x94643b84,
  0x0d6d6a3e, 0x7a6a5aa8, 0xe40ecf0b, 0x9309ff9d, 0x0a00ae27, 0x7d079eb1,
  0xf00f9344, 0x8708a3d2, 0x1e01f268, 0x6906c2fe, 0xf762575d, 0x806567cb,
  0x196c3671, 0x6e6b06e7, 0xfed41b76, 0x89d32be0, 0x10da7a5a, 0x67dd4acc,
  0xf9b9df6f, 0x8ebeeff9, 0x17b7be43, 0x60b08ed5, 0xd6d6a3e8, 0xa1d1937e,
  0x38d8c2c4, 0x4fdff252, 0xd1bb67f1, 0xa6bc5767, 0x3fb506dd, 0x48b2364b,
  0xd80d2bda, 0xaf0a1b4c, 0x36034af6, 0x41047a60, 0xdf60efc3, 0xa867df55,
  0x316e8eef, 0x4669be79, 0xcb61b38c, 0xbc66831a, 0x256fd2a0, 0x5268e236,
  0xcc0c7795, 0xbb0b4703, 0x220216b9, 0x5505262f, 0xc5ba3bbe, 0xb2bd0b28,
  0x2bb45a92, 0x5cb36a04, 0xc2d7ffa7, 0xb5d0cf31, 0x2cd99e8b, 0x5bdeae1d,
  0x9b64c2b0, 0xec63f226, 0x756aa39c, 0x026d930a, 0x9c0906a9, 0xeb0e363f,
  0x72076785, 0x05005713, 0x95bf4a82, 0xe2b87a14, 0x7bb12bae, 0x0cb61b38,
  0x92d28e9b, 0xe5d5be0d, 0x7cdcefb7, 0x0bdbdf21, 0x86d3d2d4, 0xf1d4e242,
  0x68ddb3f8, 0x1fda836e, 0x81be16cd, 0xf6b9265b, 0x6fb077e1, 0x18b74777,
  0x88085ae6, 0xff0f6a70, 0x66063bca, 0x11010b5c, 0x8f659eff, 0xf862ae69,
  0x616bffd3, 0x166ccf45, 0xa00ae278, 0xd70dd2ee, 0x4e048354, 0x3903b3c2,
  0xa7672661, 0xd06016f7, 0x4969474d, 0x3e6e77db, 0xaed16a4a, 0xd9d65adc,
  0x40df0b66, 0x37d83bf0, 0xa9bcae53, 0xdebb9ec5, 0x47b2cf7f, 0x30b5ffe9,
  0xbdbdf21c, 0xcabac28a, 0x53b39330, 0x24b4a3a6, 0xbad03605, 0xcdd70693,
  0x54de5729, 0x23d967bf, 0xb3667a2e, 0xc4614ab8, 0x5d681b02, 0x2a6f2b94,
  0xb40bbe37, 0xc30c8ea1, 0x5a05df1b, 0x2d02ef8d
};

//CRC32 for char arrays
uint32 caCRC32(uint8 *array, uint32 size)
{
   uint32 crc32 = 0xFFFFFFFF;
   uint32 i;
   for (i = 0; i < size; i++)
      crc32 = ((crc32 >> 8) & 0x00FFFFFF) ^ crc32Table[(crc32 ^ array[i]) & 0xFF];
   return ~crc32;
}
#include "getset.h"
