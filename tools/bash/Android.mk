LOCAL_PATH:= $(call my-dir)

# include $(CLEAR_VARS)
# LOCAL_MODULE 		:= bash
# LOCAL_MODULE_TAGS 	:= optional
# LOCAL_MODULE_CLASS 	:= RECOVERY_EXECUTABLES
# LOCAL_SRC_FILES     := bin/bash
# LOCAL_MODULE_PATH   := $(TARGET_RECOVERY_ROOT_OUT)/sbin
# include $(BUILD_PREBUILT)

# include $(CLEAR_VARS)
# LOCAL_MODULE 		:= bash.bin
# LOCAL_MODULE_TAGS 	:= optional
# LOCAL_MODULE_CLASS 	:= RECOVERY_EXECUTABLES
# LOCAL_SRC_FILES     := bin/bash.bin
# LOCAL_MODULE_PATH   := $(TARGET_RECOVERY_ROOT_OUT)/sbin
# include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE 		:= bashrc
LOCAL_MODULE_TAGS 	:= optional
LOCAL_MODULE_CLASS	:= RECOVERY_EXECUTABLES
LOCAL_SRC_FILES     := etc/bashrc
LOCAL_MODULE_PATH   := $(TARGET_RECOVERY_ROOT_OUT)/etc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE 		:= inputrc
LOCAL_MODULE_TAGS 	:= optional
LOCAL_MODULE_CLASS	:= RECOVERY_EXECUTABLES
LOCAL_SRC_FILES     := etc/inputrc
LOCAL_MODULE_PATH   := $(TARGET_RECOVERY_ROOT_OUT)/etc
include $(BUILD_PREBUILT)
