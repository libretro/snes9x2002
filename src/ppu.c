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
#include "snes9x.h"
#include "memmap.h"
#include "ppu.h"
#include "cpuexec.h"
#include "missing.h"
#include "apu.h"
#include "dma.h"
#include "gfx.h"
#include "display.h"
#include "sa1.h"
#include "sdd1.h"
#include "srtc.h"

#include "port.h"

#include "fxemu.h"
#include "fxinst.h"
extern FxInit_s SuperFX;
extern FxRegs_s GSU;
extern uint8* HDMAMemPointers [8];

void S9xUpdateHTimer()
{
   if (PPU.HTimerEnabled)
   {
#ifdef DEBUGGER
      missing.hirq_pos = PPU.IRQHBeamPos;
#endif
      PPU.HTimerPosition = PPU.IRQHBeamPos * Settings.H_Max / SNES_HCOUNTER_MAX;
      if (PPU.HTimerPosition == Settings.H_Max ||
            PPU.HTimerPosition == Settings.HBlankStart)
         PPU.HTimerPosition--;

      if (!PPU.VTimerEnabled || CPU.V_Counter == PPU.IRQVBeamPos)
      {
         if (PPU.HTimerPosition < CPU.Cycles)
         {
            // Missed the IRQ on this line already
            if (CPU.WhichEvent == HBLANK_END_EVENT ||
                  CPU.WhichEvent == HTIMER_AFTER_EVENT)
            {
               CPU.WhichEvent = HBLANK_END_EVENT;
               CPU.NextEvent = Settings.H_Max;
            }
            else
            {
               CPU.WhichEvent = HBLANK_START_EVENT;
               CPU.NextEvent = Settings.HBlankStart;
            }
         }
         else
         {
            if (CPU.WhichEvent == HTIMER_BEFORE_EVENT ||
                  CPU.WhichEvent == HBLANK_START_EVENT)
            {
               if (PPU.HTimerPosition > Settings.HBlankStart)
               {
                  // HTimer was to trigger before h-blank start,
                  // now triggers after start of h-blank
                  CPU.NextEvent = Settings.HBlankStart;
                  CPU.WhichEvent = HBLANK_START_EVENT;
               }
               else
               {
                  CPU.NextEvent = PPU.HTimerPosition;
                  CPU.WhichEvent = HTIMER_BEFORE_EVENT;
               }
            }
            else
            {
               CPU.WhichEvent = HTIMER_AFTER_EVENT;
               CPU.NextEvent = PPU.HTimerPosition;
            }
         }
      }
   }
}

void S9xFixColourBrightness()
{
   IPPU.XB = mul_brightness [PPU.Brightness];
   {
      unsigned int i;
      for (i = 0; i < 256; i++)
      {
         //IPPU.Red [i] = IPPU.XB [PPU.CGDATA [i] & 0x1f];
         //IPPU.Green [i] = IPPU.XB [(PPU.CGDATA [i] >> 5) & 0x1f];
         //IPPU.Blue [i] = IPPU.XB [(PPU.CGDATA [i] >> 10) & 0x1f];
         IPPU.ScreenColors [i] = BUILD_PIXEL(IPPU.XB[IPPU.Red [i]], IPPU.XB[IPPU.Green [i]], IPPU.XB[IPPU.Blue [i]]);
      }
   }
}

/**********************************************************************************************/
/* S9xSetPPU()                                                                                   */
/* This function sets a PPU Register to a specific byte                                       */
/**********************************************************************************************/
#include "ppu_setppu.h"

/**********************************************************************************************/
/* S9xGetPPU()                                                                                   */
/* This function retrieves a PPU Register                                                     */
/**********************************************************************************************/
#include "ppu_getppu.h"

