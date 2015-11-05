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
#ifndef _SPC700_H_
#define _SPC700_H_

#ifdef SPCTOOL
#define NO_CHANNEL_STRUCT
#include "spctool/dsp.h"
#include "spctool/spc700.h"
#include "spctool/soundmod.h"
#endif


#define Carry       1
#define Zero        2
#define Interrupt   4
#define HalfCarry   8
#define BreakFlag  16
#define DirectPageFlag 32
#define Overflow   64
#define Negative  128

#define APUClearCarry() (pIAPU->_Carry = 0)
#define APUSetCarry() (pIAPU->_Carry = 1)
#define APUSetInterrupt() (pIAPU->P |= Interrupt)
#define APUClearInterrupt() (pIAPU->P &= ~Interrupt)
#define APUSetHalfCarry() (pIAPU->P |= HalfCarry)
#define APUClearHalfCarry() (pIAPU->P &= ~HalfCarry)
#define APUSetBreak() (pIAPU->P |= BreakFlag)
#define APUClearBreak() (pIAPU->P &= ~BreakFlag)
#define APUSetDirectPage() (pIAPU->P |= DirectPageFlag)
#define APUClearDirectPage() (pIAPU->P &= ~DirectPageFlag)
#define APUSetOverflow() (pIAPU->_Overflow = 1)
#define APUClearOverflow() (pIAPU->_Overflow = 0)

#define APUCheckZero() (pIAPU->_Zero == 0)
#define APUCheckCarry() (pIAPU->_Carry)
#define APUCheckInterrupt() (pIAPU->P & Interrupt)
#define APUCheckHalfCarry() (pIAPU->P & HalfCarry)
#define APUCheckBreak() (pIAPU->P & BreakFlag)
#define APUCheckDirectPage() (pIAPU->P & DirectPageFlag)
#define APUCheckOverflow() (pIAPU->_Overflow)
#define APUCheckNegative() (pIAPU->_Zero & 0x80)

//#define APUClearFlags(f) (IAPU.P &= ~(f))
//#define APUSetFlags(f)   (IAPU.P |=  (f))
//#define APUCheckFlag(f)  (IAPU.P &   (f))

typedef union
{
#ifdef LSB_FIRST
    struct { uint8 A, Y; } B;
#else
    struct { uint8 Y, A; } B;
#endif
    uint16 W;
	uint32 _padder; // make sure this whole thing takes 4 bytes
} YAndA;

struct SAPURegisters{
    uint8  P;
    YAndA YA;
    uint8  X;
    uint8  S;
    uint16  PC;
};

//EXTERN_C struct SAPURegisters APURegisters;

// Needed by ILLUSION OF GAIA
//#define ONE_APU_CYCLE 14
#define ONE_APU_CYCLE 21

// Needed by all games written by the software company called Human
//#define ONE_APU_CYCLE_HUMAN 17
#define ONE_APU_CYCLE_HUMAN 21

// 1.953us := 1.024065.54MHz

// return cycles left (always negative)
extern "C" int spc700_execute(int cycles);
extern "C" uint32 Spc700JumpTab;

#ifdef SPCTOOL
EXTERN_C int32 ESPC (int32);

#define APU_EXECUTE() \
{ \
    int32 l = (CPU.Cycles - CPU.APU_Cycles) / 14; \
    if (l > 0) \
    { \
        l -= _EmuSPC(l); \
        CPU.APU_Cycles += l * 14; \
    } \
}

#else

#ifdef DEBUGGER
#define APU_EXECUTE1() \
{ \
    if (APU.Flags & TRACE_FLAG) \
	S9xTraceAPU ();\
    CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC]; \
    (*S9xApuOpcodes[*IAPU.PC]) (); \
}
#else
#define APU_EXECUTE1() \
{ \
	IAPU.asmJumpTab = &Spc700JumpTab; \
	memcpy(&IAPU2, &IAPU, sizeof(IAPU)); \
    CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC]; \
	IAPU.opcode = *IAPU.PC; \
	pIAPU = &IAPU; \
    (*S9xApuOpcodes[*IAPU.PC]) (); \
	if(IAPU._Carry) IAPU.P |= Carry; else IAPU.P &= ~Carry; \
	if(IAPU._Overflow) IAPU.P |= Overflow; else IAPU.P &= ~Overflow; \
	pIAPU = &IAPU2; \
    spc700_execute(0); \
	APUCompare(); \
	IAPU.ya_prev = IAPU.YA.W; \
	IAPU.x_prev = IAPU.X; \
}
#endif

#define APU_EXECUTE(mode) \
if (CPU.APU_APUExecuting == mode) \
{\
    while (CPU.APU_Cycles <= CPU.Cycles) \
	APU_EXECUTE1(); \
}
#endif

#endif
