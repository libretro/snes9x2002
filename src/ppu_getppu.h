static uint8 GetPPU_2102(uint16 Address)
{
   return (uint8)(PPU.OAMAddr);
}

static uint8 GetPPU_2103(uint16 Address)
{
   return (((PPU.OAMAddr >> 8) & 1) | (PPU.OAMPriorityRotation << 7));
}

static uint8 GetPPU_RAM(uint16 Address)
{
   return (Memory.FillRAM[Address]);
}

static uint8 GetPPU_2116(uint16 Address)
{
   return (uint8)(PPU.VMA.Address);
}

static uint8 GetPPU_2117(uint16 Address)
{
   return (PPU.VMA.Address >> 8);
}

static uint8 GetPPU_2121(uint16 Address)
{
   return (PPU.CGADD);
}

static uint8 GetPPU_213x(uint16 Address)
{
   if (PPU.Need16x8Mulitply)
   {
      int32 r = (int32) PPU.MatrixA * (int32)(PPU.MatrixB >> 8);

      Memory.FillRAM[0x2134] = (uint8) r;
      Memory.FillRAM[0x2135] = (uint8)(r >> 8);
      Memory.FillRAM[0x2136] = (uint8)(r >> 16);
      PPU.Need16x8Mulitply = FALSE;
   }
   return (Memory.FillRAM[Address]);
}

static uint8 GetPPU_2137(uint16 Address)
{
#ifdef DEBUGGER
   missing.h_v_latch = 1;
#endif
#if 0
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = CPU.PCAtOpcodeStart;
#endif
#endif
   PPU.HVBeamCounterLatched = 1;
   PPU.VBeamPosLatched = (uint16)
                         CPU.V_Counter;
   PPU.HBeamPosLatched = (uint16)((CPU.Cycles * SNES_HCOUNTER_MAX) / Settings.H_Max);

   // Causes screen flicker for Yoshi's Island if uncommented
   //CLEAR_IRQ_SOURCE (PPU_V_BEAM_IRQ_SOURCE | PPU_H_BEAM_IRQ_SOURCE);

   if (SNESGameFixes.NeedInit0x2137)
      PPU.VBeamFlip = 0; //jyam sword world sfc2 & godzill
   return (0);
}

static uint8 GetPPU_2138(uint16 Address)
{
   uint8 byte = 0;

   // Read OAM (sprite) control data
   if (PPU.OAMAddr & 0x100)
   {
      if (!(PPU.OAMFlip & 1))
         byte = PPU.OAMData [(PPU.OAMAddr & 0x10f) << 1];
      else
      {
         byte = PPU.OAMData [((PPU.OAMAddr & 0x10f) << 1) + 1];
         PPU.OAMAddr = (PPU.OAMAddr + 1) & 0x1ff;
      }
   }
   else
   {
      if (!(PPU.OAMFlip & 1))
         byte = PPU.OAMData [PPU.OAMAddr << 1];
      else
      {
         byte = PPU.OAMData [(PPU.OAMAddr << 1) + 1];
         ++PPU.OAMAddr;
      }
   }
   PPU.OAMFlip ^= 1;

   return (byte);

}

static uint8 GetPPU_2139(uint16 Address)
{
   uint8 byte = 0;
   // Read vram low byte
#ifdef DEBUGGER
   missing.vram_read = 1;
#endif
   if (IPPU.FirstVRAMRead)
      byte = Memory.VRAM[(PPU.VMA.Address << 1) & 0xFFFF];
   else if (PPU.VMA.FullGraphicCount)
   {
      uint32 addr = PPU.VMA.Address - 1;
      uint32 rem = addr & PPU.VMA.Mask1;
      uint32 address =
         (addr & ~PPU.VMA.Mask1)
         + (rem >> PPU.VMA.Shift)
         + ((rem & (PPU.VMA.FullGraphicCount - 1)) << 3);
      byte = Memory.VRAM[((address << 1) - 2) & 0xFFFF];
   }
   else
      byte = Memory.VRAM[((PPU.VMA.Address << 1) - 2) & 0xffff];

   if (!PPU.VMA.High)
   {
      PPU.VMA.Address += PPU.VMA.Increment;
      IPPU.FirstVRAMRead = FALSE;
   }
   return byte;
}

