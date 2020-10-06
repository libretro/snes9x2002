LOCAL_PATH := $(call my-dir)

ROOT_DIR     := $(LOCAL_PATH)/..
CORE_DIR     := $(ROOT_DIR)/src
LIBRETRO_DIR := $(ROOT_DIR)/libretro

ARM_ASM        := 0
DEFINES        :=
COMMON_DEFINES :=

include $(ROOT_DIR)/Makefile.common

COREFLAGS := $(DEFINES) $(COMMON_DEFINES) $(INCLUDES)

include $(CLEAR_VARS)
LOCAL_MODULE    := retro
LOCAL_SRC_FILES := $(SOURCES)
LOCAL_CFLAGS    := -std=c99 $(COREFLAGS)
LOCAL_LDFLAGS   := -Wl,-version-script=$(LIBRETRO_DIR)/link.T
LOCAL_ARM_MODE  := arm
include $(BUILD_SHARED_LIBRARY)
