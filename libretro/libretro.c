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

#include <stdint.h>
#include <boolean.h>
#ifdef _MSC_VER
#include <direct.h>
#else
#include <unistd.h>
#endif
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

#include <libretro.h>
#include <streams/memory_stream.h>
#include "libretro_core_options.h"

#include "../src/snes9x.h"
#include "../src/memmap.h"
#include "../src/cpuexec.h"
#include "../src/srtc.h"
#include "../src/apu.h"
#include "../src/ppu.h"
#include "../src/snapshot.h"
#include "../src/soundux.h"
#include "../src/cheats.h"
#include "../src/display.h"
#include "../src/os9x_asm_cpu.h"

#ifdef _3DS
void* linearMemAlign(size_t size, size_t alignment);
void linearFree(void* mem);
#endif

#define MAP_BUTTON(id, name) S9xMapButton((id), S9xGetCommandT((name)), false)
#define MAKE_BUTTON(pad, btn) (((pad)<<4)|(btn))

#define BTN_POINTER (RETRO_DEVICE_ID_JOYPAD_R + 1)
#define BTN_POINTER2 (BTN_POINTER + 1)

static retro_video_refresh_t video_cb            = NULL;
static retro_input_poll_t poll_cb                = NULL;
static retro_input_state_t input_cb              = NULL;
static retro_audio_sample_batch_t audio_batch_cb = NULL;
static retro_environment_t environ_cb            = NULL;

static bool libretro_supports_bitmasks           = false;

static uint32 joys[5];

bool8 ROMAPUEnabled                              = 0;
bool overclock_cycles                            = false;
int one_c, slow_one_c, two_c;

typedef enum
{
   FRAMESKIP_NONE = 0,
   FRAMESKIP_AUTO,
   FRAMESKIP_AUTO_THRESHOLD,
   FRAMESKIP_FIXED_INTERVAL
} frameskip_type_t;

/* Maximum number of consecutive frames that
 * can be skipped */
#define FRAMESKIP_MAX 30

static frameskip_type_t frameskip_type           = FRAMESKIP_NONE;
static unsigned frameskip_threshold              = 0;
static unsigned frameskip_interval               = 0;
static uint16_t frameskip_counter                = 0;

static bool retro_audio_buff_active              = false;
static unsigned retro_audio_buff_occupancy       = 0;
static bool retro_audio_buff_underrun            = false;

static unsigned retro_audio_latency              = 0;
static bool update_audio_latency                 = false;

static memstream_t *s_stream                     = NULL;

static int s_open(const char *fname, const char *mode)
{
   unsigned writing = 0;

   if (mode)
      if (strcmp(mode, "wb") == 0)
         writing = 1;

   s_stream = memstream_open(writing);
   return TRUE;
}

static int s_read(void *p, int l) { return memstream_read(s_stream, p, l); }
static int s_write(void *p, int l) { return memstream_write(s_stream, p, l); }
static void s_close(void) { memstream_close(s_stream); s_stream = NULL; }

int  (*statef_open)(const char *fname, const char *mode) = s_open;
int  (*statef_read)(void *p, int l) = s_read;
int  (*statef_write)(void *p, int l) = s_write;
void (*statef_close)(void) = s_close;

void *retro_get_memory_data(unsigned type)
{
   switch(type)
   {
      case RETRO_MEMORY_SAVE_RAM:
         return Memory.SRAM;
      case RETRO_MEMORY_SYSTEM_RAM:
         return Memory.RAM;
      case RETRO_MEMORY_VIDEO_RAM:
         return Memory.VRAM;
      default:
         break;
   }

   return NULL;
}

size_t retro_get_memory_size(unsigned type)
{
   unsigned size;

   switch(type)
   {
      case RETRO_MEMORY_SAVE_RAM:
         size = (unsigned) (Memory.SRAMSize ? (1 << (Memory.SRAMSize + 3)) * 128 : 0);
         if (size > 0x20000)
            size = 0x20000;
         break;
      /*case RETRO_MEMORY_RTC:
         size = (Settings.SRTC || Settings.SPC7110RTC)?20:0;
         break;*/
      case RETRO_MEMORY_SYSTEM_RAM:
         size = 128 * 1024;
         break;
      case RETRO_MEMORY_VIDEO_RAM:
         size = 64 * 1024;
         break;
      default:
         size = 0;
         break;
   }

   return size;
}

