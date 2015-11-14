#include "snes9x.h"
#include "ppu.h"
#include "rops.h"

ROPSTRUCT rops[MAX_ROPS];
unsigned int ROpCount;

void doRaster(ROPSTRUCT* rop)
{
   if (!rop)
      return;

   switch (rop->rop)
   {
      case ROP_NOP:
         // NOP
         break;
      case ROP_FIXEDCOLOUR:
         {
            unsigned char col = rop->value & 0x1f;
            // Colour data for fixed colour addition/subtraction
            if (rop->value & 0x80) PPU.FixedColourBlue = col;
            if (rop->value & 0x40) PPU.FixedColourGreen = col;
            if (rop->value & 0x20) PPU.FixedColourRed = col;
         }
         break;
      case ROP_PALETTE:
         {
            // Pallette, colors
            unsigned char col = rop->value & 255;
            IPPU.Blue[col] = (rop->value >> (16 + 10)) & 0x1f;
            IPPU.Green[col] = (rop->value >> (16 + 5)) & 0x1f;
            IPPU.Red[col] = (rop->value >> (16 + 0)) & 0x1f;
            IPPU.ScreenColors[col] = (uint16) BUILD_PIXEL(IPPU.XB[IPPU.Red[col]], IPPU.XB[IPPU.Green[col]],
                  IPPU.XB[IPPU.Blue[col]]);
            IPPU.ColorsChanged = TRUE;
         }
         break;
      case ROP_SCREEN_MODE:
         // Screen mode (0 - 7), background tile sizes and background 3 priority
         PPU.BG[0].BGSize = (rop->value >> 4) & 1;
         PPU.BG[1].BGSize = (rop->value >> 5) & 1;
         PPU.BG[2].BGSize = (rop->value >> 6) & 1;
         PPU.BG[3].BGSize = (rop->value >> 7) & 1;
         PPU.BGMode = rop->value & 7;
         // BJ: BG3Priority only takes effect if BGMode==1 and the bit is set
         PPU.BG3Priority  = ((rop->value & 0x0f) == 0x09);
         break;
      case ROP_BRIGHTNESS:
         PPU.Brightness = rop->value;
         S9xFixColourBrightness();
         if (PPU.Brightness > IPPU.MaxBrightness) IPPU.MaxBrightness = PPU.Brightness;
         IPPU.ColorsChanged = TRUE;
         IPPU.DirectColourMapsNeedRebuild = TRUE;
         break;
      case ROP_FORCE_BLANKING:
         PPU.ForcedBlanking = rop->value;
         IPPU.ColorsChanged = TRUE;
         break;
      case ROP_TILE_ADDRESS:
         PPU.OBJNameBase = (rop->value & 3) << 14;
         PPU.OBJNameSelect = ((rop->value >> 3) & 3) << 13;
         PPU.OBJSizeSelect = (rop->value >> 5) & 7;
         IPPU.OBJChanged = TRUE;
         break;
      case ROP_MOSAIC:
         PPU.Mosaic = (rop->value >> 4) + 1;
         PPU.BGMosaic[0] = (rop->value & 1) && PPU.Mosaic > 1;
         PPU.BGMosaic[1] = (rop->value & 2) && PPU.Mosaic > 1;
         PPU.BGMosaic[2] = (rop->value & 4) && PPU.Mosaic > 1;
         PPU.BGMosaic[3] = (rop->value & 8) && PPU.Mosaic > 1;
         break;
      case ROP_BG_SCSIZE_SCBASE:
         PPU.BG[rop->value >> 16].SCSize = rop->value & 3;
         PPU.BG[rop->value >> 16].SCBase = (rop->value & 0x7c) << 8;
         break;
      case ROP_BG_NAMEBASE:
         PPU.BG[(rop->value >> 16) + 0].NameBase = (rop->value & 7) << 12;
         PPU.BG[(rop->value >> 16) + 1].NameBase = ((rop->value >> 4) & 7) << 12;
         break;
      case ROP_MODE7_ROTATION:
         PPU.Mode7Repeat = rop->value >> 6;
         if (PPU.Mode7Repeat == 1) PPU.Mode7Repeat = 0;
         PPU.Mode7VFlip = (rop->value & 2) >> 1;
         PPU.Mode7HFlip = rop->value & 1;
         break;
      case ROP_BG_WINDOW_ENABLE:
         PPU.ClipWindow1Enable[(rop->value >> 16) + 0] = !!(rop->value & 0x02);
         PPU.ClipWindow1Enable[(rop->value >> 16) + 1] = !!(rop->value & 0x20);
         PPU.ClipWindow2Enable[(rop->value >> 16) + 0] = !!(rop->value & 0x08);
         PPU.ClipWindow2Enable[(rop->value >> 16) + 1] = !!(rop->value & 0x80);
         PPU.ClipWindow1Inside[(rop->value >> 16) + 0] = !(rop->value & 0x01);
         PPU.ClipWindow1Inside[(rop->value >> 16) + 1] = !(rop->value & 0x10);
         PPU.ClipWindow2Inside[(rop->value >> 16) + 0] = !(rop->value & 0x04);
         PPU.ClipWindow2Inside[(rop->value >> 16) + 1] = !(rop->value & 0x40);
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_WINDOW1_LEFT:
         PPU.Window1Left = rop->value;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_WINDOW1_RIGHT:
         PPU.Window1Right = rop->value;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_WINDOW2_LEFT:
         PPU.Window2Left = rop->value;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_WINDOW2_RIGHT:
         PPU.Window2Right = rop->value;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_BG_WINDOW_LOGIC:
         PPU.ClipWindowOverlapLogic[0] = (rop->value & 0x03);
         PPU.ClipWindowOverlapLogic[1] = (rop->value & 0x0c) >> 2;
         PPU.ClipWindowOverlapLogic[2] = (rop->value & 0x30) >> 4;
         PPU.ClipWindowOverlapLogic[3] = (rop->value & 0xc0) >> 6;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_OBJS_WINDOW_LOGIC:
         PPU.ClipWindowOverlapLogic[4] = (rop->value & 0x03);
         PPU.ClipWindowOverlapLogic[5] = (rop->value & 0x0c) >> 2;
         PPU.RecomputeClipWindows = TRUE;
         break;
      case ROP_MAIN_SCREEN_DESIG:
         // Main screen designation (backgrounds 1 - 4 and objects)
         if ((GFX.r212c_s & GFX.r212e_s & 0x1f) != (GFX.r212e_s & rop->value & 0x1f)) PPU.RecomputeClipWindows = TRUE;
         GFX.r212c_s = rop->value;
         break;
      case ROP_SUB_SCREEN_DESIG:
         // Sub-screen designation (backgrounds 1 - 4 and objects)
         if ((GFX.r212d_s & GFX.r212f_s & 0x1f) != (GFX.r212f_s & rop->value & 0x1f)) PPU.RecomputeClipWindows = TRUE;
         GFX.r212d_s = rop->value;
         break;
      case ROP_MAIN_SCREEN_WMASK:
         // Window mask designation for main screen ?
         if ((GFX.r212c_s & GFX.r212e_s & 0x1f) != (GFX.r212c_s & rop->value & 0x1f)) PPU.RecomputeClipWindows = TRUE;
         GFX.r212e_s = rop->value;
         break;
      case ROP_SUB_SCREEN_WMASK:
         // Window mask designation for sub-sreen ?
         if ((GFX.r212d_s & GFX.r212f_s & 0x1f) != (GFX.r212d_s & rop->value & 0x1f)) PPU.RecomputeClipWindows = TRUE;
         GFX.r212f_s = rop->value;
         break;
      case ROP_FIXEDCOL_OR_SCREEN:
         // Fixed colour addition or screen addition
         if ((GFX.r2130_s & 0xf0) != (rop->value & 0xf0)) PPU.RecomputeClipWindows = TRUE;
         GFX.r2130_s = rop->value;
         break;
      case ROP_ADD_OR_SUB_COLOR:
         // Backgrounds 1 - 4, objects and backdrop colour add/sub enable
         GFX.r2131_s = rop->value;
         break;
   }
   rop->rop = 0; // Raster Operation already done, invalidate it
}

