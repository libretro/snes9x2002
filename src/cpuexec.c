/*
 * Snes9x - Portable Super Nintendo Entertainment System (TM) emulator.
 *
 * (c) Copyright 1996 - 2001 Gary Henderson (gary.henderson@ntlworld.com) and
 *                           Jerremy Koot (jkoot@snes9x.com)
 *
 * Super FX C emulator code
 * (c) Copyright 1997 - 1999 Ivar (ivar@snes9x.com) and
 *                           Gary Henderson.
 * Super FX    assembler emulator code (c) Copyright 1998 zsKnight and _Demo_.
 *
 * DSP1 emulator code (c) Copyright 1998 Ivar, _Demo_ and Gary Henderson.
 * C4 asm and some C emulation code (c) Copyright 2000 zsKnight and _Demo_.
 * C4 C code (c) Copyright 2001 Gary Henderson (gary.henderson@ntlworld.com).
 *
 * DOS port code contains the works of other authors. See headers in
 * individual files.
 *
 * (c) Copyright 2014 - 2016 Daniel De Matteis. (UNDER NO CIRCUMSTANCE 
 * WILL COMMERCIAL RIGHTS EVER BE APPROPRIATED TO ANY PARTY)
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
#include "cpuops.h"
#include "ppu.h"
#include "cpuexec.h"
#include "snapshot.h"
#include "gfx.h"
#include "missing.h"
#include "apu.h"
#include "dma.h"
#include "fxemu.h"
#ifdef USE_SA1
#include "sa1.h"
#endif

#include "os9x_asm_cpu.h"


void (*S9x_Current_HBlank_Event)();


#ifndef ASMCPU
#ifdef USE_SA1
void S9xMainLoop_SA1_APU(void)
{
   for (;;)
   {
      asm_APU_EXECUTE(1);
      if (CPU.Flags)
      {
         if (CPU.Flags & NMI_FLAG)
         {
            if (--CPU.NMICycleCount == 0)
            {
               CPU.Flags &= ~NMI_FLAG;
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  ++CPU.PC;
               }
               S9xOpcode_NMI();
            }
         }

         if (CPU.Flags & IRQ_PENDING_FLAG)
         {
            if (CPU.IRQCycleCount == 0)
            {
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  CPU.PC++;
               }
               if (CPU.IRQActive && !Settings.DisableIRQ)
               {
                  if (!CheckFlag(IRQ))
                     S9xOpcode_IRQ();
               }
               else
                  CPU.Flags &= ~IRQ_PENDING_FLAG;
            }
            else
               CPU.IRQCycleCount--;
         }
         if (CPU.Flags & SCAN_KEYS_FLAG)
            break;
      }

#ifdef CPU_SHUTDOWN
      CPU.PCAtOpcodeStart = CPU.PC;
#endif
#ifdef VAR_CYCLES
      CPU.Cycles += CPU.MemSpeed;
#else
      CPU.Cycles += ICPU.Speed [*CPU.PC];
#endif
      (*ICPU.S9xOpcodes[*CPU.PC++].S9xOpcode)();


      //S9xUpdateAPUTimer ();


      if (SA1.Executing)
         S9xSA1MainLoop();
      DO_HBLANK_CHECK();

#ifdef LAGFIX
      if (finishedFrame)
         break;
#endif
   }
}

void S9xMainLoop_SA1_NoAPU(void)
{
   for (;;)
   {
      if (CPU.Flags)
      {
         if (CPU.Flags & NMI_FLAG)
         {
            if (--CPU.NMICycleCount == 0)
            {
               CPU.Flags &= ~NMI_FLAG;
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  ++CPU.PC;
               }
               S9xOpcode_NMI();
            }
         }

         if (CPU.Flags & IRQ_PENDING_FLAG)
         {
            if (CPU.IRQCycleCount == 0)
            {
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  CPU.PC++;
               }
               if (CPU.IRQActive && !Settings.DisableIRQ)
               {
                  if (!CheckFlag(IRQ))
                     S9xOpcode_IRQ();
               }
               else
                  CPU.Flags &= ~IRQ_PENDING_FLAG;
            }
            else
               CPU.IRQCycleCount--;
         }
         if (CPU.Flags & SCAN_KEYS_FLAG)
            break;
      }

#ifdef CPU_SHUTDOWN
      CPU.PCAtOpcodeStart = CPU.PC;
#endif
#ifdef VAR_CYCLES
      CPU.Cycles += CPU.MemSpeed;
#else
      CPU.Cycles += ICPU.Speed [*CPU.PC];
#endif
      (*ICPU.S9xOpcodes[*CPU.PC++].S9xOpcode)();


      //S9xUpdateAPUTimer ();


      if (SA1.Executing)
         S9xSA1MainLoop();
      DO_HBLANK_CHECK();

#ifdef LAGFIX
      if (finishedFrame)
         break;
#endif
   }
}
// USE_SA1
#endif

void S9xMainLoop_NoSA1_APU(void)
{
   for (;;)
   {
      asm_APU_EXECUTE(1);
      if (CPU.Flags)
      {
         if (CPU.Flags & NMI_FLAG)
         {
            if (--CPU.NMICycleCount == 0)
            {
               CPU.Flags &= ~NMI_FLAG;
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  ++CPU.PC;
               }
               S9xOpcode_NMI();
            }
         }

         if (CPU.Flags & IRQ_PENDING_FLAG)
         {
            if (CPU.IRQCycleCount == 0)
            {
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  CPU.PC++;
               }
               if (CPU.IRQActive && !Settings.DisableIRQ)
               {
                  if (!CheckFlag(IRQ))
                     S9xOpcode_IRQ();
               }
               else
                  CPU.Flags &= ~IRQ_PENDING_FLAG;
            }
            else
               CPU.IRQCycleCount--;
         }
         if (CPU.Flags & SCAN_KEYS_FLAG)
            break;
      }

#ifdef CPU_SHUTDOWN
      CPU.PCAtOpcodeStart = CPU.PC;
#endif
#ifdef VAR_CYCLES
      CPU.Cycles += CPU.MemSpeed;
#else
      CPU.Cycles += ICPU.Speed [*CPU.PC];
#endif
      (*ICPU.S9xOpcodes[*CPU.PC++].S9xOpcode)();


      //S9xUpdateAPUTimer ();

      DO_HBLANK_CHECK();

#ifdef LAGFIX
      if (finishedFrame)
         break;
#endif
   }
}

void S9xMainLoop_NoSA1_NoAPU(void)
{
   for (;;)
   {
      if (CPU.Flags)
      {
         if (CPU.Flags & NMI_FLAG)
         {
            if (--CPU.NMICycleCount == 0)
            {
               CPU.Flags &= ~NMI_FLAG;
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  ++CPU.PC;
               }
               S9xOpcode_NMI();
            }
         }

         if (CPU.Flags & IRQ_PENDING_FLAG)
         {
            if (CPU.IRQCycleCount == 0)
            {
               if (CPU.WaitingForInterrupt)
               {
                  CPU.WaitingForInterrupt = FALSE;
                  CPU.PC++;
               }
               if (CPU.IRQActive && !Settings.DisableIRQ)
               {
                  if (!CheckFlag(IRQ))
                     S9xOpcode_IRQ();
               }
               else
                  CPU.Flags &= ~IRQ_PENDING_FLAG;
            }
            else
               CPU.IRQCycleCount--;
         }
         if (CPU.Flags & SCAN_KEYS_FLAG)
            break;
      }

#ifdef CPU_SHUTDOWN
      CPU.PCAtOpcodeStart = CPU.PC;
#endif
#ifdef VAR_CYCLES
      CPU.Cycles += CPU.MemSpeed;
#else
      CPU.Cycles += ICPU.Speed [*CPU.PC];
#endif
      (*ICPU.S9xOpcodes[*CPU.PC++].S9xOpcode)();


      //S9xUpdateAPUTimer ();


      DO_HBLANK_CHECK();

#ifdef LAGFIX
      if (finishedFrame)
         break;
#endif
   }
}
#endif


void
S9xMainLoop(void)
{
#ifdef LAGFIX
   do
   {
#endif
#ifndef ASMCPU
      if (Settings.APUEnabled == 1)
      {
#ifdef USE_SA1
         if (Settings.SA1)
            S9xMainLoop_SA1_APU();
         else
#endif
            S9xMainLoop_NoSA1_APU();
      }
      else
      {
#ifdef USE_SA1
         if (Settings.SA1)
            S9xMainLoop_SA1_NoAPU();
         else
#endif
            S9xMainLoop_NoSA1_NoAPU();
      }
#else
#ifdef ASM_SPC700
      if (Settings.asmspc700)
         asmMainLoop_spcAsm(&CPU);
      else
#endif
         asmMainLoop_spcC(&CPU);
#endif

#ifdef LAGFIX
      if (!finishedFrame)
      {
#endif
#ifndef LAGFIX
         Registers.PC = CPU.PC - CPU.PCBase;

#ifndef ASMCPU
         S9xPackStatus();
#endif

         S9xAPUPackStatus();
#endif

         //if (CPU.Flags & SCAN_KEYS_FLAG)
         // {
         CPU.Flags &= ~SCAN_KEYS_FLAG;
         //}

         if (CPU.BRKTriggered && Settings.SuperFX && !CPU.TriedInterleavedMode2)
         {
            CPU.TriedInterleavedMode2 = TRUE;
            CPU.BRKTriggered = FALSE;
            S9xDeinterleaveMode2();
         }
#ifdef LAGFIX
      }
      else
      {
         finishedFrame = false;

         Registers.PC = CPU.PC - CPU.PCBase;

#ifndef ASMCPU
         S9xPackStatus();
#endif

         S9xAPUPackStatus();

         break;
      }
   } while (!finishedFrame);
#endif
}

void S9xSetIRQ(uint32 source)
{
   CPU.IRQActive |= source;
   CPU.Flags |= IRQ_PENDING_FLAG;
   CPU.IRQCycleCount = 3;
   if (CPU.WaitingForInterrupt)
   {
      // Force IRQ to trigger immediately after WAI -
      // Final Fantasy Mystic Quest crashes without this.
      CPU.IRQCycleCount = 0;
      CPU.WaitingForInterrupt = FALSE;
      CPU.PC++;
   }
}

void S9xClearIRQ(uint32 source)
{
   CLEAR_IRQ_SOURCE(source);
}

void S9xDoHBlankProcessing()
{
#ifdef CPU_SHUTDOWN
   CPU.WaitCounter++;
#endif

   switch (CPU.WhichEvent)
   {
   case HBLANK_START_EVENT:
      if (IPPU.HDMA && CPU.V_Counter <= PPU.ScreenHeight)
         IPPU.HDMA = S9xDoHDMA(IPPU.HDMA);
      break;

   case HBLANK_END_EVENT:
      asm_APU_EXECUTE(3); // notaz: run spc700 in sound 'speed hack' mode
      if (Settings.SuperFX)
         S9xSuperFXExec();

      CPU.Cycles -= Settings.H_Max;
      if (/*IAPU.APUExecuting*/CPU.APU_APUExecuting)
         CPU.APU_Cycles -= Settings.H_Max;
      else
         CPU.APU_Cycles = 0;

      CPU.NextEvent = -1;
      ICPU.Scanline++;

      if (++CPU.V_Counter >= (Settings.PAL ? SNES_MAX_PAL_VCOUNTER : SNES_MAX_NTSC_VCOUNTER))
      {
         CPU.V_Counter = 0;
         CPU.NMIActive = FALSE;
         ICPU.Frame++;
         PPU.HVBeamCounterLatched = 0;
         CPU.Flags |= SCAN_KEYS_FLAG;
         S9xStartHDMA();
      }

      if (PPU.VTimerEnabled && !PPU.HTimerEnabled &&
            CPU.V_Counter == PPU.IRQVBeamPos)
         S9xSetIRQ(PPU_V_BEAM_IRQ_SOURCE);

      if (CPU.V_Counter == PPU.ScreenHeight + FIRST_VISIBLE_LINE)
      {
         // Start of V-blank
         S9xEndScreenRefresh();
         IPPU.HDMA = 0;
         // Bits 7 and 6 of $4212 are computed when read in S9xGetPPU.
         missing.dma_this_frame = 0;
         IPPU.MaxBrightness = PPU.Brightness;
         PPU.ForcedBlanking = (Memory.FillRAM [0x2100] >> 7) & 1;

         if (!PPU.ForcedBlanking)
         {
            PPU.OAMAddr = PPU.SavedOAMAddr;
            PPU.OAMFlip = 0;
            PPU.FirstSprite = 0;
            if (PPU.OAMPriorityRotation)
               PPU.FirstSprite = PPU.OAMAddr >> 1;
         }

         Memory.FillRAM[0x4210] = 0x80;
         if (Memory.FillRAM[0x4200] & 0x80)
         {
            CPU.NMIActive = TRUE;
            CPU.Flags |= NMI_FLAG;
            CPU.NMICycleCount = CPU.NMITriggerPoint;
         }

      }

      if (CPU.V_Counter == PPU.ScreenHeight + 3)
         S9xUpdateJoypads();

      if (CPU.V_Counter == FIRST_VISIBLE_LINE)
      {
         Memory.FillRAM[0x4210] = 0;
         CPU.Flags &= ~NMI_FLAG;
         S9xStartScreenRefresh();
      }
      if (CPU.V_Counter >= FIRST_VISIBLE_LINE &&
            CPU.V_Counter < PPU.ScreenHeight + FIRST_VISIBLE_LINE)
         RenderLine(CPU.V_Counter - FIRST_VISIBLE_LINE);
      // Use TimerErrorCounter to skip update of SPC700 timers once
      // every 128 updates. Needed because this section of code is called
      // once every emulated 63.5 microseconds, which coresponds to
      // 15.750KHz, but the SPC700 timers need to be updated at multiples
      // of 8KHz, hence the error correction.
      // IAPU.TimerErrorCounter++;
      // if (IAPU.TimerErrorCounter >= )
      //     IAPU.TimerErrorCounter = 0;
      // else
      {
         if (APU.TimerEnabled [2])
         {
            APU.Timer [2] += 4;
            while (APU.Timer [2] >= APU.TimerTarget [2])
            {
               IAPU.RAM [0xff] = (IAPU.RAM [0xff] + 1) & 0xf;
               APU.Timer [2] -= APU.TimerTarget [2];
#ifdef SPC700_SHUTDOWN
               IAPU.WaitCounter++;
               /*IAPU.APUExecuting*/CPU.APU_APUExecuting = TRUE;
#endif
            }
         }
         if (CPU.V_Counter & 1)
         {
            if (APU.TimerEnabled [0])
            {
               APU.Timer [0]++;
               if (APU.Timer [0] >= APU.TimerTarget [0])
               {
                  IAPU.RAM [0xfd] = (IAPU.RAM [0xfd] + 1) & 0xf;
                  APU.Timer [0] = 0;
#ifdef SPC700_SHUTDOWN
                  IAPU.WaitCounter++;
                  /*IAPU.APUExecuting*/CPU.APU_APUExecuting = TRUE;
#endif
               }
            }
            if (APU.TimerEnabled [1])
            {
               APU.Timer [1]++;
               if (APU.Timer [1] >= APU.TimerTarget [1])
               {
                  IAPU.RAM [0xfe] = (IAPU.RAM [0xfe] + 1) & 0xf;
                  APU.Timer [1] = 0;
#ifdef SPC700_SHUTDOWN
                  IAPU.WaitCounter++;
                  /*IAPU.APUExecuting*/CPU.APU_APUExecuting = TRUE;
#endif
               }
            }
         }
      }
      break;
   case HTIMER_BEFORE_EVENT:
   case HTIMER_AFTER_EVENT:
      if (PPU.HTimerEnabled &&
            (!PPU.VTimerEnabled || CPU.V_Counter == PPU.IRQVBeamPos))
         S9xSetIRQ(PPU_H_BEAM_IRQ_SOURCE);
      break;
   }
   S9xReschedule();
}

