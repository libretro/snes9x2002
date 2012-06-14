DEBUG=0

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

CC         = gcc

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
else ifeq ($(platform), sncps3)
   TARGET := libretro.a
   CC = $(CELL_SDK)/host-win32/sn/bin/ps3ppusnc.exe
   AR = $(CELL_SDK)/host-win32/sn/bin/ps3snarl.exe
   CFLAGS += -DBLARGG_BIG_ENDIAN=1 -D__ppc__
else ifeq ($(platform), xenon)
   TARGET := libretro.a
   CC = xenon-gcc
   AR = xenon-ar
   CFLAGS += -D__LIBXENON__ -m32 -D__ppc__
else ifeq ($(platform), wii)
   TARGET := libretro.a
   CC = $(DEVKITPPC)/bin/powerpc-eabi-gcc
   AR = $(DEVKITPPC)/bin/powerpc-eabi-ar
   CFLAGS += -DGEKKO -mrvl -mcpu=750 -meabi -mhard-float -DBLARGG_BIG_ENDIAN=1 -D__ppc__
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


OBJECTS    = ./src/apu.o ./src/apuaux.o ./src/c4.o ./src/c4emu.o ./src/cheats.o ./src/cheats2.o ./src/clip.o ./src/data.o ./src/screenshot.o ./src/dsp1.o ./src/fxemu.o ./src/fxinst.o ./src/globals.o ./src/loadzip.o ./src/ppu.o ./src/dma.o ./src/memmap.o ./src/cpu.o ./src/cpuexec.o ./src/cpuops.o ./src/sa1.o ./src/sa1cpu.o ./src/sdd1.o ./src/sdd1emu.o ./src/snapshot.o ./src/soundux.o ./src/spc700.o ./src/spc700a.o ./src/srtc.o ./src/spc_decode.o ./src/tile16.o ./src/tile16add.o ./src/tile16add1_2.o ./src/tile16fadd1_2.o ./src/tile16sub.o ./src/tile16sub1_2.o ./src/tile16fsub1_2.o ./src/mode7new.o ./src/mode7.o ./src/mode7add.o ./src/mode7add1_2.o ./src/mode7sub.o ./src/mode7sub1_2.o ./src/mode7prio.o ./src/mode7addprio.o ./src/mode7add1_2prio.o ./src/mode7subprio.o ./src/mode7sub1_2prio.o ./src/gfx16.o ./src/rops.o ./libretro/libretro.o ./libretro/memstream.o

INCLUDES   = -I.
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
ifeq ($(platform), ps3)
	$(AR) rcs $@ $(OBJECTS)
else ifeq ($(platform), sncps3)
	$(AR) rcs $@ $(OBJECTS)
else ifeq ($(platform), xenon)
	$(AR) rcs $@ $(OBJECTS)
else ifeq ($(platform), wii)
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