unsigned retro_api_version(void)
{
   return RETRO_API_VERSION;
}

void retro_set_video_refresh(retro_video_refresh_t cb)
{
   video_cb = cb;
}

void retro_set_audio_sample(retro_audio_sample_t cb)
{}

void retro_set_audio_sample_batch(retro_audio_sample_batch_t cb)
{
   audio_batch_cb = cb;
}

void retro_set_input_poll(retro_input_poll_t cb)
{
   poll_cb = cb;
}

void retro_set_input_state(retro_input_state_t cb)
{
   input_cb = cb;
}

static bool use_overscan;

void retro_set_environment(retro_environment_t cb)
{
   bool option_cats_supported = false;

   environ_cb = cb;

   libretro_set_core_options(environ_cb,
		   &option_cats_supported);
}

void retro_get_system_info(struct retro_system_info *info)
{
   info->need_fullpath =   false;
   info->valid_extensions = "smc|fig|sfc|gd3|gd7|dx2|bsx|swc";
   info->library_version  = "7.2.0";
   info->library_name     = "Snes9x 2002";
   info->block_extract    = false;
}

static void retro_audio_buff_status_cb(
      bool active, unsigned occupancy, bool underrun_likely)
{
   retro_audio_buff_active    = active;
   retro_audio_buff_occupancy = occupancy;
   retro_audio_buff_underrun  = underrun_likely;
}

static void retro_set_audio_buff_status_cb(void)
{
   if (frameskip_type == FRAMESKIP_NONE)
   {
      environ_cb(RETRO_ENVIRONMENT_SET_AUDIO_BUFFER_STATUS_CALLBACK, NULL);
      retro_audio_latency = 0;
   }
   else
   {
      bool calculate_audio_latency = true;

      if (frameskip_type == FRAMESKIP_FIXED_INTERVAL)
         environ_cb(RETRO_ENVIRONMENT_SET_AUDIO_BUFFER_STATUS_CALLBACK, NULL);
      else
      {
         struct retro_audio_buffer_status_callback buf_status_cb;
         buf_status_cb.callback = retro_audio_buff_status_cb;

         if (!environ_cb(RETRO_ENVIRONMENT_SET_AUDIO_BUFFER_STATUS_CALLBACK,
               &buf_status_cb))
         {
            retro_audio_buff_active    = false;
            retro_audio_buff_occupancy = 0;
            retro_audio_buff_underrun  = false;
            retro_audio_latency        = 0;
            calculate_audio_latency    = false;
         }
      }

      if (calculate_audio_latency)
      {
         /* Frameskip is enabled - increase frontend
          * audio latency to minimise potential
          * buffer underruns */
         uint32_t frame_time_usec = Settings.FrameTime;

         /* Set latency to 6x current frame time... */
         retro_audio_latency = (unsigned)(6 * frame_time_usec / 1000);

         /* ...then round up to nearest multiple of 32 */
         retro_audio_latency = (retro_audio_latency + 0x1F) & ~0x1F;
      }
   }

   update_audio_latency = true;
   frameskip_counter    = 0;
}

#define VIDEO_REFRESH_RATE_PAL  (SNES_CLOCK_SPEED * 6.0 / (SNES_CYCLES_PER_SCANLINE * SNES_MAX_PAL_VCOUNTER))
#define VIDEO_REFRESH_RATE_NTSC (SNES_CLOCK_SPEED * 6.0 / (SNES_CYCLES_PER_SCANLINE * SNES_MAX_NTSC_VCOUNTER))
#define AUDIO_SAMPLE_RATE       32040

static int16_t *audio_out_buffer       = NULL;
static float audio_samples_per_frame   = 0.0f;
static float audio_samples_accumulator = 0.0f;