/**********************************************************************************************/
/* S9xSetCPU()                                                                                   */
/* This function sets a CPU/DMA Register to a specific byte                                   */
/**********************************************************************************************/
void S9xSetCPU(uint8 byte, uint16 Address)
{
   int d;

   if (Address < 0x4200)
   {
#ifdef VAR_CYCLES
      CPU.Cycles += ONE_CYCLE;
#endif
      switch (Address)
      {
      case 0x4016 :
         // S9xReset reading of old-style joypads
         if ((byte & 1) && !(Memory.FillRAM[Address] & 1))
         {
            PPU.Joypad1ButtonReadPos = 0;
            PPU.Joypad2ButtonReadPos = 0;
            PPU.Joypad3ButtonReadPos = 0;
         }
         break;
      case 0x4017 :
         return;
      default :
#ifdef DEBUGGER
         missing.unknowncpu_write = Address;
         if (Settings.TraceUnknownRegisters)
         {
            sprintf(String, "Unknown register register write: $%02X->$%04X\n", byte, Address);
            S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
         }
#endif
         break;
      }
   }
   else
      switch (Address)
      {
      case 0x4200 :
         // NMI, V & H IRQ and joypad reading enable flags
         if (byte & 0x20)
         {
            if (!PPU.VTimerEnabled)
            {
#ifdef DEBUGGER
               missing.virq = 1;
               missing.virq_pos = PPU.IRQVBeamPos;
#endif
               PPU.VTimerEnabled = TRUE;
               if (PPU.HTimerEnabled)
                  S9xUpdateHTimer();
               else if (PPU.IRQVBeamPos == CPU.V_Counter)
                  S9xSetIRQ(PPU_V_BEAM_IRQ_SOURCE);
            }
         }
         else
            PPU.VTimerEnabled = FALSE;

         if (byte & 0x10)
         {
            if (!PPU.HTimerEnabled)
            {
#ifdef DEBUGGER
               missing.hirq = 1;
               missing.hirq_pos = PPU.IRQHBeamPos;
#endif
               PPU.HTimerEnabled = TRUE;
               S9xUpdateHTimer();
            }
         }
         else
         {
            // No need to check for HTimer being disabled as the scanline
            // event trigger code won't trigger an H-IRQ unless its enabled.
            PPU.HTimerEnabled = FALSE;
            PPU.HTimerPosition = Settings.H_Max + 1;
         }

#ifndef RC_OPTIMIZED
         if (!Settings.DaffyDuck)
            CLEAR_IRQ_SOURCE(PPU_V_BEAM_IRQ_SOURCE | PPU_H_BEAM_IRQ_SOURCE);

         if ((byte & 0x80)
               && !(Memory.FillRAM[0x4200] & 0x80)
               && CPU.V_Counter >= PPU.ScreenHeight + FIRST_VISIBLE_LINE
               && CPU.V_Counter <= PPU.ScreenHeight + (SNESGameFixes.alienVSpredetorFix ? 25 : 15)
               && //jyam 15->25 alien vs predetor
               // Panic Bomberman clears the NMI pending flag @ scanline 230 before enabling
               // NMIs again. The NMI routine crashes the CPU if it is called without the NMI
               // pending flag being set...
               (Memory.FillRAM[0x4210] & 0x80) && !CPU.NMIActive)
         {
            CPU.Flags |= NMI_FLAG;
            CPU.NMIActive = TRUE;
            CPU.NMICycleCount = CPU.NMITriggerPoint;
         }
#endif
         break;
      case 0x4201 :
      // I/O port output
      case 0x4202 :
         // Multiplier (for multply)
         break;
      case 0x4203 :
      {
         // Multiplicand
         uint32 res = Memory.FillRAM[0x4202] * byte;

#if defined FAST_LSB_WORD_ACCESS || defined FAST_ALIGNED_LSB_WORD_ACCESS
         // assume malloc'd memory is 2-byte aligned
         *((uint16 *) &Memory.FillRAM[0x4216]) = res;
#else
         Memory.FillRAM[0x4216] = (uint8) res;
         Memory.FillRAM[0x4217] = (uint8)(res >> 8);
#endif
         break;
      }
      case 0x4204 :
      case 0x4205 :
         // Low and high muliplier (for divide)
         break;
      case 0x4206 :
      {
         // Divisor
#if defined FAST_LSB_WORD_ACCESS || defined FAST_ALIGNED_LSB_WORD_ACCESS
         // assume malloc'd memory is 2-byte aligned
         uint16 a = *((uint16 *) &Memory.FillRAM[0x4204]);
#else
         uint16 a =
            Memory.FillRAM[0x4204] + (Memory.FillRAM[0x4205] << 8);
#endif
         uint16 div = byte ? a / byte : 0xffff;
         uint16 rem = byte ? a % byte : a;

#if defined FAST_LSB_WORD_ACCESS || defined FAST_ALIGNED_LSB_WORD_ACCESS
         // assume malloc'd memory is 2-byte aligned
         *((uint16 *) &Memory.FillRAM[0x4214]) = div;
         *((uint16 *) &Memory.FillRAM[0x4216]) = rem;
#else
         Memory.FillRAM[0x4214] = (uint8) div;
         Memory.FillRAM[0x4215] = div >> 8;
         Memory.FillRAM[0x4216] = (uint8) rem;
         Memory.FillRAM[0x4217] = rem >> 8;
#endif
         break;
      }
      case 0x4207 :
         d = PPU.IRQHBeamPos;
         PPU.IRQHBeamPos = (PPU.IRQHBeamPos & 0xFF00) | byte;

         if (PPU.HTimerEnabled && PPU.IRQHBeamPos != d)
            S9xUpdateHTimer();
         break;

      case 0x4208 :
         d = PPU.IRQHBeamPos;
         PPU.IRQHBeamPos = (PPU.IRQHBeamPos & 0xFF) | ((byte & 1) << 8);

         if (PPU.HTimerEnabled && PPU.IRQHBeamPos != d)
            S9xUpdateHTimer();

         break;

      case 0x4209 :
         d = PPU.IRQVBeamPos;
         PPU.IRQVBeamPos = (PPU.IRQVBeamPos & 0xFF00) | byte;
#ifdef DEBUGGER
         missing.virq_pos = PPU.IRQVBeamPos;
#endif
         if (PPU.VTimerEnabled && PPU.IRQVBeamPos != d)
         {
            if (PPU.HTimerEnabled)
               S9xUpdateHTimer();
            else
            {
               if (PPU.IRQVBeamPos == CPU.V_Counter)
                  S9xSetIRQ(PPU_V_BEAM_IRQ_SOURCE);
            }
         }
         break;

      case 0x420A :
         d = PPU.IRQVBeamPos;
         PPU.IRQVBeamPos = (PPU.IRQVBeamPos & 0xFF) | ((byte & 1) << 8);
#ifdef DEBUGGER
         missing.virq_pos = PPU.IRQVBeamPos;
#endif
         if (PPU.VTimerEnabled && PPU.IRQVBeamPos != d)
         {
            if (PPU.HTimerEnabled)
               S9xUpdateHTimer();
            else
            {
               if (PPU.IRQVBeamPos == CPU.V_Counter)
                  S9xSetIRQ(PPU_V_BEAM_IRQ_SOURCE);
            }
         }
         break;

      case 0x420B :
#ifdef DEBUGGER
         missing.dma_this_frame = byte;
         missing.dma_channels = byte;
#endif
         if ((byte & 0x01) != 0)
            S9xDoDMA(0);
         if ((byte & 0x02) != 0)
            S9xDoDMA(1);
         if ((byte & 0x04) != 0)
            S9xDoDMA(2);
         if ((byte & 0x08) != 0)
            S9xDoDMA(3);
         if ((byte & 0x10) != 0)
            S9xDoDMA(4);
         if ((byte & 0x20) != 0)
            S9xDoDMA(5);
         if ((byte & 0x40) != 0)
            S9xDoDMA(6);
         if ((byte & 0x80) != 0)
            S9xDoDMA(7);
         break;
      case 0x420C :
#ifdef DEBUGGER
         missing.hdma_this_frame |= byte;
         missing.hdma_channels |= byte;
#endif
         //if (Settings.DisableHDMA)
         // byte = 0;
         Memory.FillRAM[0x420c] = byte;
         IPPU.HDMA = byte;
         break;

      case 0x420d :
         // Cycle speed 0 - 2.68Mhz, 1 - 3.58Mhz (banks 0x80 +)
         if ((byte & 1) != (Memory.FillRAM[0x420d] & 1))
         {
            if (byte & 1)
            {
               CPU.FastROMSpeed = ONE_CYCLE;
#ifdef DEBUGGER
               missing.fast_rom = 1;
#endif
            }
            else
               CPU.FastROMSpeed = SLOW_ONE_CYCLE;

            FixROMSpeed();
         }
      /* FALL */
      case 0x420e :
      case 0x420f :
         // --->>> Unknown
         break;
      case 0x4210 :
         // NMI ocurred flag (reset on read or write)
         Memory.FillRAM[0x4210] = 0;
         return;
      case 0x4211 :
         // IRQ ocurred flag (reset on read or write)
         CLEAR_IRQ_SOURCE(PPU_V_BEAM_IRQ_SOURCE | PPU_H_BEAM_IRQ_SOURCE);
         break;
      case 0x4212 :
      // v-blank, h-blank and joypad being scanned flags (read-only)
      case 0x4213 :
      // I/O Port (read-only)
      case 0x4214 :
      case 0x4215 :
      // Quotent of divide (read-only)
      case 0x4216 :
      case 0x4217 :
         // Multiply product (read-only)
         return;
      case 0x4218 :
      case 0x4219 :
      case 0x421a :
      case 0x421b :
      case 0x421c :
      case 0x421d :
      case 0x421e :
      case 0x421f :
         // Joypad values (read-only)
         return;

      case 0x4300 :
      case 0x4310 :
      case 0x4320 :
      case 0x4330 :
      case 0x4340 :
      case 0x4350 :
      case 0x4360 :
      case 0x4370 :
         d = (Address >> 4) & 0x7;
         DMA[d].TransferDirection = (byte & 128) != 0 ? 1 : 0;
         DMA[d].HDMAIndirectAddressing = (byte & 64) != 0 ? 1 : 0;
         DMA[d].AAddressDecrement = (byte & 16) != 0 ? 1 : 0;
         DMA[d].AAddressFixed = (byte & 8) != 0 ? 1 : 0;
         DMA[d].TransferMode = (byte & 7);
         break;

      case 0x4301 :
      case 0x4311 :
      case 0x4321 :
      case 0x4331 :
      case 0x4341 :
      case 0x4351 :
      case 0x4361 :
      case 0x4371 :
         DMA[((Address >> 4) & 0x7)].BAddress = byte;
         break;

      case 0x4302 :
      case 0x4312 :
      case 0x4322 :
      case 0x4332 :
      case 0x4342 :
      case 0x4352 :
      case 0x4362 :
      case 0x4372 :
         d = (Address >> 4) & 0x7;
         DMA[d].AAddress &= 0xFF00;
         DMA[d].AAddress |= byte;
         break;

      case 0x4303 :
      case 0x4313 :
      case 0x4323 :
      case 0x4333 :
      case 0x4343 :
      case 0x4353 :
      case 0x4363 :
      case 0x4373 :
         d = (Address >> 4) & 0x7;
         DMA[d].AAddress &= 0xFF;
         DMA[d].AAddress |= byte << 8;
         break;

      case 0x4304 :
      case 0x4314 :
      case 0x4324 :
      case 0x4334 :
      case 0x4344 :
      case 0x4354 :
      case 0x4364 :
      case 0x4374 :
         DMA[((Address >> 4) & 0x7)].ABank = byte;
         HDMAMemPointers[((Address >> 4) & 0x7)] = NULL;
         break;

      case 0x4305 :
      case 0x4315 :
      case 0x4325 :
      case 0x4335 :
      case 0x4345 :
      case 0x4355 :
      case 0x4365 :
      case 0x4375 :
         d = (Address >> 4) & 0x7;
         DMA[d].TransferBytes &= 0xFF00;
         DMA[d].TransferBytes |= byte;
         DMA[d].IndirectAddress &= 0xff00;
         DMA[d].IndirectAddress |= byte;
         HDMAMemPointers[d] = NULL;
         break;

      case 0x4306 :
      case 0x4316 :
      case 0x4326 :
      case 0x4336 :
      case 0x4346 :
      case 0x4356 :
      case 0x4366 :
      case 0x4376 :
         d = (Address >> 4) & 0x7;
         DMA[d].TransferBytes &= 0xFF;
         DMA[d].TransferBytes |= byte << 8;
         DMA[d].IndirectAddress &= 0xff;
         DMA[d].IndirectAddress |= byte << 8;
         HDMAMemPointers[d] = NULL;
         break;

      case 0x4307 :
      case 0x4317 :
      case 0x4327 :
      case 0x4337 :
      case 0x4347 :
      case 0x4357 :
      case 0x4367 :
      case 0x4377 :
         DMA[d = ((Address >> 4) & 0x7)].IndirectBank = byte;
         HDMAMemPointers[d] = NULL;
         break;

      case 0x4308 :
      case 0x4318 :
      case 0x4328 :
      case 0x4338 :
      case 0x4348 :
      case 0x4358 :
      case 0x4368 :
      case 0x4378 :
         d = (Address >> 4) & 7;
         DMA[d].Address &= 0xff00;
         DMA[d].Address |= byte;
         HDMAMemPointers[d] = NULL;
         break;

      case 0x4309 :
      case 0x4319 :
      case 0x4329 :
      case 0x4339 :
      case 0x4349 :
      case 0x4359 :
      case 0x4369 :
      case 0x4379 :
         d = (Address >> 4) & 0x7;
         DMA[d].Address &= 0xff;
         DMA[d].Address |= byte << 8;
         HDMAMemPointers[d] = NULL;
         break;

      case 0x430A :
      case 0x431A :
      case 0x432A :
      case 0x433A :
      case 0x434A :
      case 0x435A :
      case 0x436A :
      case 0x437A :
         d = (Address >> 4) & 0x7;
         DMA[d].LineCount = byte & 0x7f;
         DMA[d].Repeat = !(byte & 0x80);
         break;

      case 0x430F:
      case 0x431F:
      case 0x432F:
      case 0x433F:
      case 0x434F:
      case 0x435F:
      case 0x436F:
      case 0x437F:
         Address &= ~4; // Convert 43xF to 43xB
      /* fall through */
      case 0x430B:
      case 0x431B:
      case 0x432B:
      case 0x433B:
      case 0x434B:
      case 0x435B:
      case 0x436B:
      case 0x437B:

         // Unknown, but they seem to be RAM-ish
         break;
      case 0x4800 :
      case 0x4801 :
      case 0x4802 :
      case 0x4803 :
         //printf ("%02x->%04x\n", byte, Address);
         break;

      case 0x4804 :
      case 0x4805 :
      case 0x4806 :
      case 0x4807 :
         //printf ("%02x->%04x\n", byte, Address);

         S9xSetSDD1MemoryMap(Address - 0x4804, byte & 7);
         break;
      default :
#ifdef DEBUGGER
         missing.unknowncpu_write = Address;
         if (Settings.TraceUnknownRegisters)
         {
            sprintf(
               String,
               "Unknown register write: $%02X->$%04X\n",
               byte,
               Address);
            S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
         }
#endif
         break;
      }
   Memory.FillRAM[Address] = byte;
}