static uint8 GetPPU_213A(uint16 Address)
{
   uint8 byte = 0;
   // Read vram high byte
#ifdef DEBUGGER
   missing.vram_read = 1;
#endif
   if (IPPU.FirstVRAMRead)
      byte = Memory.VRAM[((PPU.VMA.Address << 1) + 1) & 0xffff];
   else if (PPU.VMA.FullGraphicCount)
   {
      uint32 addr = PPU.VMA.Address - 1;
      uint32 rem = addr & PPU.VMA.Mask1;
      uint32 address =
         (addr & ~PPU.VMA.Mask1)
         + (rem >> PPU.VMA.Shift)
         + ((rem & (PPU.VMA.FullGraphicCount - 1)) << 3);
      byte = Memory.VRAM[((address << 1) - 1) & 0xFFFF];
   }
   else
      byte = Memory.VRAM[((PPU.VMA.Address << 1) - 1) & 0xFFFF];
   if (PPU.VMA.High)
   {
      PPU.VMA.Address += PPU.VMA.Increment;
      IPPU.FirstVRAMRead = FALSE;
   }
   return byte;
}

static uint8 GetPPU_213B(uint16 Address)
{
   uint8 byte = 0;
   // Read palette data
#ifdef DEBUGGER
   missing.cgram_read = 1;
#endif
   if (PPU.CGFLIPRead)
      byte = PPU.CGDATA[PPU.CGADD++] >> 8;
   else
      byte = PPU.CGDATA[PPU.CGADD] & 0xff;

   PPU.CGFLIPRead ^= 1;
   return (byte);
}

static uint8 GetPPU_213C(uint16 Address)
{
   uint8 byte = 0;
   // Horizontal counter value 0-339
#ifdef DEBUGGER
   missing.h_counter_read = 1;
#endif
   if (PPU.HBeamFlip)
      byte = PPU.HBeamPosLatched >> 8;
   else
      byte = (uint8) PPU.HBeamPosLatched;
   PPU.HBeamFlip ^= 1;
   return byte;
}

static uint8 GetPPU_213D(uint16 Address)
{
   uint8 byte = 0;
   // Vertical counter value 0-262
#ifdef DEBUGGER
   missing.v_counter_read = 1;
#endif
   if (PPU.VBeamFlip)
      byte = PPU.VBeamPosLatched >> 8;
   else
      byte = (uint8) PPU.VBeamPosLatched;
   PPU.VBeamFlip ^= 1;
   return byte;
}

static uint8 GetPPU_213E(uint16 Address)
{
   // PPU time and range over flags
   return (SNESGameFixes._0x213E_ReturnValue);
}

static uint8 GetPPU_213F(uint16 Address)
{
   // NTSC/PAL and which field flags
   PPU.VBeamFlip = PPU.HBeamFlip = 0;
   return ((Settings.PAL ? 0x10 : 0) | (Memory.FillRAM[0x213f] & 0xc0));
}

static uint8 GetPPU_APUR(uint16 Address)
{
   /*
      case 0x2140: case 0x2141: case 0x2142: case 0x2143:
      case 0x2144: case 0x2145: case 0x2146: case 0x2147:
      case 0x2148: case 0x2149: case 0x214a: case 0x214b:
      case 0x214c: case 0x214d: case 0x214e: case 0x214f:
      case 0x2150: case 0x2151: case 0x2152: case 0x2153:
      case 0x2154: case 0x2155: case 0x2156: case 0x2157:
      case 0x2158: case 0x2159: case 0x215a: case 0x215b:
      case 0x215c: case 0x215d: case 0x215e: case 0x215f:
      case 0x2160: case 0x2161: case 0x2162: case 0x2163:
      case 0x2164: case 0x2165: case 0x2166: case 0x2167:
      case 0x2168: case 0x2169: case 0x216a: case 0x216b:
      case 0x216c: case 0x216d: case 0x216e: case 0x216f:
      case 0x2170: case 0x2171: case 0x2172: case 0x2173:
      case 0x2174: case 0x2175: case 0x2176: case 0x2177:
      case 0x2178: case 0x2179: case 0x217a: case 0x217b:
      case 0x217c: case 0x217d: case 0x217e: case 0x217f:
   */
#ifdef SPCTOOL
   return ((uint8) _SPCOutP[Address & 3]);
#else
   // CPU.Flags |= DEBUG_MODE_FLAG;
#ifdef SPC700_SHUTDOWN
   CPU.APU_APUExecuting =  Settings.APUEnabled;
   IAPU.WaitCounter++;
#endif
   if (Settings.APUEnabled)
   {
#ifdef CPU_SHUTDOWN
      //CPU.WaitAddress = CPU.PCAtOpcodeStart;
#endif
      if (!SNESGameFixes.APU_OutPorts_ReturnValueFix) return (APU.OutPorts[Address & 3]); // early exit
      if (Address >= 0x2140
            && Address <= 0x2143
            && !CPU.V_Counter)
      {
         return (uint8)((Address & 1) ?
                        ((rand() & 0xff00) >> 8) : (rand() & 0xff));
      }
      return (APU.OutPorts[Address & 3]);
   }
   /*
      switch (Settings.SoundSkipMethod)
      {
         case 3 :
         case 0 :
         case 1 :
   */
#ifdef ASMCPU
   CPU.rstatus |= (1 << (24 - 2));
#endif
   CPU.BranchSkip = TRUE;
   /*
            break;
         case 2 :
            break;
      }
   */
   if ((Address & 3) < 2)
   {
      int r = rand();
      if (r & 2)
      {
         if (r & 4)
            return ((Address & 3) == 1 ? 0xaa : 0xbb);
         return ((r >> 3) & 0xff);
      }
   }
   else
   {
      int r = rand();
      if (r & 2)
         return ((r >> 3) & 0xff);
   }
   return (Memory.FillRAM[Address]);
#endif // SPCTOOL
}