static void audio_out_buffer_init(void)
{
   float refresh_rate        = (float)((Settings.PAL) ?
         VIDEO_REFRESH_RATE_PAL : VIDEO_REFRESH_RATE_NTSC);
   float samples_per_frame   = (float)AUDIO_SAMPLE_RATE / refresh_rate;
   size_t buffer_size        = ((size_t)samples_per_frame + 1) << 1;

   audio_out_buffer          = (int16_t *)malloc(buffer_size * sizeof(int16_t));
   audio_samples_per_frame   = samples_per_frame;
   audio_samples_accumulator = 0.0f;
}

static void audio_out_buffer_deinit(void)
{
   if (audio_out_buffer)
      free(audio_out_buffer);

   audio_out_buffer          = NULL;
   audio_samples_per_frame   = 0.0f;
   audio_samples_accumulator = 0.0f;
}

static void audio_upload_samples(void)
{
   size_t available_frames    = (size_t)audio_samples_per_frame;
   audio_samples_accumulator += audio_samples_per_frame -
         (float)available_frames;

   if (audio_samples_accumulator > 1.0f)
   {
      available_frames          += 1;
      audio_samples_accumulator -= 1.0f;
   }

   S9xMixSamples(audio_out_buffer, available_frames << 1);
   audio_batch_cb(audio_out_buffer, available_frames);
}

void S9xGenerateSound(void) { }

uint32 S9xReadJoypad(int which1)
{
   if (which1 > 4)
      return 0;
   return joys[which1];
}

void retro_set_controller_port_device(unsigned in_port, unsigned device)
{
}

void retro_get_system_av_info(struct retro_system_av_info *info)
{
   info->geometry.base_width   = SNES_WIDTH;
   info->geometry.base_height  = (PPU.ScreenHeight == SNES_HEIGHT_EXTENDED) ?
         SNES_HEIGHT_EXTENDED : SNES_HEIGHT;
   info->geometry.max_width    = 512;
   info->geometry.max_height   = 512;
   info->geometry.aspect_ratio = 4.0f / 3.0f;

   info->timing.sample_rate   = AUDIO_SAMPLE_RATE;
   info->timing.fps           = Settings.PAL ?
         VIDEO_REFRESH_RATE_PAL : VIDEO_REFRESH_RATE_NTSC;
}

