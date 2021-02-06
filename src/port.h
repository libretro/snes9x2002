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
#ifndef _PORT_H_
#define _PORT_H_

/*
This port.h is really a right-of-passage for anyone trying to port the emulator
   to another platform.  It must have started out as a set of defines for a
   single platform, and instead of using define blocks as new platforms were
   added, individual coders simply added exceptions and sprinkled #ifdef and #ifndef
   statements throughout the original list.

I can't take it anymore, it's too convoluted.  So I've commented out the entire
   section, and preemptively rewritten the first #define segment the way god intended,
   with a single define-block for each target platform.
*/

/* Required Includes */
#include "pixform.h"
#include <stdint.h>
#include <limits.h>
#include <string.h>

#include <boolean.h>
#include <retro_inline.h>

//Types Defined
typedef uint8_t   bool8;
typedef uint8_t   uint8;
typedef uint16_t  uint16;
typedef uint32_t bool32;
typedef uint32_t uint32;
typedef int8_t     int8;
typedef int16_t        int16;
typedef int32_t          int32;
typedef int64_t    int64;

//For Debugging Purposes:

typedef unsigned char   bool8_32;
typedef unsigned char   uint8_32;
typedef unsigned short  uint16_32;
typedef signed char     int8_32;
typedef short        int16_32;


//Path Defines
#ifndef PATH_MAX
#define PATH_MAX	1024
#endif

#ifndef _MAX_DRIVE
#define _MAX_DRIVE	1
#endif

#ifndef _MAX_PATH
#define _MAX_PATH	PATH_MAX
#endif

//True/False Defines
#define TRUE 1
#define FALSE 0

//Slash Char Definitions
#define SLASH_STR "/"
#define SLASH_CHAR '/'

//Misc Items
#define VAR_CYCLES
//#define SPC700_SHUTDOWN
#define FASTCALL
#if defined(PS2)
#define PIXEL_FORMAT BGR555
#else 
#define PIXEL_FORMAT RGB565
#endif
#define CPU_SHUTDOWN
#define PACKING __attribute__ ((packed))
#define ALIGN_BY_ONE  __attribute__ ((aligned (1), packed))
#undef  FAST_LSB_WORD_ACCESS
#define SUPER_FX
#if defined(ASM_SPC700) && defined(SPC700_SHUTDOWN)
#undef SPC700_SHUTDOWN
#endif

void S9xGenerateSound(void);

#ifndef _MSC_VER
void _makepath(char* path, const char* drive, const char* dir,
               const char* fname, const char* ext);
void _splitpath(const char* path, char* drive, char* dir, char* fname,
                char* ext);
#endif

#define strcasecmp strcmp
#define strncasecmp strncmp

#endif //  _PORT_H_
