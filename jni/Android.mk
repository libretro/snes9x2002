LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := retro

ifeq ($(TARGET_ARCH),arm)
ARM_ASM         = 1
LOCAL_CFLAGS   += -DANDROID_ARM
LOCAL_ARM_MODE := arm
endif

ifeq ($(TARGET_ARCH),x86)
LOCAL_CFLAGS   +=  -DANDROID_X86
endif

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS   += -DANDROID_MIPS -D__mips__ -D__MIPSEL__
endif

ifeq ($(NDK_DEBUG),1)
DEBUG = 1
endif

CORE_DIR     := ../src
LIBRETRO_DIR := ../libretro

include ../Makefile.common

LOCAL_SRC_FILES := $(SOURCES)
LOCAL_CFLAGS    += $(DEFINES) $(COMMON_DEFINES) $(INCLUDES) --std=c99
LOCAL_ASFLAGS   += $(DEFINES) $(COMMON_DEFINES) $(INCLUDES)

include $(BUILD_SHARED_LIBRARY)
