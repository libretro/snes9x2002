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
#ifndef _PORT_H_
#define _PORT_H_


// horrible mess here

int yo_rand(void);

#ifdef __SYMBIAN32__

// debug
#ifdef __DEBUG_PRINT
#undef printf
extern "C" void dprintf(char *format, ...);
#define printf dprintf
#else
#define  printf(x...)
#define dprintf(x...)
#endif

#include <string.h>

#define PIXEL_FORMAT RGB565
#undef GFX_MULTI_FORMAT

#ifndef snes9x_types_defined
#define snes9x_types_defined

typedef unsigned char bool8;
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef signed char int8;
typedef signed short int16;
typedef signed int int32;
typedef unsigned int uint32;
typedef long long int64; // correct?
#endif

#include "pixform.h"

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#if defined(__cplusplus) || defined(c_plusplus)
#define EXTERN_C extern "C"
#define START_EXTERN_C extern "C" {
#define END_EXTERN_C }
#else
#define EXTERN_C extern
#define START_EXTERN_C
#define END_EXTERN_C
#endif


#ifndef PATH_MAX
#define PATH_MAX 0x100 // == KMaxFileName
#endif

/*
#define _MAX_DIR PATH_MAX
#define _MAX_DRIVE 1
#define _MAX_FNAME PATH_MAX
#define _MAX_EXT 3
*/
#define _MAX_PATH PATH_MAX


#define ZeroMemory(a,b) memset((a),0,(b))

EXTERN_C void S9xGenerateSound ();

#define SLASH_STR "\\"
#define SLASH_CHAR '\\'

#define LSB_FIRST
#define STATIC static
#define FASTCALL 
#define INLINE inline
#define VOID void
#define PACKING __attribute__ ((packed))
#define ALIGN_BY_ONE  __attribute__ ((aligned (1), packed))
#define gp32_pause()
#define gm_memset memset
#define CHECK_SOUND()
#define CPU_SHUTDOWN
#define VAR_CYCLES
#define SPC700_C
#define EXECUTE_SUPERFX_PER_LINE
#define OLD_COLOUR_BLENDING
#define _NEWPPU_
#define gp32_atoi atoi
//#define SPC700_SHUTDOWN // incompatible with ASM_SPC700
// notaz
//#define ASM_SPC700
#define SUPER_FX

#ifndef TITLE
#define TITLE "Snes9x"
#endif


#else // __SYMBIAN32__


//#include <limits.h>

#ifdef __GP32__


//#define __GP32_APUCACHE__

#define CHECK_SOUND()

#define VERSION_MAJOR 0
#define VERSION_MINOR 3

long *gp32_fopen (char *fname,char *mode);
void gp32_fclose (long *s);
long gp32_fread (unsigned char *ptr,long lg,long *s);
long gp32_fwrite (unsigned char *ptr,long lg,long *s);
void gp32_fseek (long position,int ref,long *s);


//#undef ZLIB
//#define ZLIB
#define UNZIP_SUPPORT


#define SPC700_SHUTDOWN
#define CPU_SHUTDOWN
#define VAR_CYCLES
#define SPC700_C
//#define ZSNES_C4
//#define ZSNES_FX
#define EXECUTE_SUPERFX_PER_LINE
//#define THREADCPU


//#define USE_GLIDE
//#define USE_OPENGL
//#define NETPLAY_SUPPORT
//#define FMOD_SUPPORT
#define OLD_COLOUR_BLENDING

#endif // __GP32__

#ifndef STORM
#ifdef __GP32__

extern "C"
{
#include "gpdef.h"
#include "gpstdlib.h"
#include "gpgraphic.h"
#include "gpfont.h"
#include "gpmm.h"
#include "gpmem.h"
#include "gpstdio.h"
}

#undef byte
#undef word
#undef dword
#undef qword