static void snes_init (void)
{
   const int safety = 128;

   memset(&Settings, 0, sizeof(Settings));
	Settings.JoystickEnabled = FALSE;
	Settings.SoundPlaybackRate = AUDIO_SAMPLE_RATE;
	Settings.Stereo = TRUE;
	Settings.SoundBufferSize = 0;
	Settings.CyclesPercentage = 100;
	Settings.DisableSoundEcho = FALSE;
	Settings.APUEnabled = FALSE;
	Settings.H_Max = SNES_CYCLES_PER_SCANLINE;
	Settings.SkipFrames = AUTO_FRAMERATE;
	Settings.Shutdown = Settings.ShutdownMaster = TRUE;
	Settings.FrameTimePAL = 20000;
	Settings.FrameTimeNTSC = 16667;
	Settings.FrameTime = Settings.FrameTimeNTSC;
	Settings.DisableSampleCaching = FALSE;
	Settings.DisableMasterVolume = FALSE;
	Settings.Mouse = FALSE;
	Settings.SuperScope = FALSE;
	Settings.MultiPlayer5 = FALSE;
	//	Settings.ControllerOption = SNES_MULTIPLAYER5;
	Settings.ControllerOption = 0;
	
	Settings.ForceTransparency = FALSE;
	Settings.Transparency = TRUE;
	Settings.SixteenBit = TRUE;
	
	Settings.SupportHiRes = FALSE;
	Settings.AutoSaveDelay = 30;
	Settings.ApplyCheats = TRUE;
	Settings.TurboMode = FALSE;
	Settings.TurboSkipFrames = 15;
	Settings.SoundSync = FALSE;
#ifdef ASM_SPC700
	Settings.asmspc700 = TRUE;
#endif
	Settings.SpeedHacks = TRUE;

	Settings.HBlankStart = (256 * Settings.H_Max) / SNES_HCOUNTER_MAX;

   Settings.InterpolatedSound = TRUE;

   CPU.Flags = 0;

   if (!MemoryInit() || !S9xInitAPU())
   {
      MemoryDeinit();
      S9xDeinitAPU();
      exit(1);
   }

   if (!S9xInitSound() || !S9xGraphicsInit()) exit(1);
   //S9xSetSamplesAvailableCallback(S9xAudioCallback);

   GFX.Pitch = use_overscan ? 1024 : 2048;
   
   // hack to make sure GFX.Delta is always  (2048 * 512 * 2) >> 1, needed for tile16_t.h
#ifdef _3DS
   GFX.Screen_buffer = (uint8 *) linearMemAlign(2048 * 512 * 2 * 2 + safety, 0x80);
#else
   GFX.Screen_buffer = (uint8 *) calloc(1, 2048 * 512 * 2 * 2 + safety);
#endif
   GFX.Screen = GFX.Screen_buffer + safety;

   GFX.SubScreen = GFX.Screen + 2048 * 512 * 2;
   GFX.ZBuffer_buffer = (uint8 *) calloc(1, GFX.Pitch * 512 * sizeof(uint16) + safety);
   GFX.ZBuffer = GFX.ZBuffer_buffer + safety;
   GFX.SubZBuffer_buffer = (uint8 *) calloc(1, GFX.Pitch * 512 * sizeof(uint16) + safety);
   GFX.SubZBuffer = GFX.SubZBuffer_buffer + safety;
   GFX.Delta = 1048576; //(GFX.SubScreen - GFX.Screen) >> 1;

   if (GFX.Delta != ((GFX.SubScreen - GFX.Screen) >> 1))
      exit(1);

   /* controller port 1 */
   //S9xSetController(0, CTL_JOYPAD, 0, 0, 0, 0);
   //retro_devices[0] = RETRO_DEVICE_JOYPAD;

   /* controller port 2 */
   //S9xSetController(1, CTL_JOYPAD, 1, 0, 0, 0);
   //retro_devices[1] = RETRO_DEVICE_JOYPAD;

   //S9xUnmapAllControls();
   //map_buttons();
   
   //S9xSetSoundMute(FALSE);
}

void retro_init (void)
{
   if (!environ_cb(RETRO_ENVIRONMENT_GET_OVERSCAN, &use_overscan))
	   use_overscan = FALSE;

   snes_init();

   if (environ_cb(RETRO_ENVIRONMENT_GET_INPUT_BITMASKS, NULL))
      libretro_supports_bitmasks = true;
}

/* libretro uses relative values for analogue devices. 
   S9x seems to use absolute values, but do convert these into relative values in the core. (Why?!)
   Hack around it. :) */

void retro_deinit(void)
{
   S9xDeinitAPU();
   MemoryDeinit();
   S9xGraphicsDeinit();
   //S9xUnmapAllControls();
   if(GFX.Screen_buffer)
#ifdef _3DS
      linearFree(GFX.Screen_buffer);
#else
      free(GFX.Screen_buffer);
#endif
   GFX.Screen_buffer = NULL;
   GFX.Screen = NULL;
   GFX.SubScreen = NULL;

   if(GFX.ZBuffer_buffer)
      free(GFX.ZBuffer_buffer);
   GFX.ZBuffer_buffer = NULL;

   if(GFX.SubZBuffer_buffer)
      free(GFX.SubZBuffer_buffer);

   GFX.SubZBuffer_buffer = NULL;

   audio_out_buffer_deinit();

   libretro_supports_bitmasks = false;
   frameskip_type             = FRAMESKIP_NONE;
   frameskip_threshold        = 0;
   frameskip_interval         = 0;
   frameskip_counter          = 0;
   retro_audio_buff_active    = false;
   retro_audio_buff_occupancy = 0;
   retro_audio_buff_underrun  = false;
   retro_audio_latency        = 0;
   update_audio_latency       = false;
}

void retro_reset (void)
{
   S9xReset();
}

//static int16_t retro_mouse_state[2][2] = {{0}, {0}};
//static int16_t retro_scope_state[2] = {0};
//static int16_t retro_justifier_state[2][2] = {{0}, {0}};
void S9xSetButton(int i, uint16 b, bool pressed);

