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
#ifndef _CPUMACRO_H_
#define _CPUMACRO_H_

static INLINE void SetZN16(uint16 Work)
{
   ICPU._Zero = Work != 0;
   ICPU._Negative = (uint8)(Work >> 8);
}

static INLINE void SetZN8(uint8 Work)
{
   ICPU._Zero = Work;
   ICPU._Negative = Work;
}

static INLINE void ADC8()
{
   uint8 Work8 = S9xGetByte(OpAddress);

   if (CheckDecimal())
   {
      uint8 Ans8;
      uint8 A1 = (Registers.A.W) & 0xF;
      uint8 A2 = (Registers.A.W >> 4) & 0xF;
      uint8 W1 = Work8 & 0xF;
      uint8 W2 = (Work8 >> 4) & 0xF;

      A1 += W1 + CheckCarry();
      if (A1 > 9)
      {
         A1 -= 10;
         A2++;
      }

      A2 += W2;
      if (A2 > 9)
      {
         A2 -= 10;
         SetCarry();
      }
      else
         ClearCarry();

      Ans8 = (A2 << 4) | A1;
      if (~(Registers.AL ^ Work8) &
            (Work8 ^ Ans8) & 0x80)
         SetOverflow();
      else
         ClearOverflow();
      Registers.AL = Ans8;
      SetZN8(Registers.AL);
   }
   else
   {
      uint16 Ans16 = Registers.AL + Work8 + CheckCarry();

      ICPU._Carry = Ans16 >= 0x100;

      if (~(Registers.AL ^ Work8) &
            (Work8 ^ (uint8) Ans16) & 0x80)
         SetOverflow();
      else
         ClearOverflow();
      Registers.AL = (uint8) Ans16;
      SetZN8(Registers.AL);

   }
}

static INLINE void ADC16()
{
   uint16 Work16 = S9xGetWord(OpAddress);

   if (CheckDecimal())
   {
      uint16 Ans16;
      uint8 A1 = (Registers.A.W) & 0xF;
      uint8 A2 = (Registers.A.W >> 4) & 0xF;
      uint8 A3 = (Registers.A.W >> 8) & 0xF;
      uint8 A4 = (Registers.A.W >> 12) & 0xF;
      uint8 W1 = Work16 & 0xF;
      uint8 W2 = (Work16 >> 4) & 0xF;
      uint8 W3 = (Work16 >> 8) & 0xF;
      uint8 W4 = (Work16 >> 12) & 0xF;

      A1 += W1 + CheckCarry();
      if (A1 > 9)
      {
         A1 -= 10;
         A2++;
      }

      A2 += W2;
      if (A2 > 9)
      {
         A2 -= 10;
         A3++;
      }

      A3 += W3;
      if (A3 > 9)
      {
         A3 -= 10;
         A4++;
      }

      A4 += W4;
      if (A4 > 9)
      {
         A4 -= 10;
         SetCarry();
      }
      else
         ClearCarry();

      Ans16 = (A4 << 12) | (A3 << 8) | (A2 << 4) | (A1);
      if (~(Registers.A.W ^ Work16) &
            (Work16 ^ Ans16) & 0x8000)
         SetOverflow();
      else
         ClearOverflow();
      Registers.A.W = Ans16;
      SetZN16(Registers.A.W);
   }
   else
   {
      uint32 Ans32 = Registers.A.W + Work16 + CheckCarry();

      ICPU._Carry = Ans32 >= 0x10000;

      if (~(Registers.A.W ^ Work16) &
            (Work16 ^ (uint16) Ans32) & 0x8000)
         SetOverflow();
      else
         ClearOverflow();
      Registers.A.W = (uint16) Ans32;
      SetZN16(Registers.A.W);
   }
}

static INLINE void AND16()
{
   Registers.A.W &= S9xGetWord(OpAddress);
   SetZN16(Registers.A.W);
}

static INLINE void AND8()
{
   Registers.AL &= S9xGetByte(OpAddress);
   SetZN8(Registers.AL);
}

static INLINE void A_ASL16()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   ICPU._Carry = (Registers.AH & 0x80) != 0;
   Registers.A.W <<= 1;
   SetZN16(Registers.A.W);
}

static INLINE void A_ASL8()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   ICPU._Carry = (Registers.AL & 0x80) != 0;
   Registers.AL <<= 1;
   SetZN8(Registers.AL);
}

static INLINE void ASL16(void)
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetWord(OpAddress);
   ICPU._Carry = (Work16 & 0x8000) != 0;
   Work16 <<= 1;
   S9xSetWord(Work16, OpAddress);
   SetZN16(Work16);
}