/*typedef unsigned long	bool8_32;
typedef unsigned long	uint8_32;
typedef unsigned long	uint16_32;
typedef long			int8_32;
typedef long			int16_32;*/

#undef time_t
#define time_t long

char *gp32_strrchr(char *s, char c);
char gp32_toupper(char c);
char *gp32_strupr(char *s);
char *gp32_strlwr(char *s);
int gp32_memcmp(char *s1,char *s2, int lg);
int gp32_strncmp(char *s1,char *s2, int lg);
int    gp32_strcasecmp(const char *s1, const char *s2 );
int    gp32_strncasecmp(const char *s1, const char *s2, unsigned n);
long	gp32_time(void);
int gp32_pause(void);
int gp32_atoi(char *s);

#define malloc gm_malloc
#define free gm_free
#define memcpy gm_memcpy

#define strcpy gm_strcpy
#define strncpy gm_strncpy
#define strcat gm_strcat
#define memset gm_memset
#define memmove gm_memcpy
#define strlen gm_lstrlen
#define strcmp gm_compare
#define memcmp(a,b,c) gp32_memcmp((char*)a,(char*)b,c)
#define strrchr(a,b) gp32_strrchr((char*)a,(char)b)
#define strncmp(a,b,c) gp32_strncmp((char*)a,(char*)b,(int)c)
#define strlwr gp32_strlwr
//#define atoi gp32_atoi

#define islower(a) ((a>='a')&&(a<='z'))
#define isdigit(a) ((a>='0')&&(a<='9'))
#define isalpha(a) (((a>='0')&&(a<='9'))||((a>='0')&&(a<='9'))||((a>='A')&&(a<='Z')))
#define toupper(a) (islower(a)?a+'A'-'a':a)

#define sprintf gm_sprintf



void gp32_printf(char *a);
void gp32_GpTextOut(unsigned char *buffer,int X,int Y,char *A,int col,int bold);
void gp32_GpTextOutBig(unsigned char *buffer,int X,int Y,char *A,int col,int bold);
#define printf  //(a) gp32_printf(a)

#define strcasecmp gp32_strcasecmp
#define strncasecmp gp32_strncasecmp

#define time(a) gp32_time()

#define _NEWPPU_

//#define PROFILING

#ifdef PROFILING
void gp32_profile_start(int a);
void gp32_profile_end(int a);
#define PROF_START(a) gp32_profile_start(a)
#define PROF_END(a) gp32_profile_end(a)
#endif

#elif  defined(__SYMBIAN32__) // /__GP32__
#include <string.h>
#else
#include <memory.h>
#include <string.h>
#endif
#else // #ifndef STORM
#include <strings.h>
#include <clib/powerpc_protos.h>
#endif

//#include <sys/types.h>

#define PIXEL_FORMAT RGB565
#undef GFX_MULTI_FORMAT

#if defined(TARGET_OS_MAC) && TARGET_OS_MAC

#include "zlib.h"
#define ZLIB
#define EXECUTE_SUPERFX_PER_LINE
#define SOUND
#define VAR_CYCLES
#define CPU_SHUTDOWN
#define SPC700_SHUTDOWN
#define PIXEL_FORMAT RGB555
#define CHECK_SOUND()
#define M_PI 3.14159265359
#undef  _MAX_PATH

#undef DEBUGGER // Apple Universal Headers sometimes #define DEBUGGER
#undef GFX_MULTI_FORMAT

int    strncasecmp(const char *s1, const char *s2, unsigned n);
int    strcasecmp(const char *s1, const char *s2 );

#endif

#ifndef snes9x_types_defined
#define snes9x_types_defined

typedef unsigned char bool8;

#ifndef __WIN32kk__
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef signed char int8;
typedef signed short int16;
typedef signed int int32;
typedef unsigned int uint32;
#ifdef __GP32__
typedef signed __int64 int64;
//typedef signed long int64;
#else
typedef long long int64;
#endif
#else // __WIN32kk__

