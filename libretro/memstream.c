/*
 * Snes9x - Portable Super Nintendo Entertainment System (TM) emulator.
 *
 * (c) Copyright 1996 - 2001 Gary Henderson (gary.henderson@ntlworld.com) and
 *                           Jerremy Koot (jkoot@snes9x.com)
 *
 * Super FX C emulator code
 * (c) Copyright 1997 - 1999 Ivar (ivar@snes9x.com) and
 *                           Gary Henderson.
 *
 * (c) Copyright 2014 - 2016 Daniel De Matteis. (UNDER NO CIRCUMSTANCE 
 * WILL COMMERCIAL RIGHTS EVER BE APPROPRIATED TO ANY PARTY)
 *
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

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "memstream.h"

static uint8_t* g_buffer = NULL;
static size_t g_size = 0;

static size_t last_file_size = 0;

struct memstream
{
   uint8_t *m_buf;
   size_t m_size;
   size_t m_ptr;
};

void memstream_set_buffer(uint8_t *buffer, size_t size)
{
   g_buffer = buffer;
   g_size = size;
}

size_t memstream_get_last_size()
{
   return last_file_size;
}

static void memstream_init(memstream_t *stream, uint8_t *buffer, size_t max_size)
{
   stream->m_buf = buffer;
   stream->m_size = max_size;
   stream->m_ptr = 0;
}

memstream_t *memstream_open()
{
	memstream_t *stream;
   if (!g_buffer || !g_size)
      return NULL;

   stream = (memstream_t*)calloc(1, sizeof(*stream));
   memstream_init(stream, g_buffer, g_size);

   g_buffer = NULL;
   g_size = 0;
   return stream;
}

void memstream_close(memstream_t *stream)
{
   last_file_size = stream->m_ptr;
   free(stream);
}

size_t memstream_read(memstream_t *stream, void *data, size_t bytes)
{
   size_t avail = stream->m_size - stream->m_ptr;
   if (bytes > avail)
      bytes = avail;

   memcpy(data, stream->m_buf + stream->m_ptr, bytes);
   stream->m_ptr += bytes;
   return bytes;
}

size_t memstream_write(memstream_t *stream, const void *data, size_t bytes)
{
   size_t avail = stream->m_size - stream->m_ptr;
   if (bytes > avail)
      bytes = avail;

   memcpy(stream->m_buf + stream->m_ptr, data, bytes);
   stream->m_ptr += bytes;
   return bytes;
}

int memstream_seek(memstream_t *stream, int offset, int whence)
{
   size_t ptr;
   if (whence == SEEK_SET)
      ptr = offset;
   else if (whence == SEEK_CUR)
      ptr = stream->m_ptr + offset;
   else if (whence == SEEK_END)
      ptr = stream->m_size + offset;
   else
      return -1;

   if (ptr <= stream->m_size)
   {
      stream->m_ptr = ptr;
      return 0;
   }
   else
      return -1;
}

size_t memstream_pos(memstream_t *stream)
{
   return stream->m_ptr;
}

char *memstream_gets(memstream_t *stream, char *buffer, size_t len)
{
   return NULL;
}

int memstream_getc(memstream_t *stream)
{
   if (stream->m_ptr >= stream->m_size)
      return EOF;
   else
      return stream->m_buf[stream->m_ptr++];
}
