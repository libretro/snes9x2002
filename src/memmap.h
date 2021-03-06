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
#ifndef _memmap_h_
#define _memmap_h_

#include "snes9x.h"

#ifdef FAST_LSB_WORD_ACCESS
#define READ_WORD(s) (*(uint16 *) (s))
#define READ_DWORD(s) (*(uint32 *) (s))
#define WRITE_WORD(s, d) *(uint16 *) (s) = (d)
#define WRITE_DWORD(s, d) *(uint32 *) (s) = (d)
#define READ_3WORD(s) ((*(uint32 *) (s)) & 0x00FFFFFF)
#define WRITE_3WORD(s, d) *(uint16 *) (s) = (uint16) (d), \
                *((uint8 *) (s) + 2) = (uint8) ((d) >> 16)
#else
#define READ_WORD(s) ( *(uint8 *) (s) |\
            (*((uint8 *) (s) + 1) << 8))
#define READ_DWORD(s) ( *(uint8 *) (s) |\
             (*((uint8 *) (s) + 1) << 8) |\
             (*((uint8 *) (s) + 2) << 16) |\
             (*((uint8 *) (s) + 3) << 24))
#define WRITE_WORD(s, d) *(uint8 *) (s) = (d), \
                         *((uint8 *) (s) + 1) = (d) >> 8
#define WRITE_DWORD(s, d) *(uint8 *) (s) = (uint8) (d), \
                          *((uint8 *) (s) + 1) = (uint8) ((d) >> 8),\
                          *((uint8 *) (s) + 2) = (uint8) ((d) >> 16),\
                          *((uint8 *) (s) + 3) = (uint8) ((d) >> 24)
#define WRITE_3WORD(s, d) *(uint8 *) (s) = (uint8) (d), \
                          *((uint8 *) (s) + 1) = (uint8) ((d) >> 8),\
                          *((uint8 *) (s) + 2) = (uint8) ((d) >> 16)
#define READ_3WORD(s) ( *(uint8 *) (s) |\
                       (*((uint8 *) (s) + 1) << 8) |\
                       (*((uint8 *) (s) + 2) << 16))

#endif

#define MEMMAP_BLOCK_SIZE (0x1000)
#define MEMMAP_NUM_BLOCKS (0x1000000 / MEMMAP_BLOCK_SIZE)
#define MEMMAP_BLOCKS_PER_BANK (0x10000 / MEMMAP_BLOCK_SIZE)
#define MEMMAP_SHIFT 12
#define MEMMAP_MASK (MEMMAP_BLOCK_SIZE - 1)
#define MEMMAP_MAX_SDD1_LOGGED_ENTRIES (0x10000 / 8)

bool8_32 LoadROM(void);
void  InitROM(bool8_32);
bool8_32 MemoryInit(void);
void  MemoryDeinit(void);
void  FreeSDD1Data(void);

void WriteProtectROM(void);
void FixROMSpeed(void);
void MapRAM(void);
void MapExtraRAM(void);

void LoROMMap(void);
void LoROM24MBSMap(void);
void SRAM512KLoROMMap(void);
void SRAM1024KLoROMMap(void);
void SufamiTurboLoROMMap(void);
void HiROMMap(void);
void SuperFXROMMap(void);
void TalesROMMap(bool8_32);
void AlphaROMMap(void);
void SA1ROMMap(void);
void BSHiROMMap(void);
void ApplyROMFixes(void);

const char* TVStandard(void);
const char* Speed(void);
const char* StaticRAMSize(void);
const char* MapType(void);
const char* MapMode(void);
const char* KartContents(void);
const char* Size(void);
const char* Headers(void);
const char* ROMID(void);
const char* CompanyID(void);
uint32 caCRC32(uint8* array, uint32 size);

enum
{
   MAP_PPU, MAP_CPU, MAP_DSP, MAP_LOROM_SRAM, MAP_HIROM_SRAM,
   MAP_NONE, MAP_DEBUG, MAP_C4, MAP_BWRAM, MAP_BWRAM_BITMAP,
   MAP_BWRAM_BITMAP2, MAP_SA1RAM, MAP_LAST
};
enum { MAX_ROM_SIZE = 0x600000 };
typedef struct
{

   uint8* RAM;
   uint8* ROM;
   uint8* VRAM;
   uint8* SRAM;
   uint8* BWRAM;
   uint8* FillRAM;
   uint8* C4RAM;
   bool8_32 HiROM;
   bool8_32 LoROM;
   uint16 SRAMMask;
   uint8 SRAMSize;
   uint8* Map [MEMMAP_NUM_BLOCKS];
   uint8* WriteMap [MEMMAP_NUM_BLOCKS];
   uint32 MemorySpeed [MEMMAP_NUM_BLOCKS];
   uint8 BlockIsRAM [MEMMAP_NUM_BLOCKS];
   uint8 BlockIsROM [MEMMAP_NUM_BLOCKS];
   char  ROMName [ROM_NAME_LEN];
   char  ROMId [5];
   char  CompanyId [3];
   uint8 ROMSpeed;
   uint8 ROMType;
   uint8 ROMSize;
   int32 ROMFramesPerSecond;
   int32 HeaderCount;
   uint32 CalculatedSize;
   uint32 CalculatedChecksum;
   uint32 ROMChecksum;
   uint32 ROMComplementChecksum;
   uint8*  SDD1Index;
   uint8*  SDD1Data;
   uint32 SDD1Entries;
} CMemory;

extern CMemory Memory;
extern uint8* SRAM;
extern uint8* ROM;
extern uint8* RegRAM;
void S9xDeinterleaveMode2(void);

#ifdef NO_INLINE_SET_GET
uint8 S9xGetByte(uint32 Address, struct SCPUState*);
uint16 S9xGetWord(uint32 Address, struct SCPUState*);
void S9xSetByte(uint8 Byte, uint32 Address, struct SCPUState*);
void S9xSetWord(uint16 Byte, uint32 Address, struct SCPUState*);
void S9xSetPCBase(uint32 Address, struct SCPUState*);
uint8* S9xGetMemPointer(uint32 Address);
uint8* GetBasePointer(uint32 Address);
#else
#ifndef INLINE
#define INLINE inline
#endif
#include "getset.h"
#endif // NO_INLINE_SET_GET

#endif // _memmap_h_