#ifdef __BORLANDC__
#include <systypes.h>
#else

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef signed char int8;
typedef short int16;

#ifndef WSAAPI
// winsock2.h typedefs int32 as well.
typedef long int32;
#endif

typedef unsigned int uint32;

#endif // __BORLANDC__

typedef __int64 int64;

#endif // __WIN32kk__
#endif // snes9x_types_defined
#include "pixform.h"

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifdef STORM
#define EXTERN_C
#define START_EXTERN_C
#define END_EXTERN_C
#else
#if defined(__cplusplus) || defined(c_plusplus)
#define EXTERN_C extern "C"
#define START_EXTERN_C extern "C" {
#define END_EXTERN_C }
#else
#define EXTERN_C extern
#define START_EXTERN_C
#define END_EXTERN_C
#endif
#endif

#ifndef __WIN32kk__

#ifndef PATH_MAX
#define PATH_MAX 1024
#endif

#define _MAX_DIR PATH_MAX
#define _MAX_DRIVE 1
#define _MAX_FNAME PATH_MAX
#define _MAX_EXT PATH_MAX
#define _MAX_PATH PATH_MAX

#define ZeroMemory(a,b) memset((a),0,(b))

#ifndef __WIN32__
void _makepath (char *path, const char *drive, const char *dir, const char *fname, const char *ext);
void _splitpath (const char *path, char *drive, char *dir, char *fname, char *ext);
#endif

#else // __WIN32kk__
#define strcasecmp stricmp
#define strncasecmp strnicmp
#endif

EXTERN_C void S9xGenerateSound ();

#ifdef STORM
EXTERN_C int soundsignal;
EXTERN_C void MixSound(void);
//Yes, CHECK_SOUND is getting defined correctly!
#define CHECK_SOUND if (Settings.APUEnabled) if(SetSignalPPC(0L, soundsignal) & soundsignal) MixSound
#else
#ifndef __GP32__
#define CHECK_SOUND()
#endif
#endif

#if defined (__DJGPP)||defined(__GP32__)
#define SLASH_STR "\\"
#define SLASH_CHAR '\\'
#else
#define SLASH_STR "/"
#define SLASH_CHAR '/'
#endif

#ifdef __linux
typedef void (*SignalHandler)(int);
#define SIG_PF SignalHandler
#endif

#if defined(__i386__) || defined(__i486__) || defined(__i586__) || \
    defined(__WIN32kk__) || defined(__alpha__)
#define LSB_FIRST
#define FAST_LSB_WORD_ACCESS
#define PACKING
#define ALIGN_BY_ONE

#else

#ifdef __GP32__
#define LSB_FIRST
#define STATIC static
#define FASTCALL 
#define INLINE inline
#define VOID void
#else
// must be gp2x
#define LSB_FIRST
#define STATIC static
#define FASTCALL 
#define INLINE inline
#define VOID void
#define PACKING __attribute__ ((packed))
#define ALIGN_BY_ONE  __attribute__ ((aligned (1), packed))
#define gp32_pause()
#define gm_memset memset
#define CHECK_SOUND()
#define VERSION_MAJOR 0
#define VERSION_MINOR 3
#define SPC700_SHUTDOWN
#define CPU_SHUTDOWN
#define VAR_CYCLES
#define SPC700_C
#define EXECUTE_SUPERFX_PER_LINE
#define OLD_COLOUR_BLENDING
#define _NEWPPU_
#define gp32_atoi atoi
#endif

#endif

#ifdef __sun
#define TITLE "Snes9X: Solaris"
#endif

#ifdef __linux
#define TITLE "Snes9X: Linux"
#endif

#ifndef TITLE
#define TITLE "Snes9x"
#endif

#ifdef STORM
#define STATIC
#define strncasecmp strnicmp
#else
#define STATIC static
#endif

#endif // !defined(__SYMBIAN32__)

#endif // _PORT_H_