/**********************************************************************************************/
/* S9xGetCPU()                                                                                   */
/* This function retrieves a CPU/DMA Register                                                 */
/**********************************************************************************************/
uint8 S9xGetCPU(uint16 Address)
{
   uint8 byte;
   if (Address >= 0x4800 && Address <= 0x4807 && Settings.SDD1)
      return Memory.FillRAM[Address];

   if (Address < 0x4200)
   {
#ifdef VAR_CYCLES
      CPU.Cycles += ONE_CYCLE;
#endif
      switch (Address)
      {
      // Secret of the Evermore
      case 0x4000 :
      case 0x4001 :
         return (0x40);

      case 0x4016 :
      {
         if (Memory.FillRAM[0x4016] & 1)
            return (0);

         if (PPU.Joypad1ButtonReadPos >= 16) // Joypad 1 is enabled
            return 1;

         byte = IPPU.Joypads[0] >> (PPU.Joypad1ButtonReadPos ^ 15);
         PPU.Joypad1ButtonReadPos++;
         return (byte & 1);
      }
      case 0x4017 :
      {
         if (Memory.FillRAM[0x4016] & 1)
         {
            // MultiPlayer5 adaptor is only allowed to be plugged into port 2
            switch (IPPU.Controller)
            {
            case SNES_MULTIPLAYER5 :
               return (2);

            case SNES_MOUSE :
               break;
            }
            return (0x00);
         }

         if (IPPU.Controller == SNES_MULTIPLAYER5)
         {
            if (Memory.FillRAM[0x4201] & 0x80)
            {
               byte =
                  ((IPPU.Joypads[1]
                    >> (PPU.Joypad2ButtonReadPos ^ 15))
                   & 1)
                  | (((IPPU.Joypads[2]
                       >> (PPU.Joypad2ButtonReadPos ^ 15))
                      & 1)
                     << 1);
               PPU.Joypad2ButtonReadPos++;
               return (byte);
            }
            else
            {
               byte =
                  ((IPPU.Joypads[3]
                    >> (PPU.Joypad3ButtonReadPos ^ 15))
                   & 1)
                  | (((IPPU.Joypads[4]
                       >> (PPU.Joypad3ButtonReadPos ^ 15))
                      & 1)
                     << 1);
               PPU.Joypad3ButtonReadPos++;
               return (byte);
            }
         }
         
         if (PPU.Joypad2ButtonReadPos >= 16) // Joypad 2 is enabled
            return 1;

         return (IPPU.Joypads[1] >> (PPU.Joypad2ButtonReadPos++ ^ 15)) & 1;
      }
      default :
#ifdef DEBUGGER
         missing.unknowncpu_read = Address;
         if (Settings.TraceUnknownRegisters)
         {
            sprintf(String, "Unknown register read: $%04X\n", Address);
            S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
         }
#endif
         break;
      }
      return (Memory.FillRAM[Address]);
   }
   else
      switch (Address)
      {
      // BS Dynami Tracer! needs to be able to check if NMIs are enabled
      // already, otherwise the game locks up.
      case 0x4200 :
         // NMI, h & v timers and joypad reading enable
         if (SNESGameFixes.Old_Read0x4200)
         {
#ifdef CPU_SHUTDOWN
            CPU.WaitAddress = CPU.PCAtOpcodeStart;
#endif
            return (REGISTER_4212());
         }
      case 0x4201 :
      // I/O port (output - write only?)
      case 0x4202 :
      case 0x4203 :
      // Multiplier and multiplicand (write)
      case 0x4204 :
      case 0x4205 :
      case 0x4206 :
         // Divisor and dividend (write)
         return (Memory.FillRAM[Address]);
      case 0x4207 :
         return (uint8)(PPU.IRQHBeamPos);
      case 0x4208 :
         return (PPU.IRQHBeamPos >> 8);
      case 0x4209 :
         return (uint8)(PPU.IRQVBeamPos);
      case 0x420a :
         return (PPU.IRQVBeamPos >> 8);
      case 0x420b :
         // General purpose DMA enable
         // Super Formation Soccer 95 della Serie A UCC Xaqua requires this
         // register should not always return zero.
         // .. But Aero 2 waits until this register goes zero..
         // Just keep toggling the value for now in the hope that it breaks
         // the game out of its wait loop...
         Memory.FillRAM[0x420b] = !Memory.FillRAM[0x420b];
         return (Memory.FillRAM[0x420b]);
      case 0x420c :
         // H-DMA enable
         return (IPPU.HDMA);
      case 0x420d :
         // Cycle speed 0 - 2.68Mhz, 1 - 3.58Mhz (banks 0x80 +)
         return (Memory.FillRAM[Address]);
      case 0x420e :
      case 0x420f :
         // --->>> Unknown
         return (Memory.FillRAM[Address]);
      case 0x4210 :
#ifdef CPU_SHUTDOWN
         CPU.WaitAddress = CPU.PCAtOpcodeStart;
#endif
         byte = Memory.FillRAM[0x4210];
         Memory.FillRAM[0x4210] = 0;
         return (byte);
      case 0x4211 :
         byte =
            (CPU.IRQActive
             & (PPU_V_BEAM_IRQ_SOURCE | PPU_H_BEAM_IRQ_SOURCE))
            ? 0x80
            : 0;
         // Super Robot Wars Ex ROM bug requires this.
         byte |= CPU.Cycles >= Settings.HBlankStart ? 0x40 : 0;
         CLEAR_IRQ_SOURCE(PPU_V_BEAM_IRQ_SOURCE | PPU_H_BEAM_IRQ_SOURCE);
         return (byte);
      case 0x4212 :
         // V-blank, h-blank and joypads being read flags (read-only)
#ifdef CPU_SHUTDOWN
         CPU.WaitAddress = CPU.PCAtOpcodeStart;
#endif
         return (REGISTER_4212());
      case 0x4213 :
      // I/O port input
      case 0x4214 :
      case 0x4215 :
      // Quotient of divide result
      case 0x4216 :
      case 0x4217 :
         // Multiplcation result (for multiply) or remainder of
         // divison.
         return (Memory.FillRAM[Address]);
      case 0x4218 :
      case 0x4219 :
      case 0x421a :
      case 0x421b :
      case 0x421c :
      case 0x421d :
      case 0x421e :
      case 0x421f :
         // Joypads 1-4 button and direction state.
         return (Memory.FillRAM[Address]);

      case 0x4300 :
      case 0x4310 :
      case 0x4320 :
      case 0x4330 :
      case 0x4340 :
      case 0x4350 :
      case 0x4360 :
      case 0x4370 :
         // DMA direction, address type, fixed flag,
         return (Memory.FillRAM[Address]);

      case 0x4301 :
      case 0x4311 :
      case 0x4321 :
      case 0x4331 :
      case 0x4341 :
      case 0x4351 :
      case 0x4361 :
      case 0x4371 :
         return (Memory.FillRAM[Address]);

      case 0x4302 :
      case 0x4312 :
      case 0x4322 :
      case 0x4332 :
      case 0x4342 :
      case 0x4352 :
      case 0x4362 :
      case 0x4372 :
         return (Memory.FillRAM[Address]);

      case 0x4303 :
      case 0x4313 :
      case 0x4323 :
      case 0x4333 :
      case 0x4343 :
      case 0x4353 :
      case 0x4363 :
      case 0x4373 :
         return (Memory.FillRAM[Address]);

      case 0x4304 :
      case 0x4314 :
      case 0x4324 :
      case 0x4334 :
      case 0x4344 :
      case 0x4354 :
      case 0x4364 :
      case 0x4374 :
         return (Memory.FillRAM[Address]);

      case 0x4305 :
      case 0x4315 :
      case 0x4325 :
      case 0x4335 :
      case 0x4345 :
      case 0x4355 :
      case 0x4365 :
      case 0x4375 :
         return (Memory.FillRAM[Address]);

      case 0x4306 :
      case 0x4316 :
      case 0x4326 :
      case 0x4336 :
      case 0x4346 :
      case 0x4356 :
      case 0x4366 :
      case 0x4376 :
         return (Memory.FillRAM[Address]);

      case 0x4307 :
      case 0x4317 :
      case 0x4327 :
      case 0x4337 :
      case 0x4347 :
      case 0x4357 :
      case 0x4367 :
      case 0x4377 :
         return (DMA[(Address >> 4) & 7].IndirectBank);

      case 0x4308 :
      case 0x4318 :
      case 0x4328 :
      case 0x4338 :
      case 0x4348 :
      case 0x4358 :
      case 0x4368 :
      case 0x4378 :
         return (Memory.FillRAM[Address]);

      case 0x4309 :
      case 0x4319 :
      case 0x4329 :
      case 0x4339 :
      case 0x4349 :
      case 0x4359 :
      case 0x4369 :
      case 0x4379 :
         return (Memory.FillRAM[Address]);

      case 0x430A :
      case 0x431A :
      case 0x432A :
      case 0x433A :
      case 0x434A :
      case 0x435A :
      case 0x436A :
      case 0x437A :
      {
         int d = (Address & 0x70) >> 4;
         if (IPPU.HDMA & (1 << d))
            return (DMA[d].LineCount);
         return (Memory.FillRAM[Address]);
      }
      case 0x430F:
      case 0x431F:
      case 0x432F:
      case 0x433F:
      case 0x434F:
      case 0x435F:
      case 0x436F:
      case 0x437F:
         Address &= ~4; // Convert 43xF to 43xB
      /* fall through */
      case 0x430B:
      case 0x431B:
      case 0x432B:
      case 0x433B:
      case 0x434B:
      case 0x435B:
      case 0x436B:
      case 0x437B:

         // Unknown, but they seem to be RAM-ish
         return (Memory.FillRAM[Address]);
      default :
#ifdef DEBUGGER
         missing.unknowncpu_read = Address;
         if (Settings.TraceUnknownRegisters)
         {
            sprintf(String, "Unknown register read: $%04X\n", Address);
            S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
         }

#endif
         break;
      }
   return (Memory.FillRAM[Address]);
}

