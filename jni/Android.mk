LOCAL_PATH := $(call my-dir)

ARM_ASM  = 0
SOURCES :=
DEFINES :=
COMMON_DEFINES :=

include $(CLEAR_VARS)

LOCAL_MODULE    := retro

ifeq ($(TARGET_ARCH),arm)
ARM_ASM         = 1
ASM_CPU         = 0
ASM_SPC700      = 0
LOCAL_ARM_MODE := arm
endif

ifeq ($(NDK_DEBUG),1)
DEBUG = 1
endif

CORE_DIR     := ../src
LIBRETRO_DIR := ../libretro

include ../Makefile.common

LOCAL_SRC_FILES := $(SOURCES)
LOCAL_CFLAGS    += $(DEFINES) $(COMMON_DEFINES) $(INCLUDES) -std=c99
LOCAL_ASFLAGS   += $(DEFINES) $(COMMON_DEFINES) $(INCLUDES)

include $(BUILD_SHARED_LIBRARY)