static void report_buttons (void)
{
	int i, j;
	int16_t joy_bits[5] = {0};

	for (j = 0; j < 5; j++)
	{
		if (libretro_supports_bitmasks)
			joy_bits[j] = input_cb(j, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_MASK);
		else
		{
			for (i = 0; i < (RETRO_DEVICE_ID_JOYPAD_R3+1); i++)
				joy_bits[j] |= input_cb(j, RETRO_DEVICE_JOYPAD, 0, i) ? (1 << i) : 0;
		}
	}

	for (i = 0; i < 5; i++)
	{
		for (j = 0; j <= RETRO_DEVICE_ID_JOYPAD_R; j++)
		{
			if (joy_bits[i] & (1 << j))
				joys[i] |= (1 << (15 - j));
			else
				joys[i] &= ~(1 << (15 - j));
		}
	}
}

static void check_variables(bool first_run)
{
   struct retro_variable var;
   frameskip_type_t prev_frameskip_type;

   var.key = "snes9x2002_frameskip";
   var.value = NULL;

   prev_frameskip_type = frameskip_type;
   frameskip_type      = FRAMESKIP_NONE;

   if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &var) && var.value)
   {
      if (strcmp(var.value, "auto") == 0)
         frameskip_type = FRAMESKIP_AUTO;
      else if (strcmp(var.value, "auto_threshold") == 0)
         frameskip_type = FRAMESKIP_AUTO_THRESHOLD;
      else if (strcmp(var.value, "fixed_interval") == 0)
         frameskip_type = FRAMESKIP_FIXED_INTERVAL;
   }

   var.key = "snes9x2002_frameskip_threshold";
   var.value = NULL;

   frameskip_threshold = 33;

   if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &var) && var.value)
      frameskip_threshold = strtol(var.value, NULL, 10);

   var.key = "snes9x2002_frameskip_interval";
   var.value = NULL;

   frameskip_interval = 1;

   if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &var) && var.value)
      frameskip_interval = strtol(var.value, NULL, 10);

   var.key = "snes9x2002_overclock_cycles";
   var.value = NULL;

   overclock_cycles = false;

   if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE, &var) && var.value)
   {
      if (strcmp(var.value, "compatible") == 0)
      {
         overclock_cycles = true;
         one_c = 4;
         slow_one_c = 5;
         two_c = 6;
      }
      else if (strcmp(var.value, "max") == 0)
      {
         overclock_cycles = true;
         one_c = 3;
         slow_one_c = 3;
         two_c = 3;
      }
   }

   /* Reinitialise frameskipping, if required */
   if (!first_run &&
       (frameskip_type != prev_frameskip_type))
      retro_set_audio_buff_status_cb();
}

void retro_run (void)
{
   bool updated = false;

   if (environ_cb(RETRO_ENVIRONMENT_GET_VARIABLE_UPDATE, &updated) && updated)
      check_variables(false);

   IPPU.RenderThisFrame = TRUE;

   /* Check whether current frame should
    * be skipped */
   if (frameskip_type != FRAMESKIP_NONE)
   {
      bool skip_frame = false;

      switch (frameskip_type)
      {
         case FRAMESKIP_AUTO:
            skip_frame = retro_audio_buff_active &&
                  retro_audio_buff_underrun;

            if (!skip_frame ||
                (frameskip_counter >= FRAMESKIP_MAX))
            {
               skip_frame        = false;
               frameskip_counter = 0;
            }
            else
               frameskip_counter++;

            break;
         case FRAMESKIP_AUTO_THRESHOLD:
            skip_frame = retro_audio_buff_active &&
                  (retro_audio_buff_occupancy < frameskip_threshold);

            if (!skip_frame ||
                (frameskip_counter >= FRAMESKIP_MAX))
            {
               skip_frame        = false;
               frameskip_counter = 0;
            }
            else
               frameskip_counter++;

            break;
         case FRAMESKIP_FIXED_INTERVAL:
            if (frameskip_counter < frameskip_interval)
            {
               skip_frame = true;
               frameskip_counter++;
            }
            else
            {
               skip_frame        = false;
               frameskip_counter = 0;
            }
            break;
         default:
            break;
      }

      IPPU.RenderThisFrame = skip_frame ? FALSE : TRUE;
   }

   /* If frameskip/timing settings have changed,
    * update frontend audio latency
    * > Can do this before or after the frameskip
    *   check, but doing it after means we at least
    *   retain the current frame's audio output */
   if (update_audio_latency)
   {
      environ_cb(RETRO_ENVIRONMENT_SET_MINIMUM_AUDIO_LATENCY,
            &retro_audio_latency);
      update_audio_latency = false;
   }

   poll_cb();
   report_buttons();

   S9xMainLoop();
//   asm_S9xMainLoop();

   if (!IPPU.RenderThisFrame)
      video_cb(NULL, IPPU.RenderedScreenWidth, IPPU.RenderedScreenHeight, GFX_PITCH);

   audio_upload_samples();
}

