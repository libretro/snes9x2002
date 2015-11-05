DEBUG=0
TARGET_NAME = pocketsnes

ifeq ($(platform),)
platform = unix
ifeq ($(shell uname -a),)
   platform = win
else ifneq ($(findstring MINGW,$(shell uname -a)),)
   platform = win
else ifneq ($(findstring Darwin,$(shell uname -a)),)
   platform = osx
else ifneq ($(findstring win,$(shell uname -a)),)
   platform = win
endif
endif

ifeq ($(platform), unix)
   TARGET := libretro.so
   fpic := -fPIC
   SHARED := -shared -Wl,--version-script=libretro/link.T
else ifeq ($(platform), osx)
   TARGET := libretro.dylib
   fpic := -fPIC
   SHARED := -dynamiclib
else ifeq ($(platform), ps3)
   TARGET := libretro.a
   CC = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-gcc.exe
   AR = $(CELL_SDK)/host-win32/ppu/bin/ppu-lv2-ar.exe
   CFLAGS += -DBLARGG_BIG_ENDIAN=1 -D__ppc__
   STATIC_LINKING := 1
else ifeq ($(platform), sncps3)
   TARGET := libretro.a
   CC = $(CELL_SDK)/host-win32/sn/bin/ps3ppusnc.exe
   AR = $(CELL_SDK)/host-win32/sn/bin/ps3snarl.exe
   CFLAGS += -DBLARGG_BIG_ENDIAN=1 -D__ppc__
   STATIC_LINKING := 1
else ifeq ($(platform), xenon)
   TARGET := libretro.a
   CC = xenon-gcc
   AR = xenon-ar
   CFLAGS += -D__LIBXENON__ -m32 -D__ppc__
   STATIC_LINKING := 1
else ifeq ($(platform), wii)
   TARGET := libretro.a
   CC = $(DEVKITPPC)/bin/powerpc-eabi-gcc
   AR = $(DEVKITPPC)/bin/powerpc-eabi-ar
   CFLAGS += -DGEKKO -mrvl -mcpu=750 -meabi -mhard-float -DBLARGG_BIG_ENDIAN=1 -D__ppc__
   STATIC_LINKING := 1
# CTR (3DS)
else ifeq ($(platform), ctr)
   TARGET := $(TARGET_NAME)_libretro_ctr.a
   CC = $(DEVKITARM)/bin/arm-none-eabi-gcc$(EXE_EXT)
   CXX = $(DEVKITARM)/bin/arm-none-eabi-g++$(EXE_EXT)
   AR = $(DEVKITARM)/bin/arm-none-eabi-ar$(EXE_EXT)
   CFLAGS += -DARM11 -D_3DS
   CFLAGS += -march=armv6k -mtune=mpcore -mfloat-abi=hard
   CFLAGS += -Wall -mword-relocations
   CFLAGS += -fomit-frame-pointer -ffast-math
   CFLAGS += -D_3DS
   PLATFORM_DEFINES := -D_3DS
   STATIC_LINKING := 1
else
   TARGET := retro.dll
   CC = gcc
   fpic := 
   LD_FLAGS := 
   SHARED := -shared -static-libgcc -static-libstdc++ -Wl,--version-script=libretro/link.T
   CFLAGS += -D__WIN32__ -D__WIN32_LIBRETRO__
endif

ifeq ($(DEBUG), 1)
CFLAGS += -O0 -g
else
CFLAGS += -O3
endif