static uint8 GetPPU_2180(uint16 Address)
{
   uint8 byte = 0;
   // Read WRAM
#ifdef DEBUGGER
   missing.wram_read = 1;
#endif
   byte = Memory.RAM[PPU.WRAM++];
   PPU.WRAM &= 0x1FFFF;
   return byte;
}

static uint8 GetPPU_ZERO(uint16 Address)
{
   return 0;
}

static uint8 GetPPU_ONE(uint16 Address)
{
   return 1;
}

uint8(*GetPPU[])(uint16 Address) =
{
   GetPPU_RAM,  GetPPU_RAM,  GetPPU_2102,  GetPPU_2103,  GetPPU_RAM, GetPPU_RAM, GetPPU_RAM, GetPPU_RAM,
   GetPPU_RAM, GetPPU_RAM, GetPPU_RAM, GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,
   GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM, GetPPU_RAM, GetPPU_2116, GetPPU_2117,
   GetPPU_RAM, GetPPU_RAM, GetPPU_RAM, GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,
   GetPPU_RAM,  GetPPU_2121,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM, GetPPU_RAM, GetPPU_RAM, GetPPU_RAM,
   GetPPU_RAM, GetPPU_RAM, GetPPU_RAM, GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,
   GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_213x, GetPPU_213x, GetPPU_213x, GetPPU_2137,
   GetPPU_2138, GetPPU_2139, GetPPU_213A, GetPPU_213B, GetPPU_213C, GetPPU_213D, GetPPU_213E, GetPPU_213F,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR, GetPPU_APUR,
   GetPPU_2180, GetPPU_RAM,  GetPPU_RAM,  GetPPU_RAM,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,
   GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,  GetPPU_ZERO,
   GetPPU_ONE
};

uint8 S9xGetPPU(uint16 Address)
{
   uint8 byte = 0;
   if (Address < 0x2100) //not a real PPU reg
      return 0; //treat as unmapped memory returning last byte on the bus
   if (Address <= 0x2190)
      return GetPPU[Address - 0x2100](Address);
#ifdef USE_SA1
   if (Settings.SA1)
      return (S9xGetSA1(Address));
#endif
   if (Address <= 0x2fff || Address >= 0x3000 + 768)
   {
      switch (Address)
      {
      case 0x21c2 :
         return (0x20);
      case 0x21c3 :
         return (0);
      case 0x2800 :
         // For Dai Kaijyu Monogatari II
         if (Settings.SRTC)
            return (S9xGetSRTC(Address));
      /*FALL*/

      default :
#ifdef DEBUGGER
         missing.unknownppu_read = Address;
         if (Settings.TraceUnknownRegisters)
         {
            sprintf(String, "Unknown register read: $%04X\n", Address);
            S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
         }
#endif
         // XXX:
         return (0); //Memory.FillRAM[Address]);
      }
   }

   if (!Settings.SuperFX)
      return (0x30);
   byte = Memory.FillRAM[Address];

   //if (Address != 0x3030 && Address != 0x3031)
   //printf ("%04x\n", Address);
#ifdef CPU_SHUTDOWN
   if (Address == 0x3030)
   {
      CPU.WaitAddress = CPU.PCAtOpcodeStart;
#ifdef ASMCPU
      CPU.rstatus |= (1 << (24 - 3));
#endif
   }
   else
#endif
      if (Address == 0x3031)
      {
         CLEAR_IRQ_SOURCE(GSU_IRQ_SOURCE);
         Memory.FillRAM[0x3031] = byte & 0x7f;
      }
   return (byte);
}