static INLINE void ASL8(void)
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work8 = S9xGetByte(OpAddress);
   ICPU._Carry = (Work8 & 0x80) != 0;
   Work8 <<= 1;
   S9xSetByte(Work8, OpAddress);
   SetZN8(Work8);
}

static INLINE void BIT16()
{
   uint16 Work16 = S9xGetWord(OpAddress);
   ICPU._Overflow = (Work16 & 0x4000) != 0;
   ICPU._Negative = (uint8)(Work16 >> 8);
   ICPU._Zero = (Work16 & Registers.A.W) != 0;
}

static INLINE void BIT8()
{
   uint8 Work8 = S9xGetByte(OpAddress);
   ICPU._Overflow = (Work8 & 0x40) != 0;
   ICPU._Negative = Work8;
   ICPU._Zero = Work8 & Registers.AL;
}

static INLINE void CMP16()
{
   long s9xInt32 = (long) Registers.A.W -
                   (long) S9xGetWord(OpAddress);
   ICPU._Carry = s9xInt32 >= 0;
   SetZN16((uint16) s9xInt32);
}

static INLINE void CMP8()
{
   short s9xInt16 = (short) Registers.AL -
                    (short) S9xGetByte(OpAddress);
   ICPU._Carry = s9xInt16 >= 0;
   SetZN8((uint8) s9xInt16);
}

static INLINE void CMX16()
{
   long s9xInt32 = (long) Registers.X.W -
                   (long) S9xGetWord(OpAddress);
   ICPU._Carry = s9xInt32 >= 0;
   SetZN16((uint16) s9xInt32);
}

static INLINE void CMX8()
{
   short s9xInt16 = (short) Registers.XL -
                    (short) S9xGetByte(OpAddress);
   ICPU._Carry = s9xInt16 >= 0;
   SetZN8((uint8) s9xInt16);
}

static INLINE void CMY16()
{
   long s9xInt32 = (long) Registers.Y.W -
                   (long) S9xGetWord(OpAddress);
   ICPU._Carry = s9xInt32 >= 0;
   SetZN16((uint16) s9xInt32);
}

static INLINE void CMY8()
{
   short s9xInt16 = (short) Registers.YL -
                    (short) S9xGetByte(OpAddress);
   ICPU._Carry = s9xInt16 >= 0;
   SetZN8((uint8) s9xInt16);
}

static INLINE void A_DEC16()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Registers.A.W--;
   SetZN16(Registers.A.W);
}

static INLINE void A_DEC8()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Registers.AL--;
   SetZN8(Registers.AL);
}

static INLINE void DEC16()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Work16 = S9xGetWord(OpAddress) - 1;
   S9xSetWord(Work16, OpAddress);
   SetZN16(Work16);
}

static INLINE void DEC8()
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Work8 = S9xGetByte(OpAddress) - 1;
   S9xSetByte(Work8, OpAddress);
   SetZN8(Work8);
}

static INLINE void EOR16()
{
   Registers.A.W ^= S9xGetWord(OpAddress);
   SetZN16(Registers.A.W);
}

static INLINE void EOR8()
{
   Registers.AL ^= S9xGetByte(OpAddress);
   SetZN8(Registers.AL);
}

static INLINE void A_INC16()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Registers.A.W++;
   SetZN16(Registers.A.W);
}

static INLINE void A_INC8()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Registers.AL++;
   SetZN8(Registers.AL);
}

static INLINE void INC16()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Work16 = S9xGetWord(OpAddress) + 1;
   S9xSetWord(Work16, OpAddress);
   SetZN16(Work16);
}

static INLINE void INC8()
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
#ifdef CPU_SHUTDOWN
   CPU.WaitAddress = NULL;
#endif

   Work8 = S9xGetByte(OpAddress) + 1;
   S9xSetByte(Work8, OpAddress);
   SetZN8(Work8);
}

static INLINE void LDA16()
{
   Registers.A.W = S9xGetWord(OpAddress);
   SetZN16(Registers.A.W);
}

static INLINE void LDA8()
{
   Registers.AL = S9xGetByte(OpAddress);
   SetZN8(Registers.AL);
}

static INLINE void LDX16()
{
   Registers.X.W = S9xGetWord(OpAddress);
   SetZN16(Registers.X.W);
}

static INLINE void LDX8()
{
   Registers.XL = S9xGetByte(OpAddress);
   SetZN8(Registers.XL);
}

