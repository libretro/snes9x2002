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

#ifdef CPUASM
#define  _CPUADDR_H_
#endif

#ifndef _CPUADDR_H_
#define _CPUADDR_H_

extern long OpAddress;

static INLINE void Immediate8()
{
   OpAddress = ICPU.ShiftedPB + CPU.PC - CPU.PCBase;
   CPU.PC++;
}

static INLINE void Immediate16()
{
   OpAddress = ICPU.ShiftedPB + CPU.PC - CPU.PCBase;
   CPU.PC += 2;
}

static INLINE void Relative()
{
   signed char s9xInt8 = *CPU.PC++;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif
   OpAddress = ((int)(CPU.PC - CPU.PCBase) + s9xInt8) & 0xffff;
}

static INLINE void RelativeLong()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = *(uint16*) CPU.PC;
#else
   OpAddress = *CPU.PC + (*(CPU.PC + 1) << 8);
#endif
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2 + ONE_CYCLE;
#endif
   CPU.PC += 2;
   OpAddress += (CPU.PC - CPU.PCBase);
   OpAddress &= 0xffff;
}

static INLINE void AbsoluteIndexedIndirect()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = (Registers.X.W + * (uint16*) CPU.PC) & 0xffff;
#else
   OpAddress = (Registers.X.W + *CPU.PC + (*(CPU.PC + 1) << 8)) & 0xffff;
#endif
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
   CPU.PC += 2;
   OpAddress = S9xGetWord(ICPU.ShiftedPB + OpAddress);
}

static INLINE void AbsoluteIndirectLong()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = *(uint16*) CPU.PC;
#else
   OpAddress = *CPU.PC + (*(CPU.PC + 1) << 8);
#endif

#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
   CPU.PC += 2;
   OpAddress = S9xGetWord(OpAddress) | (S9xGetByte(OpAddress + 2) << 16);
}

static INLINE void AbsoluteIndirect()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = *(uint16*) CPU.PC;
#else
   OpAddress = *CPU.PC + (*(CPU.PC + 1) << 8);
#endif

#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
   CPU.PC += 2;
   OpAddress = S9xGetWord(OpAddress) + ICPU.ShiftedPB;
}

static INLINE void Absolute()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = *(uint16*) CPU.PC + ICPU.ShiftedDB;
#else
   OpAddress = *CPU.PC + (*(CPU.PC + 1) << 8) + ICPU.ShiftedDB;
#endif
   CPU.PC += 2;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
}

static INLINE void AbsoluteLong()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = (*(uint32*) CPU.PC) & 0xffffff;
#elif defined FAST_ALIGNED_LSB_WORD_ACCESS
   if (((int) CPU.PC & 1) == 0)
      OpAddress = (*(uint16 *) CPU.PC) + (*(CPU.PC + 2) << 16);
   else
      OpAddress = *CPU.PC + ((*(uint16 *) (CPU.PC + 1)) << 8);
#else
   OpAddress = *CPU.PC + (*(CPU.PC + 1) << 8) + (*(CPU.PC + 2) << 16);
#endif
   CPU.PC += 3;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2 + CPU.MemSpeed;
#endif
}