void S9xResetPPU()
{
   PPU.BGMode = 0;
   PPU.BG3Priority = 0;
   PPU.Brightness = 0;
   PPU.VMA.High = 0;
   PPU.VMA.Increment = 1;
   PPU.VMA.Address = 0;
   PPU.VMA.FullGraphicCount = 0;
   PPU.VMA.Shift = 0;

   uint8 B;
   for (B = 0; B != 4; B++)
   {
      PPU.BG[B].SCBase = 0;
      PPU.BG[B].VOffset = 0;
      PPU.BG[B].HOffset = 0;
      PPU.BG[B].BGSize = 0;
      PPU.BG[B].NameBase = 0;
      PPU.BG[B].SCSize = 0;

      PPU.ClipCounts[B] = 0;
      PPU.ClipWindowOverlapLogic[B] = CLIP_OR;
      PPU.ClipWindow1Enable[B] = FALSE;
      PPU.ClipWindow2Enable[B] = FALSE;
      PPU.ClipWindow1Inside[B] = TRUE;
      PPU.ClipWindow2Inside[B] = TRUE;
   }

   PPU.ClipCounts[4] = 0;
   PPU.ClipCounts[5] = 0;
   PPU.ClipWindowOverlapLogic[4] = PPU.ClipWindowOverlapLogic[5] = CLIP_OR;
   PPU.ClipWindow1Enable[4] = PPU.ClipWindow1Enable[5] = FALSE;
   PPU.ClipWindow2Enable[4] = PPU.ClipWindow2Enable[5] = FALSE;
   PPU.ClipWindow1Inside[4] = PPU.ClipWindow1Inside[5] = TRUE;
   PPU.ClipWindow2Inside[4] = PPU.ClipWindow2Inside[5] = TRUE;

   PPU.CGFLIP = 0;
   unsigned int c;
   for (c = 0; c < 256; c++)
   {
      IPPU.Red[c] = (c & 7) << 2;
      IPPU.Green[c] = ((c >> 3) & 7) << 2;
      IPPU.Blue[c] = ((c >> 6) & 2) << 3;
      PPU.CGDATA[c] =
         IPPU.Red[c] | (IPPU.Green[c] << 5) | (IPPU.Blue[c] << 10);
   }

   PPU.FirstSprite = 0;
   PPU.LastSprite = 127;
   int Sprite;
   for (Sprite = 0; Sprite < 128; Sprite++)
   {
      PPU.OBJ[Sprite].HPos = 0;
      PPU.OBJ[Sprite].VPos = 0;
      PPU.OBJ[Sprite].VFlip = 0;
      PPU.OBJ[Sprite].HFlip = 0;
      PPU.OBJ[Sprite].Priority = 0;
      PPU.OBJ[Sprite].Palette = 0;
      PPU.OBJ[Sprite].Name = 0;
      PPU.OBJ[Sprite].Size = 0;
   }
   PPU.OAMPriorityRotation = 0;
   PPU.OAMWriteRegister = 0;

   PPU.OAMFlip = 0;
   PPU.OAMTileAddress = 0;
   PPU.OAMAddr = 0;
   PPU.IRQVBeamPos = 0;
   PPU.IRQHBeamPos = 0;
   PPU.VBeamPosLatched = 0;
   PPU.HBeamPosLatched = 0;

   PPU.HBeamFlip = 0;
   PPU.VBeamFlip = 0;
   PPU.HVBeamCounterLatched = 0;

   PPU.MatrixA = PPU.MatrixB = PPU.MatrixC = PPU.MatrixD = 0;
   PPU.CentreX = PPU.CentreY = 0;
   PPU.Joypad1ButtonReadPos = 0;
   PPU.Joypad2ButtonReadPos = 0;
   PPU.Joypad3ButtonReadPos = 0;

   PPU.CGADD = 0;
   PPU.FixedColourRed = PPU.FixedColourGreen = PPU.FixedColourBlue = 0;
   PPU.SavedOAMAddr = 0;
   PPU.SavedOAMAddr2 = 0;
   PPU.ScreenHeight = SNES_HEIGHT;
   PPU.WRAM = 0;
   PPU.BG_Forced = 0;
   PPU.ForcedBlanking = TRUE;
   PPU.OBJThroughMain = FALSE;
   PPU.OBJThroughSub = FALSE;
   PPU.OBJSizeSelect = 0;
   PPU.OBJNameSelect = 0;
   PPU.OBJNameBase = 0;
   PPU.OBJAddition = FALSE;
   PPU.OAMReadFlip = 0;
   PPU.BGnxOFSbyte = 0;
   memset(PPU.OAMData, 0, 512 + 32);

   PPU.VTimerEnabled = FALSE;
   PPU.HTimerEnabled = FALSE;
   PPU.HTimerPosition = Settings.H_Max + 1;
   PPU.Mosaic = 0;
   PPU.BGMosaic[0] = PPU.BGMosaic[1] = FALSE;
   PPU.BGMosaic[2] = PPU.BGMosaic[3] = FALSE;
   PPU.Mode7HFlip = FALSE;
   PPU.Mode7VFlip = FALSE;
   PPU.Mode7Repeat = 0;
   PPU.Window1Left = 1;
   PPU.Window1Right = 0;
   PPU.Window2Left = 1;
   PPU.Window2Right = 0;
   PPU.RecomputeClipWindows = TRUE;
   PPU.CGFLIPRead = 0;
   PPU.Need16x8Mulitply = FALSE;
   PPU.MouseSpeed[0] = PPU.MouseSpeed[1] = 0;

   IPPU.ColorsChanged = TRUE;
   IPPU.HDMA = 0;
   IPPU.HDMAStarted = FALSE;
   IPPU.MaxBrightness = 0;
   IPPU.LatchedBlanking = 0;
   IPPU.OBJChanged = TRUE;
   IPPU.RenderThisFrame = TRUE;
   IPPU.DirectColourMapsNeedRebuild = TRUE;
   IPPU.FrameCount = 0;
   IPPU.RenderedFramesCount = 0;
   IPPU.DisplayedRenderedFrameCount = 0;
   IPPU.SkippedFrames = 0;
   IPPU.FrameSkip = 0;
   memset(IPPU.TileCached[TILE_2BIT], 0, MAX_2BIT_TILES);
   memset(IPPU.TileCached[TILE_4BIT], 0, MAX_4BIT_TILES);
   memset(IPPU.TileCached[TILE_8BIT], 0, MAX_8BIT_TILES);
   IPPU.FirstVRAMRead = FALSE;
   IPPU.LatchedInterlace = FALSE;
   IPPU.DoubleWidthPixels = FALSE;
   IPPU.RenderedScreenWidth = SNES_WIDTH;
   IPPU.RenderedScreenHeight = SNES_HEIGHT;
   IPPU.XB = NULL;
   for (c = 0; c < 256; c++)
      IPPU.ScreenColors[c] = c;
   S9xFixColourBrightness();
   IPPU.PreviousLine = IPPU.CurrentLine = 0;
   IPPU.Joypads[0] = IPPU.Joypads[1] = IPPU.Joypads[2] = 0;
   IPPU.Joypads[3] = IPPU.Joypads[4] = 0;
   IPPU.SuperScope = 0;
   IPPU.Mouse[0] = IPPU.Mouse[1] = 0;
   IPPU.PrevMouseX[0] = IPPU.PrevMouseX[1] = 256 / 2;
   IPPU.PrevMouseY[0] = IPPU.PrevMouseY[1] = 224 / 2;

   if (Settings.ControllerOption == 0)
      IPPU.Controller = SNES_MAX_CONTROLLER_OPTIONS - 1;
   else
      IPPU.Controller = Settings.ControllerOption - 1;
   S9xNextController();

   for (c = 0; c < 2; c++)
      memset(& IPPU.Clip[c], 0, sizeof(ClipData));

   if (Settings.MouseMaster)
   {
      S9xProcessMouse(0);
      S9xProcessMouse(1);
   }
   for (c = 0; c < 0x8000; c += 0x100)
      memset(& Memory.FillRAM[c], c >> 8, 0x100);

   memset(& Memory.FillRAM[0x2100], 0, 0x100);
   memset(& Memory.FillRAM[0x4200], 0, 0x100);
   memset(& Memory.FillRAM[0x4000], 0, 0x100);
   // For BS Suttehakkun 2...
   memset(& Memory.FillRAM[0x1000], 0, 0x1000);
   Memory.FillRAM[0x4201] = Memory.FillRAM[0x4213] = 0xFF;

   PPU.BG[0].OffsetsChanged = 0;
   PPU.BG[1].OffsetsChanged = 0;
   PPU.BG[2].OffsetsChanged = 0;
   PPU.BG[3].OffsetsChanged = 0;
   ROpCount = 0;
   memset(&rops, 0, MAX_ROPS);
   GFX.r212c_s = 0;
   GFX.r212d_s = 0;
   GFX.r212e_s = 0;
   GFX.r212f_s = 0;
   GFX.r2130_s = 0;
   GFX.r2131_s = 0;
}