static INLINE void LDY16()
{
   Registers.Y.W = S9xGetWord(OpAddress);
   SetZN16(Registers.Y.W);
}

static INLINE void LDY8()
{
   Registers.YL = S9xGetByte(OpAddress);
   SetZN8(Registers.YL);
}

static INLINE void A_LSR16()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   ICPU._Carry = Registers.AL & 1;
   Registers.A.W >>= 1;
   SetZN16(Registers.A.W);
}

static INLINE void A_LSR8()
{
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   ICPU._Carry = Registers.AL & 1;
   Registers.AL >>= 1;
   SetZN8(Registers.AL);
}

static INLINE void LSR16()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetWord(OpAddress);
   ICPU._Carry = Work16 & 1;
   Work16 >>= 1;
   S9xSetWord(Work16, OpAddress);
   SetZN16(Work16);
}

static INLINE void LSR8()
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work8 = S9xGetByte(OpAddress);
   ICPU._Carry = Work8 & 1;
   Work8 >>= 1;
   S9xSetByte(Work8, OpAddress);
   SetZN8(Work8);
}

static INLINE void ORA16()
{
   Registers.A.W |= S9xGetWord(OpAddress);
   SetZN16(Registers.A.W);
}

static INLINE void ORA8()
{
   Registers.AL |= S9xGetByte(OpAddress);
   SetZN8(Registers.AL);
}

static INLINE void A_ROL16()
{
   uint32 Work32;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work32 = (Registers.A.W << 1) | CheckCarry();
   ICPU._Carry = Work32 >= 0x10000;
   Registers.A.W = (uint16) Work32;
   SetZN16((uint16) Work32);
}

static INLINE void A_ROL8()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16   = Registers.AL;
   Work16 <<= 1;
   Work16  |= CheckCarry();
   ICPU._Carry = Work16 >= 0x100;
   Registers.AL = (uint8) Work16;
   SetZN8((uint8) Work16);
}

static INLINE void ROL16()
{
   uint32 Work32;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work32 = S9xGetWord(OpAddress);
   Work32 <<= 1;
   Work32 |= CheckCarry();
   ICPU._Carry = Work32 >= 0x10000;
   S9xSetWord((uint16) Work32, OpAddress);
   SetZN16((uint16) Work32);
}

static INLINE void ROL8()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetByte(OpAddress);
   Work16 <<= 1;
   Work16 |= CheckCarry();
   ICPU._Carry = Work16 >= 0x100;
   S9xSetByte((uint8) Work16, OpAddress);
   SetZN8((uint8) Work16);
}

static INLINE void A_ROR16()
{
   uint32 Work32;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work32 = Registers.A.W;
   Work32 |= (int) CheckCarry() << 16;
   ICPU._Carry = (uint8)(Work32 & 1);
   Work32 >>= 1;
   Registers.A.W = (uint16) Work32;
   SetZN16((uint16) Work32);
}

static INLINE void A_ROR8()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = Registers.AL | ((uint16) CheckCarry() << 8);
   ICPU._Carry = (uint8) Work16 & 1;
   Work16 >>= 1;
   Registers.AL = (uint8) Work16;
   SetZN8((uint8) Work16);
}

static INLINE void ROR16()
{
   uint32 Work32;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work32 = S9xGetWord(OpAddress);
   Work32 |= (int) CheckCarry() << 16;
   ICPU._Carry = (uint8)(Work32 & 1);
   Work32 >>= 1;
   S9xSetWord((uint16) Work32, OpAddress);
   SetZN16((uint16) Work32);
}

static INLINE void ROR8()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetByte(OpAddress);
   Work16 |= (int) CheckCarry() << 8;
   ICPU._Carry = (uint8)(Work16 & 1);
   Work16 >>= 1;
   S9xSetByte((uint8) Work16, OpAddress);
   SetZN8((uint8) Work16);
}

