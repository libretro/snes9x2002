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
#ifndef _CPUEXEC_H_
#define _CPUEXEC_H_
//#include "ppu.h"
//#include "memmap.h"
#include "snes9x.h"
#include "65c816.h"

#define DO_HBLANK_CHECK() \
    if (CPU.Cycles >= CPU.NextEvent) \
   S9xDoHBlankProcessing ();

typedef struct
{
   void (*S9xOpcode)(void);
} SOpcodes;

typedef struct
{
   uint8*  Speed;
   SOpcodes* S9xOpcodes;
   uint8  _Carry;
   uint8  _Zero;
   uint8  _Negative;
   uint8  _Overflow;
   bool8  CPUExecuting;
   uint32 ShiftedPB;
   uint32 ShiftedDB;
   uint32 Frame;
   uint32 Scanline;
   uint32 FrameAdvanceCount;
} SICPU;

void S9xMainLoop(void);
void S9xReset(void);
void S9xDoHBlankProcessing();
void S9xClearIRQ(uint32);
void S9xSetIRQ(uint32);

extern SOpcodes S9xOpcodesM1X1 [256];
extern SOpcodes S9xOpcodesM1X0 [256];
extern SOpcodes S9xOpcodesM0X1 [256];
extern SOpcodes S9xOpcodesM0X0 [256];

#ifndef VAR_CYCLES
extern uint8 S9xE1M1X1 [256];
extern uint8 S9xE0M1X0 [256];
extern uint8 S9xE0M1X1 [256];
extern uint8 S9xE0M0X0 [256];
extern uint8 S9xE0M0X1 [256];
#endif

extern SICPU ICPU;

static INLINE void CLEAR_IRQ_SOURCE(uint32 M)
{
   CPU.IRQActive &= ~M;
   if (!CPU.IRQActive)
      CPU.Flags &= ~IRQ_PENDING_FLAG;
}

static INLINE void S9xUnpackStatus()
{
   ICPU._Zero = (Registers.PL & Zero) == 0;
   ICPU._Negative = (Registers.PL & Negative);
   ICPU._Carry = (Registers.PL & Carry);
   ICPU._Overflow = (Registers.PL & Overflow) >> 6;
}

static INLINE void S9xPackStatus()
{
   Registers.PL &= ~(Zero | Negative | Carry | Overflow);
   Registers.PL |= ICPU._Carry | ((ICPU._Zero == 0) << 1) |
                   (ICPU._Negative & 0x80) | (ICPU._Overflow << 6);
}

static INLINE void S9xFixCycles()
{
   if (CheckEmulation())
   {
#ifndef VAR_CYCLES
      ICPU.Speed = S9xE1M1X1;
#endif
      ICPU.S9xOpcodes = S9xOpcodesM1X1;
   }
   else if (CheckMemory())
   {
      if (CheckIndex())
      {
#ifndef VAR_CYCLES
         ICPU.Speed = S9xE0M1X1;
#endif
         ICPU.S9xOpcodes = S9xOpcodesM1X1;
      }
      else
      {
#ifndef VAR_CYCLES
         ICPU.Speed = S9xE0M1X0;
#endif
         ICPU.S9xOpcodes = S9xOpcodesM1X0;
      }
   }
   else
   {
      if (CheckIndex())
      {
#ifndef VAR_CYCLES
         ICPU.Speed = S9xE0M0X1;
#endif
         ICPU.S9xOpcodes = S9xOpcodesM0X1;
      }
      else
      {
#ifndef VAR_CYCLES
         ICPU.Speed = S9xE0M0X0;
#endif
         ICPU.S9xOpcodes = S9xOpcodesM0X0;
      }
   }
}


#define S9xReschedule() { \
   uint8 which; \
  long max; \
  if (CPU.WhichEvent == HBLANK_START_EVENT || CPU.WhichEvent == HTIMER_AFTER_EVENT) { \
      which = HBLANK_END_EVENT; \
      max = Settings.H_Max; \
  } else { \
      which = HBLANK_START_EVENT; \
      max = Settings.HBlankStart; \
  } \
 \
  if (PPU.HTimerEnabled && (long) PPU.HTimerPosition < max &&  (long) PPU.HTimerPosition > CPU.NextEvent && \
      (!PPU.VTimerEnabled || (PPU.VTimerEnabled && CPU.V_Counter == PPU.IRQVBeamPos))) { \
      which = (long) PPU.HTimerPosition < Settings.HBlankStart ? HTIMER_BEFORE_EVENT : HTIMER_AFTER_EVENT; \
      max = PPU.HTimerPosition; \
  } \
  CPU.NextEvent = max; \
  CPU.WhichEvent = which; \
}

/*
extern "C" {
void asm_APU_EXECUTE(int Mode);
void asm_APU_EXECUTE2(void);
}*/
#ifdef ASM_SPC700
#define asm_APU_EXECUTE(MODE)\
{\
   if (CPU.APU_APUExecuting == MODE) {\
        if (Settings.asmspc700) {\
      if(CPU.APU_Cycles < CPU.Cycles) {\
         int cycles = CPU.Cycles - CPU.APU_Cycles;\
         CPU.APU_Cycles += cycles - spc700_execute(cycles);\
      }\
   }\
   else\
   {\
      while (CPU.APU_Cycles <= CPU.Cycles)\
      {\
         CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC];\
         (*S9xApuOpcodes[*IAPU.PC]) ();\
      }\
   }\
  }\
}


#define asm_APU_EXECUTE2() \
{\
    if  (CPU.APU_APUExecuting == 1) {\
        if (Settings.asmspc700) {\
      if (CPU.APU_Cycles < CPU.NextEvent) {\
         int cycles = CPU.NextEvent - CPU.APU_Cycles;\
         CPU.APU_Cycles += cycles - spc700_execute(cycles);\
      }\
   }\
   else\
   {\
      do\
      {\
         CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC];\
         (*S9xApuOpcodes[*IAPU.PC]) ();\
      } while (CPU.APU_Cycles < CPU.NextEvent);\
   }\
  }\
}
#else

#define asm_APU_EXECUTE(MODE)\
   do { if (CPU.APU_APUExecuting == MODE) \
      while (CPU.APU_Cycles <= CPU.Cycles)\
      {\
         CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC];\
         (*S9xApuOpcodes[*IAPU.PC]) ();\
      }}while(0)


#define asm_APU_EXECUTE2() \
    if  (CPU.APU_APUExecuting == 1) do\
      {\
         CPU.APU_Cycles += S9xAPUCycles [*IAPU.PC];\
         (*S9xApuOpcodes[*IAPU.PC]) ();\
      } while (CPU.APU_Cycles < CPU.NextEvent)

#endif

#endif
