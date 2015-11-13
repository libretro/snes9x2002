#include "rops.h"

static void SetPPU_2100_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Brightness and screen blank bit
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2100, Brightness and screen blank bit Byte: %x\n", Byte);
#endif
      if ((Memory.FillRAM[Address] & 0x0f) != (Byte & 0x0f)) ADD_ROP(ROP_BRIGHTNESS, Byte & 0xf);
      if ((Memory.FillRAM[Address] & 0x80) != (Byte & 0x80)) ADD_ROP(ROP_FORCE_BLANKING, (Byte >> 7) & 1);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2100(uint8 Byte, uint16 Address)
{
   // Brightness and screen blank bit
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2100, Brightness and screen blank bit Byte: %x\n", Byte);
#endif

      // Wiz & Gp2x, no Brightness handling
      FLUSH_REDRAW();

      if (PPU.Brightness != (Byte & 0xF))
      {

         IPPU.ColorsChanged = TRUE;
         IPPU.DirectColourMapsNeedRebuild = TRUE;
         PPU.Brightness = Byte & 0xF;
         S9xFixColourBrightness();
         if (PPU.Brightness > IPPU.MaxBrightness)
            IPPU.MaxBrightness = PPU.Brightness;
      }
      if ((Memory.FillRAM[Address] & 0x80) != (Byte & 0x80))
      {

         IPPU.ColorsChanged = TRUE;
         PPU.ForcedBlanking = (Byte >> 7) & 1;
      }
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

#ifdef __OLD_RASTER_FX__
static void SetPPU_2101(uint8 Byte, uint16 Address)
{
   // Sprite (OBJ) tile address
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2101, tile address. Byte: %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.OBJNameBase = (Byte & 3) << 14;
      PPU.OBJNameSelect = ((Byte >> 3) & 3) << 13;
      PPU.OBJSizeSelect = (Byte >> 5) & 7;
      IPPU.OBJChanged = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2101_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Sprite (OBJ) tile address
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2101, tile address. Byte: %x\n", Byte);
#endif
      ADD_ROP(ROP_TILE_ADDRESS, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}


static void SetPPU_2102(uint8 Byte, uint16 Address)
{
   // Sprite write address (low)
   PPU.OAMAddr = ((Memory.FillRAM[0x2103] & 1) << 8) | Byte;
   PPU.OAMFlip = 2;
   PPU.OAMReadFlip = 0;
   PPU.SavedOAMAddr2 = PPU.SavedOAMAddr;
   PPU.SavedOAMAddr = PPU.OAMAddr;
   if (PPU.OAMPriorityRotation && PPU.FirstSprite != (PPU.OAMAddr >> 1))
   {
      PPU.FirstSprite = (PPU.OAMAddr & 0xFE) >> 1;
      IPPU.OBJChanged = TRUE;
#ifdef DEBUGGER
      missing.sprite_priority_rotation = 1;
#endif
   }
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2103(uint8 Byte, uint16 Address)
{
   // Sprite register write address (high), sprite priority rotation
   // bit.
   PPU.OAMAddr &= 0x00FF;
   PPU.OAMAddr |= (Byte & 1) << 8;

   if (SNESGameFixes.Flintstones)
      PPU.OAMPriorityRotation = (Byte & 0x80) ? 0 : 1;
   else
      PPU.OAMPriorityRotation = (Byte & 0x80) ? 1 : 0;
   if (PPU.OAMPriorityRotation && PPU.FirstSprite != (PPU.OAMAddr >> 1))
   {
      PPU.FirstSprite = (PPU.OAMAddr & 0xFE) >> 1;
      IPPU.OBJChanged = TRUE;
   }
   PPU.OAMFlip = 0;
   PPU.OAMReadFlip = 0;
   PPU.SavedOAMAddr = PPU.OAMAddr;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2104(uint8 Byte, uint16 Address)
{
   // Sprite register write
   REGISTER_2104(Byte);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2105_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Screen mode (0 - 7), background tile sizes and background 3
   // priority
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2105, Screen mode (0 - 7), background tile sizes and background 3 priority. Byte: %x\n", Byte);
#endif
      ADD_ROP(ROP_SCREEN_MODE, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2105(uint8 Byte, uint16 Address)
{
   // Screen mode (0 - 7), background tile sizes and background 3
   // priority
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2105, Screen mode (0 - 7), background tile sizes and background 3 priority. Byte: %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[0].BGSize = (Byte >> 4) & 1;
      PPU.BG[1].BGSize = (Byte >> 5) & 1;
      PPU.BG[2].BGSize = (Byte >> 6) & 1;
      PPU.BG[3].BGSize = (Byte >> 7) & 1;
      PPU.BGMode = Byte & 7;
      // BJ: BG3Priority only takes effect if BGMode==1 and the bit is set
      PPU.BG3Priority  = ((Byte & 0x0f) == 0x09);
      Memory.FillRAM[Address] = Byte;
   }
}
#endif


static void SetPPU_2106_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Mosaic pixel size and enable
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2106, Mosaic pixel size and enable. Byte: %x\n", Byte);
#endif
      ADD_ROP(ROP_MOSAIC, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2106(uint8 Byte, uint16 Address)
{
   // Mosaic pixel size and enable
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2106, Mosaic pixel size and enable. Byte: %x\n", Byte);
#endif
      FLUSH_REDRAW();
#ifdef DEBUGGER
      if ((Byte & 0xf0) && (Byte & 0x0f))
         missing.mosaic = 1;
#endif
      PPU.Mosaic = (Byte >> 4) + 1;
      PPU.BGMosaic[0] = (Byte & 1) && PPU.Mosaic > 1;
      PPU.BGMosaic[1] = (Byte & 2) && PPU.Mosaic > 1;
      PPU.BGMosaic[2] = (Byte & 4) && PPU.Mosaic > 1;
      PPU.BGMosaic[3] = (Byte & 8) && PPU.Mosaic > 1;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2107_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2107, BG 0, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_SCSIZE_SCBASE, (0 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__

static void SetPPU_2107(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2107, BG 0, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[0].SCSize = Byte & 3;
      PPU.BG[0].SCBase = (Byte & 0x7c) << 8;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2108_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2108, BG 1, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_SCSIZE_SCBASE, (1 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2108(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2108, BG 1, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[1].SCSize = Byte & 3;
      PPU.BG[1].SCBase = (Byte & 0x7c) << 8;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2109_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2109, BG 2, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_SCSIZE_SCBASE, (2 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2109(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2109, BG 2, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[2].SCSize = Byte & 3;
      PPU.BG[2].SCBase = (Byte & 0x7c) << 8;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_210A_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210A, BG 3, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_SCSIZE_SCBASE, (3 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_210A(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210A, BG 3, SCSize & SCBase . Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[3].SCSize = Byte & 3;
      PPU.BG[3].SCBase = (Byte & 0x7c) << 8;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_210B_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210B, BG 0 & 1, NameBase. Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_NAMEBASE, (0 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_210B(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210B, BG 0 & 1, NameBase. Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[0].NameBase = (Byte & 7) << 12;
      PPU.BG[1].NameBase = ((Byte >> 4) & 7) << 12;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_210C_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210C, BG 2 & 3, NameBase. Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_BG_NAMEBASE, (2 << 16) | Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

static void SetPPU_210C(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_210C, BG 2 & 3, NameBase. Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.BG[2].NameBase = (Byte & 7) << 12;
      PPU.BG[3].NameBase = ((Byte >> 4) & 7) << 12;
      Memory.FillRAM[Address] = Byte;
   }
}


//This is the Theme Park fix - it appears all these registers
//share a previous byte value for setting them.

static void SetPPU_210D(uint8 Byte, uint16 Address)
{
   PPU.BG[0].HOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[0].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_210E(uint8 Byte, uint16 Address)
{
   PPU.BG[0].VOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[0].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_210F(uint8 Byte, uint16 Address)
{
   PPU.BG[1].HOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[1].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2110(uint8 Byte, uint16 Address)
{
   PPU.BG[1].VOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[1].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2111(uint8 Byte, uint16 Address)
{
   PPU.BG[2].HOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[2].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2112(uint8 Byte, uint16 Address)
{
   PPU.BG[2].VOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[2].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2113(uint8 Byte, uint16 Address)
{
   PPU.BG[3].HOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[3].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2114(uint8 Byte, uint16 Address)
{
   PPU.BG[3].VOffset = (Byte << 8) | PPU.BGnxOFSbyte;
   PPU.BG[3].OffsetsChanged = 1;
   PPU.BGnxOFSbyte = Byte;
   Memory.FillRAM[Address] = Byte;
}

//end Theme Park


static void SetPPU_2115(uint8 Byte, uint16 Address)
{
   // VRAM byte/word access flag and increment
   PPU.VMA.High = (Byte & 0x80) == 0 ? FALSE : TRUE;
   switch (Byte & 3)
   {
   case 0 :
      PPU.VMA.Increment = 1;
      break;
   case 1 :
      PPU.VMA.Increment = 32;
      break;
   case 2 :
      PPU.VMA.Increment = 128;
      break;
   case 3 :
      PPU.VMA.Increment = 128;
      break;
   }
#ifdef DEBUGGER
   if ((Byte & 3) != 0)
      missing.vram_inc = Byte & 3;
#endif
   if (Byte & 0x0c)
   {
      static uint16 IncCount[4] = { 0, 32, 64, 128 };
      static uint16 Shift[4] = { 0, 5, 6, 7 };
#ifdef DEBUGGER
      missing.vram_full_graphic_inc =
         (Byte & 0x0c) >> 2;
#endif
      PPU.VMA.Increment = 1;
      uint8 i = (Byte & 0x0c) >> 2;
      PPU.VMA.FullGraphicCount = IncCount[i];
      PPU.VMA.Mask1 = IncCount[i] * 8 - 1;
      PPU.VMA.Shift = Shift[i];
   }
   else
      PPU.VMA.FullGraphicCount = 0;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2116(uint8 Byte, uint16 Address)
{
   // VRAM read/write address (low)
   PPU.VMA.Address &= 0xFF00;
   PPU.VMA.Address |= Byte;
   IPPU.FirstVRAMRead = TRUE;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2117(uint8 Byte, uint16 Address)
{
   // VRAM read/write address (high)
   PPU.VMA.Address &= 0x00FF;
   PPU.VMA.Address |= Byte << 8;
   IPPU.FirstVRAMRead = TRUE;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2118(uint8 Byte, uint16 Address)
{
   // VRAM write data (low)
   IPPU.FirstVRAMRead = TRUE;
   REGISTER_2118(Byte);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2119(uint8 Byte, uint16 Address)
{
   // VRAM write data (high)
   IPPU.FirstVRAMRead = TRUE;
   REGISTER_2119(Byte);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_211A_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Mode 7 outside rotation area display mode and flipping
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_211A, Mode 7 outside rotation area display mode and flipping. Byte : %x\n", Byte);
#endif
      ADD_ROP(ROP_MODE7_ROTATION, Byte);

      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_211A(uint8 Byte, uint16 Address)
{
   // Mode 7 outside rotation area display mode and flipping
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_211A, Mode 7 outside rotation area display mode and flipping. Byte : %x\n", Byte);
#endif
      FLUSH_REDRAW();
      PPU.Mode7Repeat = Byte >> 6;
      if (PPU.Mode7Repeat == 1) PPU.Mode7Repeat = 0;
      PPU.Mode7VFlip = (Byte & 2) >> 1;
      PPU.Mode7HFlip = Byte & 1;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_211B(uint8 Byte, uint16 Address)
{
   // Mode 7 matrix A (low & high)
   PPU.MatrixA = ((PPU.MatrixA >> 8) & 0xff) | (Byte << 8);
   PPU.Need16x8Mulitply = TRUE;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_211C(uint8 Byte, uint16 Address)
{
   // Mode 7 matrix B (low & high)
   PPU.MatrixB = ((PPU.MatrixB >> 8) & 0xff) | (Byte << 8);
   PPU.Need16x8Mulitply = TRUE;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_211D(uint8 Byte, uint16 Address)
{
   // Mode 7 matrix C (low & high)
   PPU.MatrixC = ((PPU.MatrixC >> 8) & 0xff) | (Byte << 8);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_211E(uint8 Byte, uint16 Address)
{
   // Mode 7 matrix D (low & high)
   PPU.MatrixD = ((PPU.MatrixD >> 8) & 0xff) | (Byte << 8);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_211F(uint8 Byte, uint16 Address)
{
   // Mode 7 centre of rotation X (low & high)
   PPU.CentreX = ((PPU.CentreX >> 8) & 0xff) | (Byte << 8);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2120(uint8 Byte, uint16 Address)
{
   // Mode 7 centre of rotation Y (low & high)
   PPU.CentreY = ((PPU.CentreY >> 8) & 0xff) | (Byte << 8);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2121(uint8 Byte, uint16 Address)
{
   // CG-RAM address
   PPU.CGFLIP = 0;
   PPU.CGFLIPRead = 0;
   PPU.CGADD = Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2122(uint8 Byte, uint16 Address)
{
   REGISTER_2122(Byte);
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2123_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for backgrounds 1 and 2
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2123, Window 1 and 2 enable for backgrounds 1 and 2. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_BG_WINDOW_ENABLE, (0 << 16) | Byte);
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[1] = 1;
      if (Byte & 0x20)
         missing.window1[1] = 1;
      if (Byte & 0x08)
         missing.window2[0] = 1;
      if (Byte & 0x02)
         missing.window1[0] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2123(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for backgrounds 1 and 2
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2123, Window 1 and 2 enable for backgrounds 1 and 2. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.ClipWindow1Enable[0] = !!(Byte & 0x02);
      PPU.ClipWindow1Enable[1] = !!(Byte & 0x20);
      PPU.ClipWindow2Enable[0] = !!(Byte & 0x08);
      PPU.ClipWindow2Enable[1] = !!(Byte & 0x80);
      PPU.ClipWindow1Inside[0] = !(Byte & 0x01);
      PPU.ClipWindow1Inside[1] = !(Byte & 0x10);
      PPU.ClipWindow2Inside[0] = !(Byte & 0x04);
      PPU.ClipWindow2Inside[1] = !(Byte & 0x40);
      PPU.RecomputeClipWindows = TRUE;
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[1] = 1;
      if (Byte & 0x20)
         missing.window1[1] = 1;
      if (Byte & 0x08)
         missing.window2[0] = 1;
      if (Byte & 0x02)
         missing.window1[0] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2124_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for backgrounds 3 and 4
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2124, Window 1 and 2 enable for backgrounds 3 and 4. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_BG_WINDOW_ENABLE, (2 << 16) | Byte);
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[3] = 1;
      if (Byte & 0x20)
         missing.window1[3] = 1;
      if (Byte & 0x08)
         missing.window2[2] = 1;
      if (Byte & 0x02)
         missing.window1[2] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2124(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for backgrounds 3 and 4
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2124, Window 1 and 2 enable for backgrounds 3 and 4. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.ClipWindow1Enable[2] = !!(Byte & 0x02);
      PPU.ClipWindow1Enable[3] = !!(Byte & 0x20);
      PPU.ClipWindow2Enable[2] = !!(Byte & 0x08);
      PPU.ClipWindow2Enable[3] = !!(Byte & 0x80);
      PPU.ClipWindow1Inside[2] = !(Byte & 0x01);
      PPU.ClipWindow1Inside[3] = !(Byte & 0x10);
      PPU.ClipWindow2Inside[2] = !(Byte & 0x04);
      PPU.ClipWindow2Inside[3] = !(Byte & 0x40);
      PPU.RecomputeClipWindows = TRUE;
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[3] = 1;
      if (Byte & 0x20)
         missing.window1[3] = 1;
      if (Byte & 0x08)
         missing.window2[2] = 1;
      if (Byte & 0x02)
         missing.window1[2] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2125_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for objects and colour window
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2125, Window 1 and 2 enable for objects and colour window. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_BG_WINDOW_ENABLE, (4 << 16) | Byte);
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[5] = 1;
      if (Byte & 0x20)
         missing.window1[5] = 1;
      if (Byte & 0x08)
         missing.window2[4] = 1;
      if (Byte & 0x02)
         missing.window1[4] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2125(uint8 Byte, uint16 Address)
{
   // Window 1 and 2 enable for objects and colour window
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2125, Window 1 and 2 enable for objects and colour window. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.ClipWindow1Enable[4] = !!(Byte & 0x02);
      PPU.ClipWindow1Enable[5] = !!(Byte & 0x20);
      PPU.ClipWindow2Enable[4] = !!(Byte & 0x08);
      PPU.ClipWindow2Enable[5] = !!(Byte & 0x80);
      PPU.ClipWindow1Inside[4] = !(Byte & 0x01);
      PPU.ClipWindow1Inside[5] = !(Byte & 0x10);
      PPU.ClipWindow2Inside[4] = !(Byte & 0x04);
      PPU.ClipWindow2Inside[5] = !(Byte & 0x40);
      PPU.RecomputeClipWindows = TRUE;
#ifdef DEBUGGER
      if (Byte & 0x80)
         missing.window2[5] = 1;
      if (Byte & 0x20)
         missing.window1[5] = 1;
      if (Byte & 0x08)
         missing.window2[4] = 1;
      if (Byte & 0x02)
         missing.window1[4] = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2126_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 1 left position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2126, Window 1 left position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_WINDOW1_LEFT, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2126(uint8 Byte, uint16 Address)
{
   // Window 1 left position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2126, Window 1 left position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.Window1Left = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2127_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 1 right position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2127, Window 1 right position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_WINDOW1_RIGHT, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2127(uint8 Byte, uint16 Address)
{
   // Window 1 right position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2127, Window 1 right position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.Window1Right = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2128_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 2 left position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2128, Window 2 left position. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_WINDOW2_LEFT, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2128(uint8 Byte, uint16 Address)
{
   // Window 2 left position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2128, Window 2 left position. Byte: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.Window2Left = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2129_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window 2 right position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2129, Window 2 right position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_WINDOW2_RIGHT, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2129(uint8 Byte, uint16 Address)
{
   // Window 2 right position
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2129, Window 2 right position. Byte: %x\n", Byte);
#endif
      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.Window2Right = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212A_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Windows 1 & 2 overlap logic for backgrounds 1 - 4
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212A, Window 1 and 2 overlap logic for backgrounds 1 - 4: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_BG_WINDOW_LOGIC, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212A(uint8 Byte, uint16 Address)
{
   // Windows 1 & 2 overlap logic for backgrounds 1 - 4
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212A, Window 1 and 2 overlap logic for backgrounds 1 - 4: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.ClipWindowOverlapLogic[0] = (Byte & 0x03);
      PPU.ClipWindowOverlapLogic[1] = (Byte & 0x0c) >> 2;
      PPU.ClipWindowOverlapLogic[2] = (Byte & 0x30) >> 4;
      PPU.ClipWindowOverlapLogic[3] = (Byte & 0xc0) >> 6;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212B_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Windows 1 & 2 overlap logic for objects and colour window
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212B, Window 1 and 2 overlap logic objects and colour window: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      ADD_ROP(ROP_OBJS_WINDOW_LOGIC, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212B(uint8 Byte, uint16 Address)
{
   // Windows 1 & 2 overlap logic for objects and colour window
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212B, Window 1 and 2 overlap logic objects and colour window: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_WINDOW) return;
      FLUSH_REDRAW();

      PPU.ClipWindowOverlapLogic[4] = Byte & 0x03;
      PPU.ClipWindowOverlapLogic[5] = (Byte & 0x0c) >> 2;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212C_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Main screen designation (backgrounds 1 - 4 and objects)
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212C, Main screen designation bg 1-4 and objs: %x\n", Byte);
#endif
      ADD_ROP(ROP_MAIN_SCREEN_DESIG, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212C(uint8 Byte, uint16 Address)
{
   // Main screen designation (backgrounds 1 - 4 and objects)
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212C, Main screen designation bg 1-4 and objs: %x\n", Byte);
#endif

      FLUSH_REDRAW();

      PPU.RecomputeClipWindows = TRUE;
      GFX.r212c_s = Byte;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212D_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Sub-screen designation (backgrounds 1 - 4 and objects)
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212D, Sub-screen designation bg 1-4 and objs: %x\n", Byte);
#endif


#ifdef DEBUGGER
      if (Byte & 0x1f)
         missing.subscreen = 1;
#endif
      ADD_ROP(ROP_SUB_SCREEN_DESIG, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212D(uint8 Byte, uint16 Address)
{
   // Sub-screen designation (backgrounds 1 - 4 and objects)
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212D, Sub-screen designation bg 1-4 and objs: %x\n", Byte);
#endif


#ifdef DEBUGGER
      if (Byte & 0x1f)
         missing.subscreen = 1;
#endif
      FLUSH_REDRAW();

      PPU.RecomputeClipWindows = TRUE;
      GFX.r212d_s = Byte;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212E_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window mask designation for main screen ?
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212E, Window mask designation for main screen ?: %x\n", Byte);
#endif
      ADD_ROP(ROP_MAIN_SCREEN_WMASK, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212E(uint8 Byte, uint16 Address)
{
   // Window mask designation for main screen ?
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212E, Window mask designation for main screen ?: %x\n", Byte);
#endif
      FLUSH_REDRAW();

      GFX.r212e_s = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_212F_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Window mask designation for sub-screen ?
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212F, Window mask designation for sub-screen: %x\n", Byte);
#endif
      ADD_ROP(ROP_SUB_SCREEN_WMASK, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_212F(uint8 Byte, uint16 Address)
{
   // Window mask designation for sub-screen ?
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_212F, Window mask designation for sub-screen: %x\n", Byte);
#endif
      FLUSH_REDRAW();

      GFX.r212f_s = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2130_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Fixed colour addition or screen addition
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2130, Fixed colour addition or screen addition: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_ADDSUB) return;

#ifdef DEBUGGER
      if ((Byte & 1) && (PPU.BGMode == 3 || PPU.BGMode == 4
                         || PPU.BGMode == 7))
         missing.direct = 1;
#endif
      ADD_ROP(ROP_FIXEDCOL_OR_SCREEN, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2130(uint8 Byte, uint16 Address)
{
   // Fixed colour addition or screen addition
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef   __DEBUG__
      printf("SetPPU_2130, Fixed colour addition or screen addition: %x\n", Byte);
#endif

      if (Settings.os9x_hack & PPU_IGNORE_ADDSUB) return;

#ifdef DEBUGGER
      if ((Byte & 1) && (PPU.BGMode == 3 || PPU.BGMode == 4
                         || PPU.BGMode == 7))
         missing.direct = 1;
#endif
      FLUSH_REDRAW();

      GFX.r2130_s = Byte;
      PPU.RecomputeClipWindows = TRUE;
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2131_delayedRasterFx(uint8 Byte, uint16 Address)
{
   // Colour addition or subtraction select
   if (Byte != Memory.FillRAM[Address])
   {
      if (Settings.os9x_hack & PPU_IGNORE_ADDSUB) return;
#ifdef   __DEBUG__
      printf("SetPPU_2131, Colour addition or subtraction select %x\n", Byte);
#endif


      // Backgrounds 1 - 4, objects and backdrop colour add/sub enable
#ifdef DEBUGGER
      if (Byte & 0x80)
      {
         // Subtract
         if (Memory.FillRAM[0x2130] & 0x02)
            missing.subscreen_sub = 1;
         else
            missing.fixed_colour_sub = 1;
      }
      else
      {
         // Addition
         if (Memory.FillRAM[0x2130] & 0x02)
            missing.subscreen_add = 1;
         else
            missing.fixed_colour_add = 1;
      }
#endif
      ADD_ROP(ROP_ADD_OR_SUB_COLOR, Byte);
      Memory.FillRAM[0x2131] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2131(uint8 Byte, uint16 Address)
{
   // Colour addition or subtraction select
   if (Byte != Memory.FillRAM[Address])
   {
      if (Settings.os9x_hack & PPU_IGNORE_ADDSUB) return;
#ifdef   __DEBUG__
      printf("SetPPU_2131, Colour addition or subtraction select %x\n", Byte);
#endif


      // Backgrounds 1 - 4, objects and backdrop colour add/sub enable
#ifdef DEBUGGER
      if (Byte & 0x80)
      {
         // Subtract
         if (Memory.FillRAM[0x2130] & 0x02)
            missing.subscreen_sub = 1;
         else
            missing.fixed_colour_sub = 1;
      }
      else
      {
         // Addition
         if (Memory.FillRAM[0x2130] & 0x02)
            missing.subscreen_add = 1;
         else
            missing.fixed_colour_add = 1;
      }
#endif
      FLUSH_REDRAW();
      GFX.r2131_s = Byte;
      Memory.FillRAM[0x2131] = Byte;
   }
}
#endif

static void SetPPU_2132_delayedRasterFx(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {

      if (!(Settings.os9x_hack & PPU_IGNORE_FIXEDCOLCHANGES)) ADD_ROP(ROP_FIXEDCOLOUR, Byte);
      Memory.FillRAM[Address] = Byte;
   }
}

#ifdef __OLD_RASTER_FX__
static void SetPPU_2132(uint8 Byte, uint16 Address)
{
   if (Byte != Memory.FillRAM[Address])
   {

      int redraw_needed = 0;
      int new_fixedcol;
      //FLUSH_REDRAW ();

      new_fixedcol = (Byte & 0x1f);
      // Colour data for fixed colour addition/subtraction
      if (Byte & 0x80)
      {
         //PPU.FixedColourBlue = Byte & 0x1f;
         if (new_fixedcol != PPU.FixedColourBlue)
         {
            if (!(Settings.os9x_hack & PPU_IGNORE_FIXEDCOLCHANGES)) FLUSH_REDRAW();
            PPU.FixedColourBlue = new_fixedcol;
         }
      }
      if (Byte & 0x40)
      {
         //PPU.FixedColourGreen = Byte & 0x1f;
         if (new_fixedcol != PPU.FixedColourGreen)
         {
            if (!(Settings.os9x_hack & PPU_IGNORE_FIXEDCOLCHANGES)) FLUSH_REDRAW();
            PPU.FixedColourGreen = new_fixedcol;
         }
      }
      if (Byte & 0x20)
      {
         //PPU.FixedColourRed = Byte & 0x1f;
         if (new_fixedcol != PPU.FixedColourRed)
         {
            if (!(Settings.os9x_hack & PPU_IGNORE_FIXEDCOLCHANGES)) FLUSH_REDRAW();
            PPU.FixedColourRed = new_fixedcol;
         }
      }
      Memory.FillRAM[Address] = Byte;
   }
}
#endif

static void SetPPU_2133(uint8 Byte, uint16 Address)
{
   // Screen settings
   if (Byte != Memory.FillRAM[Address])
   {
#ifdef DEBUGGER
      if (Byte & 0x40)
         missing.mode7_bgmode = 1;
      if (Byte & 0x08)
         missing.pseudo_512 = 1;
#endif
      if (Byte & 0x04)
      {
         PPU.ScreenHeight = SNES_HEIGHT_EXTENDED;
#ifdef DEBUGGER
         missing.lines_239 = 1;
#endif
      }
      else
         PPU.ScreenHeight = SNES_HEIGHT;
#ifdef DEBUGGER
      if (Byte & 0x02)
         missing.sprite_double_height = 1;

      if (Byte & 1)
         missing.interlace = 1;
#endif
      Memory.FillRAM[Address] = Byte;
   }
}

static void SetPPU_NOP(uint8 Byte, uint16 Address)
{
}

static void SetPPU_APU(uint8 Byte, uint16 Address)
{
#ifdef SPCTOOL
   _SPCInPB(Address & 3, Byte);
#else
   // CPU.Flags |= DEBUG_MODE_FLAG;
   Memory.FillRAM[Address] = Byte;
   IAPU.RAM[(Address & 3) + 0xf4] = Byte;
#ifdef SPC700_SHUTDOWN
   CPU.APU_APUExecuting = Settings.APUEnabled;
   IAPU.WaitCounter++;
#endif
#endif // SPCTOOL
}

static void SetPPU_2180(uint8 Byte, uint16 Address)
{
   REGISTER_2180(Byte);
   Memory.FillRAM[Address] = Byte;
}


static void SetPPU_2181(uint8 Byte, uint16 Address)
{
   PPU.WRAM &= 0x1FF00;
   PPU.WRAM |= Byte;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2182(uint8 Byte, uint16 Address)
{
   PPU.WRAM &= 0x100FF;
   PPU.WRAM |= Byte << 8;
   Memory.FillRAM[Address] = Byte;
}

static void SetPPU_2183(uint8 Byte, uint16 Address)
{
   PPU.WRAM &= 0x0FFFF;
   PPU.WRAM |= Byte << 16;
   PPU.WRAM &= 0x1FFFF;
   Memory.FillRAM[Address] = Byte;
}

#ifdef __OLD_RASTER_FX__
static void (*SetPPU[])(uint8 Byte, uint16 Address) =
{
   SetPPU_2100, SetPPU_2101, SetPPU_2102, SetPPU_2103, SetPPU_2104, SetPPU_2105, SetPPU_2106, SetPPU_2107,
   SetPPU_2108, SetPPU_2109, SetPPU_210A, SetPPU_210B, SetPPU_210C, SetPPU_210D, SetPPU_210E, SetPPU_210F,
   SetPPU_2110, SetPPU_2111, SetPPU_2112, SetPPU_2113, SetPPU_2114, SetPPU_2115, SetPPU_2116, SetPPU_2117,
   SetPPU_2118, SetPPU_2119, SetPPU_211A, SetPPU_211B, SetPPU_211C, SetPPU_211D, SetPPU_211E, SetPPU_211F,
   SetPPU_2120, SetPPU_2121, SetPPU_2122, SetPPU_2123, SetPPU_2124, SetPPU_2125, SetPPU_2126, SetPPU_2127,
   SetPPU_2128, SetPPU_2129, SetPPU_212A, SetPPU_212B, SetPPU_212C, SetPPU_212D, SetPPU_212E, SetPPU_212F,
   SetPPU_2130, SetPPU_2131, SetPPU_2132, SetPPU_2133, SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,
   SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_2180, SetPPU_2181, SetPPU_2182, SetPPU_2183
};
#endif

static void (*SetPPU_delayedRasterFx[])(uint8 Byte, uint16 Address) =
{
   SetPPU_2100_delayedRasterFx, SetPPU_2101_delayedRasterFx, SetPPU_2102, SetPPU_2103, SetPPU_2104, SetPPU_2105_delayedRasterFx, SetPPU_2106_delayedRasterFx, SetPPU_2107_delayedRasterFx,
   SetPPU_2108_delayedRasterFx, SetPPU_2109_delayedRasterFx, SetPPU_210A_delayedRasterFx, SetPPU_210B_delayedRasterFx, SetPPU_210C_delayedRasterFx, SetPPU_210D, SetPPU_210E, SetPPU_210F,
   SetPPU_2110, SetPPU_2111, SetPPU_2112, SetPPU_2113, SetPPU_2114, SetPPU_2115, SetPPU_2116, SetPPU_2117,
   SetPPU_2118, SetPPU_2119, SetPPU_211A_delayedRasterFx, SetPPU_211B, SetPPU_211C, SetPPU_211D, SetPPU_211E, SetPPU_211F,
   SetPPU_2120, SetPPU_2121, SetPPU_2122, SetPPU_2123_delayedRasterFx, SetPPU_2124_delayedRasterFx, SetPPU_2125_delayedRasterFx, SetPPU_2126_delayedRasterFx, SetPPU_2127_delayedRasterFx,
   SetPPU_2128_delayedRasterFx, SetPPU_2129_delayedRasterFx, SetPPU_212A_delayedRasterFx, SetPPU_212B_delayedRasterFx, SetPPU_212C_delayedRasterFx, SetPPU_212D_delayedRasterFx, SetPPU_212E_delayedRasterFx, SetPPU_212F_delayedRasterFx,
   SetPPU_2130_delayedRasterFx, SetPPU_2131_delayedRasterFx, SetPPU_2132_delayedRasterFx, SetPPU_2133, SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,
   SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,  SetPPU_NOP,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,  SetPPU_APU,
   SetPPU_2180, SetPPU_2181, SetPPU_2182, SetPPU_2183
};

void S9xSetPPU(uint8 Byte, uint16 Address)
{
   //    fprintf(stderr, "%03d: %02x to %04x\n", CPU.V_Counter, Byte, Address);
   if (Address < 0x2100)
   {
      Memory.FillRAM[Address] = Byte;
      return;
   }

   if (Address <= 0x2183)
   {
#ifdef __OLD_RASTER_FX__
      SetPPU[Address - 0x2100](Byte, Address);
#endif
      SetPPU_delayedRasterFx[Address - 0x2100](Byte, Address);
      return;
   }
   else
   {
#ifdef USE_SA1
      if (Settings.SA1)
      {
         if (Address >= 0x2200 && Address < 0x23ff)
            S9xSetSA1(Byte, Address);
         else
            Memory.FillRAM[Address] = Byte;
         return;
      }
      else
#endif
         // Dai Kaijyu Monogatari II
         if (Address == 0x2801 && Settings.SRTC)
            S9xSetSRTC(Byte, Address);
         else if (Address < 0x3000 || Address >= 0x3000 + 768)
         {
#ifdef DEBUGGER
            missing.unknownppu_write = Address;
            if (Settings.TraceUnknownRegisters)
            {
               sprintf(
                  String,
                  "Unknown register write: $%02X->$%04X\n",
                  Byte,
                  Address);
               S9xMessage(S9X_TRACE, S9X_PPU_TRACE, String);
            }
#endif
         }
         else
         {
            if (!Settings.SuperFX)
               return;

            switch (Address)
            {
            case 0x3030 :
               if ((Memory.FillRAM[0x3030] ^ Byte) & FLG_G)
               {
                  Memory.FillRAM[Address] = Byte;
                  // Go flag has been changed
                  if (Byte & FLG_G)
                     S9xSuperFXExec();
                  else
                     FxFlushCache();
               }
               else
                  Memory.FillRAM[Address] = Byte;
               break;

            case 0x3031 :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x3033 :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x3034 :
               Memory.FillRAM[Address] = Byte & 0x7f;
               break;
            case 0x3036 :
               Memory.FillRAM[Address] = Byte & 0x7f;
               break;
            case 0x3037 :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x3038 :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x3039 :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x303a :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x303b :
               break;
            case 0x303f :
               Memory.FillRAM[Address] = Byte;
               break;
            case 0x301f :
               Memory.FillRAM[Address] = Byte;
               Memory.FillRAM[0x3000 + GSU_SFR] |= FLG_G;
               S9xSuperFXExec();
               return;

            default :
               Memory.FillRAM[Address] = Byte;
               if (Address >= 0x3100)
                  FxCacheWriteAccess(Address);
               break;
            }
            return;
         }
   }
   Memory.FillRAM[Address] = Byte;
}
