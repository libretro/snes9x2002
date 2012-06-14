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
#ifndef _apumemory_h_
#define _apumemory_h_

START_EXTERN_C
extern uint8 W4;
extern uint8 APUROM[64];
END_EXTERN_C

// TODO: restore nondebug version

INLINE uint8 S9xAPUGetByteZ (uint8 Address)
{
	uint8 res = 0;
	pIAPU->memread_addr = Address;

    if (Address >= 0xf0 && pIAPU->DirectPage == pIAPU->RAM)
    {
		if (Address >= 0xf4 && Address <= 0xf7)
		{
#ifdef SPC700_SHUTDOWN
			pIAPU->WaitAddress2 = pIAPU->WaitAddress1;
			pIAPU->WaitAddress1 = pIAPU->PC;
#endif	    
			res = (pIAPU->RAM [Address]);
		}
		else if (Address >= 0xfd)
		{
#ifdef SPC700_SHUTDOWN
			pIAPU->WaitAddress2 = pIAPU->WaitAddress1;
			pIAPU->WaitAddress1 = pIAPU->PC;
#endif	    
			uint8 t = pIAPU->RAM [Address];
			if(pIAPU != &IAPU)
				pIAPU->RAM [Address] = 0;
			res = (t);
		}
		else if (Address == 0xf3) {
			res = (S9xGetAPUDSP ());
		}
		else res = (pIAPU->RAM [Address]);
    }
    else
		res = (pIAPU->DirectPage [Address]);

	pIAPU->memread_data = res;
	return res;
}

INLINE void S9xAPUSetByteZ (uint8 val, uint8 Address)
{
	pIAPU->memwrite_addr = Address;
	pIAPU->memwrite_data = val;

	if(pIAPU == &IAPU) return;

	if (Address >= 0xf0 && pIAPU->DirectPage == pIAPU->RAM)
    {
	if (Address == 0xf3)
	    S9xSetAPUDSP (val);
	else
	if (Address >= 0xf4 && Address <= 0xf7)
	    APU.OutPorts [Address - 0xf4] = val;
	else
	if (Address == 0xf1)
	    S9xSetAPUControl (val);
	else
	if (Address < 0xfd)
	{
	    pIAPU->RAM [Address] = val;
	    if (Address >= 0xfa)
	    {
		if (val == 0)
		    APU.TimerTarget [Address - 0xfa] = 0x100;
		else
		    APU.TimerTarget [Address - 0xfa] = val;
	    }
	}
    }
    else
	pIAPU->DirectPage [Address] = val;
}

INLINE uint8 S9xAPUGetByte (uint32 Address)
{
    Address &= 0xffff;
    uint8 res = 0;
	pIAPU->memread_addr = Address;

    if (Address <= 0xff && Address >= 0xf0)
    {
		if (Address >= 0xf4 && Address <= 0xf7)
		{
#ifdef SPC700_SHUTDOWN
			pIAPU->WaitAddress2 = pIAPU->WaitAddress1;
			pIAPU->WaitAddress1 = pIAPU->PC;
#endif	    
			res = (pIAPU->RAM [Address]);
		}
		else if (Address == 0xf3) {
			res = (S9xGetAPUDSP ());
		}
		else if (Address >= 0xfd)
		{
#ifdef SPC700_SHUTDOWN
			pIAPU->WaitAddress2 = pIAPU->WaitAddress1;
			pIAPU->WaitAddress1 = pIAPU->PC;
#endif
			uint8 t = pIAPU->RAM [Address];
			if(pIAPU != &IAPU)
				pIAPU->RAM [Address] = 0;
			res = (t);
		}
		else res = (pIAPU->RAM [Address]);
    }
    else
		res = (pIAPU->RAM [Address]);

	pIAPU->memread_data = res;
	return res;
}

INLINE void S9xAPUSetByte (uint8 val, uint32 Address)
{
    Address &= 0xffff;
	pIAPU->memwrite_addr = Address;
	pIAPU->memwrite_data = val;

	if(pIAPU == &IAPU) return;

	if (Address <= 0xff && Address >= 0xf0)
    {
	if (Address == 0xf3)
	    S9xSetAPUDSP (val);
	else
	if (Address >= 0xf4 && Address <= 0xf7)
	    APU.OutPorts [Address - 0xf4] = val;
	else
	if (Address == 0xf1)
	    S9xSetAPUControl (val);
	else
	if (Address < 0xfd)
	{
	    pIAPU->RAM [Address] = val;
	    if (Address >= 0xfa)
	    {
		if (val == 0)
		    APU.TimerTarget [Address - 0xfa] = 0x100;
		else
		    APU.TimerTarget [Address - 0xfa] = val;
	    }
	}
    }
    else
    {
#if 0
if (Address >= 0x2500 && Address <= 0x2504)
printf ("%06d %04x <- %02x\n", ICPU.Scanline, Address, val);
if (Address == 0x26c6)
{
    extern FILE *apu_trace;
    extern FILE *trace;
    APU.Flags |= TRACE_FLAG;
    CPU.Flags |= TRACE_FLAG;
    if (apu_trace == NULL)
	apu_trace = fopen ("aputrace.log", "wb");
    if (trace == NULL)
	trace = fopen ("trace.log", "wb");
    printf ("TRACING SWITCHED ON\n");
}
#endif
	if (Address < 0xffc0)
	    pIAPU->RAM [Address] = val;
	else
	{
	    APU.ExtraRAM [Address - 0xffc0] = val;
	    if (!APU.ShowROM)
		pIAPU->RAM [Address] = val;
	}
    }
}

#endif