size_t retro_serialize_size (void)
{
   int32 size = SnapshotSize();

   if (size < 0)
      return 0;

   return (size_t)size;
}

bool retro_serialize(void *data, size_t size)
{
   memstream_set_buffer((uint8_t*)data, size);
   if (S9xFreezeGame("") == FALSE)
      return FALSE;

   return TRUE;
}

bool retro_unserialize(const void * data, size_t size)
{
   memstream_set_buffer((uint8_t*)data, size);
   if (S9xUnfreezeGame("") == FALSE)
      return FALSE;

   return TRUE;
}

void retro_cheat_reset(void)
{
    S9xDeleteCheats();
}

void retro_cheat_set(unsigned index, bool enable, const char* in_code)
{
   /* TODO/FIXME - MSVC error C2057: expected constant expression -
    * see clean_code[strlen(in_code)];
    */
#ifndef _MSC_VER
    uint32 address;
    uint8 byte;
    char clean_code[strlen(in_code)];
    int j =0;
    unsigned i;
    for (i = 0; i < strlen(in_code); i++)          
    {
        switch (in_code[i])
        {
            case 'a': case 'A':
            case 'b': case 'B':
            case 'c': case 'C':
            case 'd': case 'D':
            case 'e': case 'E':
            case 'f': case 'F':
            
            case '-': case '0':
            case '1': case '2': case '3':
            case '4': case '5': case '6': 
            case '7': case '8': case '9':
                clean_code[j++]=in_code[i];
                break;
            default:
                break;
        }
    }
    clean_code[j]=0;
    
    if ( S9xProActionReplayToRaw(clean_code, &address, &byte) == NULL)
        S9xAddCheat(true, true, address, byte);
    else if ( S9xGameGenieToRaw(clean_code, &address, &byte) == NULL)
        S9xAddCheat(true, true, address, byte);
    /* else, silently ignore */
#endif
}

static void set_input_descriptors(void)
{
   struct retro_input_descriptor desc[] =
   {
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT,   "D-Pad Left" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP,     "D-Pad Up" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN,   "D-Pad Down" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT,  "D-Pad Right" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B,      "B" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A,      "A" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_X,      "X" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_Y,      "Y" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_L,      "L" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_R,      "R" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT, "Select" },
      { 0, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START,  "Start" },

      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT,   "D-Pad Left" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP,     "D-Pad Up" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN,   "D-Pad Down" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT,  "D-Pad Right" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B,      "B" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A,      "A" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_X,      "X" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_Y,      "Y" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_L,      "L" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_R,      "R" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT, "Select" },
      { 1, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START,  "Start" },

      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT,   "D-Pad Left" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP,     "D-Pad Up" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN,   "D-Pad Down" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT,  "D-Pad Right" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B,      "B" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A,      "A" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_X,      "X" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_Y,      "Y" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_L,      "L" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_R,      "R" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT, "Select" },
      { 2, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START,  "Start" },

      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT,   "D-Pad Left" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP,     "D-Pad Up" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN,   "D-Pad Down" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT,  "D-Pad Right" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B,      "B" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A,      "A" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_X,      "X" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_Y,      "Y" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_L,      "L" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_R,      "R" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT, "Select" },
      { 3, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START,  "Start" },

      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_LEFT,   "D-Pad Left" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_UP,     "D-Pad Up" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_DOWN,   "D-Pad Down" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_RIGHT,  "D-Pad Right" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_B,      "B" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_A,      "A" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_X,      "X" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_Y,      "Y" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_L,      "L" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_R,      "R" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_SELECT, "Select" },
      { 4, RETRO_DEVICE_JOYPAD, 0, RETRO_DEVICE_ID_JOYPAD_START,  "Start" },

      { 0 },
   };

   environ_cb(RETRO_ENVIRONMENT_SET_INPUT_DESCRIPTORS, desc);
}

