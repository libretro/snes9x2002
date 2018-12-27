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
#ifndef _DISPLAY_H_
#define _DISPLAY_H_

// Routines the port specific code has to implement
void S9xSetPalette();
void S9xTextMode();
void S9xGraphicsMode();
uint32 S9xReadJoypad(int which1_0_to_4);
bool8_32 S9xReadMousePosition(int which1_0_to_1, int* x, int* y, uint32* buttons);
bool8_32 S9xReadSuperScopePosition(int* x, int* y, uint32* buttons);

void S9xInitDisplay(int argc, char** argv);
void S9xDeinitDisplay();
void S9xInitInputDevices();
void S9xSetTitle(const char* title);
void S9xProcessEvents(bool8_32 block);
void S9xPutImage(int width, int height);
void S9xToggleSoundChannel(int channel);
void S9xSetInfoString(const char* string);
void S9xNextController();

const char* S9xBasename(const char* filename);

const char* S9xGetHomeDirectory();
const char* S9xGetSnapshotDirectory();
const char* S9xGetROMDirectory();
const char* S9xGetSRAMFilename();
const char* S9xGetFilename(const char* extension);

#endif