OBJECTS  =
OBJECTS += ./src/apu.o
OBJECTS += ./src/apuaux.o
OBJECTS += ./src/c4.o
OBJECTS += ./src/c4emu.o
OBJECTS += ./src/cheats.o
OBJECTS += ./src/cheats2.o
OBJECTS += ./src/clip.o
OBJECTS += ./src/data.o
OBJECTS += ./src/dsp1.o
OBJECTS += ./src/fxemu.o
OBJECTS += ./src/fxinst.o
OBJECTS += ./src/globals.o
OBJECTS += ./src/ppu.o
OBJECTS += ./src/dma.o
OBJECTS += ./src/memmap.o
OBJECTS += ./src/cpu.o
OBJECTS += ./src/cpuexec.o
OBJECTS += ./src/cpuops.o
OBJECTS += ./src/sa1.o
OBJECTS += ./src/sa1cpu.o
OBJECTS += ./src/sdd1.o
OBJECTS += ./src/sdd1emu.o
OBJECTS += ./src/snapshot.o
OBJECTS += ./src/soundux.o
OBJECTS += ./src/spc700.o
OBJECTS += ./src/spc700a.o
OBJECTS += ./src/srtc.o
OBJECTS += ./src/spc_decode.o
OBJECTS += ./src/tile16.o
OBJECTS += ./src/tile16add.o
OBJECTS += ./src/tile16add1_2.o
OBJECTS += ./src/tile16fadd1_2.o
OBJECTS += ./src/tile16sub.o
OBJECTS += ./src/tile16sub1_2.o
OBJECTS += ./src/tile16fsub1_2.o
OBJECTS += ./src/mode7new.o
OBJECTS += ./src/mode7.o
OBJECTS += ./src/mode7add.o
OBJECTS += ./src/mode7add1_2.o
OBJECTS += ./src/mode7sub.o
OBJECTS += ./src/mode7sub1_2.o
OBJECTS += ./src/mode7prio.o
OBJECTS += ./src/mode7addprio.o
OBJECTS += ./src/mode7add1_2prio.o
OBJECTS += ./src/mode7subprio.o
OBJECTS += ./src/mode7sub1_2prio.o
OBJECTS += ./src/gfx16.o
OBJECTS += ./src/rops.o
OBJECTS += ./libretro/libretro.o
OBJECTS += ./libretro/memstream.o


OBJECTS += ./src/os9x_65c816_global.o
OBJECTS += ./src/os9x_65c816_spcasm.o
OBJECTS += ./src/os9x_65c816_spcc.o

OBJECTS += ./src/os9x_65c816.o

OBJECTS += ./src/os9x_asm_cpu.o

#CFLAGS += -D__GP2X__
#CFLAGS += -DASMCPU
#CFLAGS += -DVAR_CYCLES
#CFLAGS += -D_C_GW_
##COPT = -DUSE_SA1
# -DFAST_LSB_WORD_ACCESS
#CFLAGS += -ffast-math
#CFLAGS += -msoft-float
#CFLAGS += -finline -finline-functions -fexpensive-optimizations
#CFLAGS += -falign-functions=16 -falign-loops -falign-labels
#CFLAGS += -falign-jumps
#CFLAGS += -fomit-frame-pointer
#CFLAGS += -fstrict-aliasing -mstructure-size-boundary=32 -fweb -fsigned-char -frename-registers


INCLUDES   = -I. -Ilibretro
DEFINES    = -DHAVE_STRINGS_H -DHAVE_STDINT_H -DHAVE_INTTYPES_H -D__LIBRETRO__ -DINLINE=inline -DUSE_SA1

ifeq ($(platform), sncps3)
WARNINGS_DEFINES =
CODE_DEFINES =
else
WARNINGS_DEFINES = -Wall -W -Wno-unused-parameter -Wno-parentheses -Wno-write-strings -Wno-comment
CODE_DEFINES = -fomit-frame-pointer
endif

COMMON_DEFINES += $(CODE_DEFINES) $(WARNINGS_DEFINES) -DNDEBUG=1 $(fpic)

CFLAGS     += $(DEFINES) $(COMMON_DEFINES)

all: $(TARGET)

$(TARGET): $(OBJECTS)
ifeq ($(STATIC_LINKING), 1)
	$(AR) rcs $@ $(OBJECTS)
else
	$(CXX) $(fpic) $(SHARED) $(INCLUDES) -o $@ $(OBJECTS) -lm
endif

%.o: %.c
	$(CC) $(INCLUDES) $(CFLAGS) -c -o $@ $<

%.o: %.cpp
	$(CXX) $(INCLUDES) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CXX) $(INCLUDES) $(CFLAGS) -Wa,-I./src/ -c -o $@ $<

%.o: %.S
	$(CXX) $(INCLUDES) $(CFLAGS) -Wa,-I./src/ -c -o $@ $<

clean:
	rm -f $(OBJECTS) $(TARGET)

.PHONY: clean