void S9xProcessMouse(int which1)
{
   int x, y;
   uint32 buttons;

   if (IPPU.Controller == SNES_MOUSE && S9xReadMousePosition(which1, &x, &y, &buttons))
   {
      int delta_x, delta_y;
#define MOUSE_SIGNATURE 0x1
      IPPU.Mouse[which1] =
         MOUSE_SIGNATURE
         | (PPU.MouseSpeed[which1] << 4)
         | ((buttons & 1) << 6)
         | ((buttons & 2) << 6);

      delta_x = x - IPPU.PrevMouseX[which1];
      delta_y = y - IPPU.PrevMouseY[which1];

      if (delta_x > 63)
      {
         delta_x = 63;
         IPPU.PrevMouseX[which1] += 63;
      }
      else if (delta_x < -63)
      {
         delta_x = -63;
         IPPU.PrevMouseX[which1] -= 63;
      }
      else
         IPPU.PrevMouseX[which1] = x;

      if (delta_y > 63)
      {
         delta_y = 63;
         IPPU.PrevMouseY[which1] += 63;
      }
      else if (delta_y < -63)
      {
         delta_y = -63;
         IPPU.PrevMouseY[which1] -= 63;
      }
      else
         IPPU.PrevMouseY[which1] = y;

      if (delta_x < 0)
      {
         delta_x = -delta_x;
         IPPU.Mouse[which1] |= (delta_x | 0x80) << 16;
      }
      else
         IPPU.Mouse[which1] |= delta_x << 16;

      if (delta_y < 0)
      {
         delta_y = -delta_y;
         IPPU.Mouse[which1] |= (delta_y | 0x80) << 24;
      }
      else
         IPPU.Mouse[which1] |= delta_y << 24;

      IPPU.Joypads[1] = IPPU.Mouse [which1];
   }
}

