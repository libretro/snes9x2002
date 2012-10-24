LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

APP_DIR := ../../src

LOCAL_MODULE    := retro

ifeq ($(TARGET_ARCH),arm)
LOCAL_CFLAGS += -DANDROID_ARM
LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
LOCAL_CFLAGS +=  -DANDROID_X86
endif

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS += -DANDROID_MIPS -D__mips__ -D__MIPSEL__
endif

LOCAL_SRC_FILES    += $(APP_DIR)/apu.cpp $(APP_DIR)/apuaux.cpp $(APP_DIR)/c4.cpp $(APP_DIR)/c4emu.cpp $(APP_DIR)/cheats.cpp $(APP_DIR)/cheats2.cpp $(APP_DIR)/clip.cpp $(APP_DIR)/data.cpp $(APP_DIR)/screenshot.c $(APP_DIR)/dsp1.cpp $(APP_DIR)/fxemu.cpp $(APP_DIR)/fxinst.cpp $(APP_DIR)/globals.cpp $(APP_DIR)/loadzip.cpp $(APP_DIR)/ppu.cpp $(APP_DIR)/dma.cpp $(APP_DIR)/memmap.cpp $(APP_DIR)/cpu.cpp $(APP_DIR)/cpuexec.cpp $(APP_DIR)/cpuops.cpp $(APP_DIR)/sa1.cpp $(APP_DIR)/sa1cpu.cpp $(APP_DIR)/sdd1.cpp $(APP_DIR)/sdd1emu.cpp $(APP_DIR)/snapshot.cpp $(APP_DIR)/soundux.cpp.arm $(APP_DIR)/spc700.cpp $(APP_DIR)/spc700a.s $(APP_DIR)/srtc.cpp $(APP_DIR)/spc_decode.s $(APP_DIR)/tile16.cpp.arm $(APP_DIR)/tile16add.cpp.arm $(APP_DIR)/tile16add1_2.cpp.arm $(APP_DIR)/tile16fadd1_2.cpp.arm $(APP_DIR)/tile16sub.cpp.arm $(APP_DIR)/tile16sub1_2.cpp.arm $(APP_DIR)/tile16fsub1_2.cpp.arm $(APP_DIR)/mode7new.cpp.arm $(APP_DIR)/mode7.cpp.arm $(APP_DIR)/mode7add.cpp.arm $(APP_DIR)/mode7add1_2.cpp.arm $(APP_DIR)/mode7sub.cpp.arm $(APP_DIR)/mode7sub1_2.cpp.arm $(APP_DIR)/mode7prio.cpp.arm $(APP_DIR)/mode7addprio.cpp.arm $(APP_DIR)/mode7add1_2prio.cpp.arm $(APP_DIR)/mode7subprio.cpp.arm $(APP_DIR)/mode7sub1_2prio.cpp.arm $(APP_DIR)/gfx16.cpp.arm $(APP_DIR)/rops.cpp ../libretro.cpp ../memstream.c
LOCAL_CFLAGS += -O3 -ffast-math -funroll-loops -fomit-frame-pointer  -DNDEBUG=1 -DHAVE_STRINGS_H -DHAVE_STDINT_H -DHAVE_INTTYPES_H -D__LIBRETRO__ -DINLINE=inline -DUSE_SA1 # -std=gnu99

include $(BUILD_SHARED_LIBRARY)