bool wouldRasterAlterStatus(ROPSTRUCT* rop)
{
   if (!rop)
      return false;
   switch (rop->rop)
   {
      case ROP_NOP:
         return false;
      case ROP_FIXEDCOLOUR:
         {
            unsigned char col = rop->value & 0x1f;
            // Colour data for fixed colour addition/subtraction
            if ((rop->value & 0x80) && (PPU.FixedColourBlue != col)) return true;
            if ((rop->value & 0x40) && (PPU.FixedColourGreen != col)) return true;
            if ((rop->value & 0x20) && (PPU.FixedColourRed != col)) return true;
            return false;
         }
         break;
      case ROP_PALETTE:
         return true;
      case ROP_SCREEN_MODE:
         return true;
      case ROP_BRIGHTNESS:
         return true;
      case ROP_FORCE_BLANKING:
         return true;
      case ROP_TILE_ADDRESS:
         return true;
      case ROP_MOSAIC:
         return true;
      case ROP_BG_SCSIZE_SCBASE:
         return true;
      case ROP_BG_NAMEBASE:
         return true;
      case ROP_MODE7_ROTATION:
         return true;
      case ROP_BG_WINDOW_ENABLE:
         return true;
      case ROP_WINDOW1_LEFT:
         return true;
      case ROP_WINDOW1_RIGHT:
         return true;
      case ROP_WINDOW2_LEFT:
         return true;
      case ROP_WINDOW2_RIGHT:
         return true;
      case ROP_BG_WINDOW_LOGIC:
         return true;
      case ROP_OBJS_WINDOW_LOGIC:
         return true;
      case ROP_MAIN_SCREEN_DESIG:
         return true;
      case ROP_SUB_SCREEN_DESIG:
         return true;
      case ROP_MAIN_SCREEN_WMASK:
         return true;
      case ROP_SUB_SCREEN_WMASK:
         return true;
      case ROP_FIXEDCOL_OR_SCREEN:
         return true;
      case ROP_ADD_OR_SUB_COLOR:
         return true;
   }
   return true;
}