void ProcessSuperScope()
{
   int x, y;
   uint32 buttons;

   if (IPPU.Controller == SNES_SUPERSCOPE
         && S9xReadSuperScopePosition(&x, &y, &buttons))
   {
#define SUPERSCOPE_SIGNATURE 0x00ff
      uint32 scope;

      scope =
         SUPERSCOPE_SIGNATURE
         | ((buttons & 1) << (7 + 8))
         | ((buttons & 2) << (5 + 8))
         | ((buttons & 4) << (3 + 8))
         | ((buttons & 8) << (1 + 8));
      if (x > 255)
         x = 255;
      if (x < 0)
         x = 0;
      if (y > PPU.ScreenHeight - 1)
         y = PPU.ScreenHeight - 1;
      if (y < 0)
         y = 0;

      PPU.VBeamPosLatched = (uint16)(y + 1);
      PPU.HBeamPosLatched = (uint16) x;
      PPU.HVBeamCounterLatched = TRUE;
      Memory.FillRAM[0x213F] |= 0x40;
      IPPU.Joypads[1] = scope;
   }
}

void S9xNextController()
{
   switch (IPPU.Controller)
   {
   case SNES_MULTIPLAYER5 :
      IPPU.Controller = SNES_JOYPAD;
      break;
   case SNES_JOYPAD :
      if (Settings.MouseMaster)
      {
         IPPU.Controller = SNES_MOUSE;
         break;
      }
   case SNES_MOUSE :
      if (Settings.SuperScopeMaster)
      {
         IPPU.Controller = SNES_SUPERSCOPE;
         break;
      }
   case SNES_SUPERSCOPE :
      if (Settings.MultiPlayer5Master)
      {
         IPPU.Controller = SNES_MULTIPLAYER5;
         break;
      }
   default :
      IPPU.Controller = SNES_JOYPAD;
      break;
   }
}

