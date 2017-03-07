LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := healthd_board.cpp
LOCAL_MODULE := libhealthd.ph2n
LOCAL_CFLAGS := -Werror
LOCAL_C_INCLUDES := system/core/healthd/include
include $(BUILD_STATIC_LIBRARY)