static INLINE void SBC16()
{
   uint16 Work16 = S9xGetWord(OpAddress);

   if (CheckDecimal())
   {
      uint16 Ans16;
      uint8 A1 = (Registers.A.W) & 0xF;
      uint8 A2 = (Registers.A.W >> 4) & 0xF;
      uint8 A3 = (Registers.A.W >> 8) & 0xF;
      uint8 A4 = (Registers.A.W >> 12) & 0xF;
      uint8 W1 = Work16 & 0xF;
      uint8 W2 = (Work16 >> 4) & 0xF;
      uint8 W3 = (Work16 >> 8) & 0xF;
      uint8 W4 = (Work16 >> 12) & 0xF;

      A1 -= W1 + !CheckCarry();
      A2 -= W2;
      A3 -= W3;
      A4 -= W4;
      if (A1 > 9)
      {
         A1 += 10;
         A2--;
      }
      if (A2 > 9)
      {
         A2 += 10;
         A3--;
      }
      if (A3 > 9)
      {
         A3 += 10;
         A4--;
      }
      if (A4 > 9)
      {
         A4 += 10;
         ClearCarry();
      }
      else
         SetCarry();

      Ans16 = (A4 << 12) | (A3 << 8) | (A2 << 4) | (A1);
      if ((Registers.A.W ^ Work16) &
            (Registers.A.W ^ Ans16) & 0x8000)
         SetOverflow();
      else
         ClearOverflow();
      Registers.A.W = Ans16;
      SetZN16(Registers.A.W);
   }
   else
   {

      long s9xInt32 = (long) Registers.A.W - (long) Work16 + (long) CheckCarry() - 1;

      ICPU._Carry = s9xInt32 >= 0;

      if ((Registers.A.W ^ Work16) &
            (Registers.A.W ^ (uint16) s9xInt32) & 0x8000)
         SetOverflow();
      else
         ClearOverflow();
      Registers.A.W = (uint16) s9xInt32;
      SetZN16(Registers.A.W);
   }
}

static INLINE void SBC8()
{
   uint8 Work8 = S9xGetByte(OpAddress);
   if (CheckDecimal())
   {
      uint8 Ans8;
      uint8 A1 = (Registers.A.W) & 0xF;
      uint8 A2 = (Registers.A.W >> 4) & 0xF;
      uint8 W1 = Work8 & 0xF;
      uint8 W2 = (Work8 >> 4) & 0xF;

      A1 -= W1 + !CheckCarry();
      A2 -= W2;
      if (A1 > 9)
      {
         A1 += 10;
         A2--;
      }
      if (A2 > 9)
      {
         A2 += 10;
         ClearCarry();
      }
      else
         SetCarry();

      Ans8 = (A2 << 4) | A1;
      if ((Registers.AL ^ Work8) &
            (Registers.AL ^ Ans8) & 0x80)
         SetOverflow();
      else
         ClearOverflow();
      Registers.AL = Ans8;
      SetZN8(Registers.AL);
   }
   else
   {
      short s9xInt16 = (short) Registers.AL - (short) Work8 + (short) CheckCarry() - 1;

      ICPU._Carry = s9xInt16 >= 0;
      if ((Registers.AL ^ Work8) &
            (Registers.AL ^ (uint8) s9xInt16) & 0x80)
         SetOverflow();
      else
         ClearOverflow();
      Registers.AL = (uint8) s9xInt16;
      SetZN8(Registers.AL);
   }
}

static INLINE void STA16()
{
   S9xSetWord(Registers.A.W, OpAddress);
}

static INLINE void STA8()
{
   S9xSetByte(Registers.AL, OpAddress);
}

static INLINE void STX16()
{
   S9xSetWord(Registers.X.W, OpAddress);
}

static INLINE void STX8()
{
   S9xSetByte(Registers.XL, OpAddress);
}

static INLINE void STY16()
{
   S9xSetWord(Registers.Y.W, OpAddress);
}

static INLINE void STY8()
{
   S9xSetByte(Registers.YL, OpAddress);
}

static INLINE void STZ16()
{
   S9xSetWord(0, OpAddress);
}

static INLINE void STZ8()
{
   S9xSetByte(0, OpAddress);
}

static INLINE void TSB16()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetWord(OpAddress);
   ICPU._Zero = (Work16 & Registers.A.W) != 0;
   Work16 |= Registers.A.W;
   S9xSetWord(Work16, OpAddress);
}

static INLINE void TSB8()
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work8 = S9xGetByte(OpAddress);
   ICPU._Zero = Work8 & Registers.AL;
   Work8 |= Registers.AL;
   S9xSetByte(Work8, OpAddress);
}

static INLINE void TRB16()
{
   uint16 Work16;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work16 = S9xGetWord(OpAddress);
   ICPU._Zero = (Work16 & Registers.A.W) != 0;
   Work16 &= ~Registers.A.W;
   S9xSetWord(Work16, OpAddress);
}

static INLINE void TRB8()
{
   uint8 Work8;
#ifdef VAR_CYCLES
   CPU.Cycles += ONE_CYCLE;
#endif
   Work8 = S9xGetByte(OpAddress);
   ICPU._Zero = Work8 & Registers.AL;
   Work8 &= ~Registers.AL;
   S9xSetByte(Work8, OpAddress);
}
#endif