static INLINE void Direct(void)
{
   OpAddress = (*CPU.PC++ + Registers.D.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif
   //    if (Registers.DL != 0) CPU.Cycles += ONE_CYCLE;
}

static INLINE void DirectIndirectIndexed()
{
   OpAddress = (*CPU.PC++ + Registers.D.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif

   OpAddress = ICPU.ShiftedDB + S9xGetWord(OpAddress) + Registers.Y.W;

   //    if (Registers.DL != 0) CPU.Cycles += ONE_CYCLE;
   // XXX: always add one if STA
   // XXX: else Add one cycle if crosses page boundary
}

static INLINE void DirectIndirectIndexedLong()
{
   OpAddress = (*CPU.PC++ + Registers.D.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif

   OpAddress = S9xGetWord(OpAddress) + (S9xGetByte(OpAddress + 2) << 16) +
               Registers.Y.W;
   //    if (Registers.DL != 0) CPU.Cycles += ONE_CYCLE;
}

static INLINE void DirectIndexedIndirect(void)
{
   OpAddress = (*CPU.PC++ + Registers.D.W + Registers.X.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif

   OpAddress = S9xGetWord(OpAddress) + ICPU.ShiftedDB;

#ifdef VAR_CYCLES
   //    if (Registers.DL != 0)
   // CPU.Cycles += TWO_CYCLES;
   //    else
   CPU.Cycles += ONE_CYCLE;
#endif
}

static INLINE void DirectIndexedX()
{
   OpAddress = (*CPU.PC++ + Registers.D.W + Registers.X.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif

#ifdef VAR_CYCLES
   //    if (Registers.DL != 0)
   // CPU.Cycles += TWO_CYCLES;
   //    else
   CPU.Cycles += ONE_CYCLE;
#endif
}

static INLINE void DirectIndexedY()
{
   OpAddress = (*CPU.PC++ + Registers.D.W + Registers.Y.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif

#ifdef VAR_CYCLES
   //    if (Registers.DL != 0)
   // CPU.Cycles += TWO_CYCLES;
   //    else
   CPU.Cycles += ONE_CYCLE;
#endif
}

static INLINE void AbsoluteIndexedX()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = ICPU.ShiftedDB + *(uint16*) CPU.PC + Registers.X.W;
#else
   OpAddress = ICPU.ShiftedDB + *CPU.PC + (*(CPU.PC + 1) << 8) +
               Registers.X.W;
#endif
   CPU.PC += 2;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
   // XXX: always add one cycle for ROL, LSR, etc
   // XXX: else is cross page boundary add one cycle
}

static INLINE void AbsoluteIndexedY()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = ICPU.ShiftedDB + *(uint16*) CPU.PC + Registers.Y.W;
#else
   OpAddress = ICPU.ShiftedDB + *CPU.PC + (*(CPU.PC + 1) << 8) +
               Registers.Y.W;
#endif
   CPU.PC += 2;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2;
#endif
   // XXX: always add cycle for STA
   // XXX: else is cross page boundary add one cycle
}

static INLINE void AbsoluteLongIndexedX()
{
#ifdef FAST_LSB_WORD_ACCESS
   OpAddress = (*(uint32*) CPU.PC + Registers.X.W) & 0xffffff;
#elif defined FAST_ALIGNED_LSB_WORD_ACCESS
   if (((int) CPU.PC & 1) == 0)
      OpAddress = ((*(uint16 *) CPU.PC) + (*(CPU.PC + 2) << 16) + Registers.X.W) & 0xFFFFFF;
   else
      OpAddress = (*CPU.PC + ((*(uint16 *) (CPU.PC + 1)) << 8) + Registers.X.W) & 0xFFFFFF;
#else
   OpAddress = (*CPU.PC + (*(CPU.PC + 1) << 8) + (*(CPU.PC + 2) << 16) + Registers.X.W) & 0xffffff;
#endif
   CPU.PC += 3;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeedx2 + CPU.MemSpeed;
#endif
}

static INLINE void DirectIndirect()
{
   OpAddress = (*CPU.PC++ + Registers.D.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif
   OpAddress = S9xGetWord(OpAddress) + ICPU.ShiftedDB;

   //    if (Registers.DL != 0) CPU.Cycles += ONE_CYCLE;
}

static INLINE void DirectIndirectLong()
{
   OpAddress = (*CPU.PC++ + Registers.D.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
#endif
   OpAddress = S9xGetWord(OpAddress) +
               (S9xGetByte(OpAddress + 2) << 16);
   //    if (Registers.DL != 0) CPU.Cycles += ONE_CYCLE;
}

static INLINE void StackRelative()
{
   OpAddress = (*CPU.PC++ + Registers.S.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
   CPU.Cycles += ONE_CYCLE;
#endif
}

static INLINE void StackRelativeIndirectIndexed()
{
   OpAddress = (*CPU.PC++ + Registers.S.W) & 0xffff;
#ifdef VAR_CYCLES
   CPU.Cycles += CPU.MemSpeed;
   CPU.Cycles += TWO_CYCLES;
#endif
   OpAddress = (S9xGetWord(OpAddress) + ICPU.ShiftedDB +
                Registers.Y.W) & 0xffffff;
}
#endif