void S9xUpdateJoypads()
{
#if defined (__WIZ__)
   IPPU.Joypads[0] = S9xReadJoypad(0);

   if (IPPU.Joypads[0] & SNES_LEFT_MASK)
      IPPU.Joypads[0] &= ~SNES_RIGHT_MASK;
   if (IPPU.Joypads[0] & SNES_UP_MASK)
      IPPU.Joypads[0] &= ~SNES_DOWN_MASK;

   if (Memory.FillRAM [0x4200] & 1)
   {
      PPU.Joypad1ButtonReadPos = 16;

      Memory.FillRAM [0x4218] = (uint8) IPPU.Joypads[0];
      Memory.FillRAM [0x4219] = (uint8)(IPPU.Joypads[0] >> 8);
      if (Memory.FillRAM [0x4201] & 0x80)
      {
         Memory.FillRAM [0x421c] = (uint8) IPPU.Joypads[0];
         Memory.FillRAM [0x421d] = (uint8)(IPPU.Joypads[0] >> 8);
      }
   }
#else
   int i;

   for (i = 0; i < 5; i++)
   {
      IPPU.Joypads[i] = S9xReadJoypad(i);
      if (IPPU.Joypads[i] & SNES_LEFT_MASK)
         IPPU.Joypads[i] &= ~SNES_RIGHT_MASK;
      if (IPPU.Joypads[i] & SNES_UP_MASK)
         IPPU.Joypads[i] &= ~SNES_DOWN_MASK;
   }

   if (IPPU.Controller == SNES_JOYPAD
         || IPPU.Controller == SNES_MULTIPLAYER5)
   {
      for (i = 0; i < 5; i++)
      {
         if (IPPU.Joypads[i])
            IPPU.Joypads[i] |= 0xffff0000;
      }
   }

   // Read mouse position if enabled
   if (Settings.MouseMaster)
   {
      for (i = 0; i < 2; i++)
         S9xProcessMouse(i);
   }

   // Read SuperScope if enabled
   if (Settings.SuperScopeMaster)
      ProcessSuperScope();

   if (Memory.FillRAM[0x4200] & 1)
   {
      PPU.Joypad1ButtonReadPos = 16;
      if (Memory.FillRAM[0x4201] & 0x80)
      {
         PPU.Joypad2ButtonReadPos = 16;
         PPU.Joypad3ButtonReadPos = 0;
      }
      else
      {
         PPU.Joypad2ButtonReadPos = 0;
         PPU.Joypad3ButtonReadPos = 16;
      }

      Memory.FillRAM[0x4218] = (uint8) IPPU.Joypads[0];
      Memory.FillRAM[0x4219] = (uint8)(IPPU.Joypads[0] >> 8);
      Memory.FillRAM[0x421a] = (uint8) IPPU.Joypads[1];
      Memory.FillRAM[0x421b] = (uint8)(IPPU.Joypads[1] >> 8);
      if (Memory.FillRAM[0x4201] & 0x80)
      {
         Memory.FillRAM[0x421c] = (uint8) IPPU.Joypads[0];
         Memory.FillRAM[0x421d] = (uint8)(IPPU.Joypads[0] >> 8);
         Memory.FillRAM[0x421e] = (uint8) IPPU.Joypads[2];
         Memory.FillRAM[0x421f] = (uint8)(IPPU.Joypads[2] >> 8);
      }
      else
      {
         Memory.FillRAM[0x421c] = (uint8) IPPU.Joypads[3];
         Memory.FillRAM[0x421d] = (uint8)(IPPU.Joypads[3] >> 8);
         Memory.FillRAM[0x421e] = (uint8) IPPU.Joypads[4];
         Memory.FillRAM[0x421f] = (uint8)(IPPU.Joypads[4] >> 8);
      }
   }
#endif
}

void S9xSuperFXExec()
{
   if ((Memory.FillRAM[0x3000 + GSU_SFR] & FLG_G)
         && (Memory.FillRAM[0x3000 + GSU_SCMR] & 0x18) == 0x18)
   {
      if (!Settings.WinterGold || Settings.StarfoxHack)
         FxEmulate(~0);
      else FxEmulate((Memory.FillRAM[0x3000 + GSU_CLSR] & 1) ? 700 : 350);
      int GSUStatus = Memory.FillRAM[0x3000
                                     + GSU_SFR] | (Memory.FillRAM[0x3000 + GSU_SFR + 1] << 8);
      if ((GSUStatus & (FLG_G | FLG_IRQ)) == FLG_IRQ)
      {
         // Trigger a GSU IRQ.
         S9xSetIRQ(GSU_IRQ_SOURCE);
      }
   }
}