bool retro_load_game(const struct retro_game_info *game)
{
   bool8 loaded;
   enum retro_pixel_format fmt = RETRO_PIXEL_FORMAT_RGB565;

   check_variables(true);

   if (!environ_cb(RETRO_ENVIRONMENT_SET_PIXEL_FORMAT, &fmt))
      return false;

   set_input_descriptors();

   /* Hack. S9x cannot do stuff from RAM. <_< */
   memstream_set_buffer((uint8_t*)game->data, game->size);

   if (!(loaded = LoadROM()))
      return false;

#if 0
   S9xGraphicsInit();
#endif
   S9xReset();
   CPU.APU_APUExecuting = Settings.APUEnabled = 1;
   Settings.SixteenBitSound = true;
   so.stereo = Settings.Stereo;
   S9xSetPlaybackRate(Settings.SoundPlaybackRate);
   S9xSetSoundMute(FALSE);

   audio_out_buffer_init();
   retro_set_audio_buff_status_cb();
   return true;
}

bool retro_load_game_special(
  unsigned game_type,
  const struct retro_game_info *info, size_t num_info
)
{ return false; }

void retro_unload_game (void) { }

unsigned retro_get_region (void)
{ 
   return Settings.PAL ? RETRO_REGION_PAL : RETRO_REGION_NTSC; 
}

bool8 S9xDeinitUpdate(int width, int height)
{
	int y;

	if (height == 448 || height == 478)
	{
		/* Pitch 2048 -> 1024, only done once per res-change. */
		if (GFX.Pitch == 2048)
		{
			for ( y = 1; y < height; y++)
			{
				uint8_t *src = GFX.Screen + y * 1024;
				uint8_t *dst = GFX.Screen + y * 512;
				memcpy(dst, src, width * sizeof(uint8_t) * 2);
			}
		}
		GFX.Pitch = 1024;
	}
	else
	{
		/* Pitch 1024 -> 2048, only done once per res-change. */
		if (GFX.Pitch == 1024)
		{
			for ( y = height - 1; y >= 0; y--)
			{
				uint8_t *src = GFX.Screen + y * 512;
				uint8_t *dst = GFX.Screen + y * 1024;
				memcpy(dst, src, width * sizeof(uint8_t) * 2);
			}
		}
		GFX.Pitch = 2048;
	}

	video_cb(GFX.Screen, width, height, GFX_PITCH);
	
	return TRUE;
}


/* Dummy functions that should probably be implemented correctly later. */
bool8 S9xContinueUpdate(int width, int height) { return TRUE; }
void S9xSetPalette(void) {}
void S9xLoadSDD1Data(void) {}
bool8 S9xReadMousePosition (int which1_0_to_1, int* x, int* y, uint32* buttons) { return FALSE; }
bool8 S9xReadSuperScopePosition (int* x, int* y, uint32* buttons) { return FALSE; }
bool JustifierOffscreen(void) { return false; }

void S9xToggleSoundChannel (int channel) {}

//void Write16(uint16 v, uint8*& ptr) {}
//uint16 Read16(const uint8*& ptr) { return 0; }

//void S9xHandlePortCommand(s9xcommand_t cmd, int16 data1, int16 data2) {}
//bool S9xPollButton(uint32 id, bool *pressed) { return false; }
//bool S9xPollPointer(uint32 id, int16 *x, int16 *y) { return false; }
//bool S9xPollAxis(uint32 id, int16 *value) { return false; }

void S9xExit(void) { exit(1); }
void S9xMessage(int a, int b, const char* msg) { }
