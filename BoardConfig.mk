#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifeq ($(TARGET_ARCH),)
TARGET_ARCH := arm
endif

BOARD_VENDOR := lge

TARGET_OTA_ASSERT_DEVICE := ph2n,k550,ms550

DEVICE_PATH := device/lge/ph2n
KERNEL_PATH := kernel/lge/ph2n

# TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-eabi-

## Platform
TARGET_BOARD_PLATFORM := msm8937
TARGET_BOARD_PLATFORM_GPU := qcom-adreno505

## Bootloader
TARGET_BOOTLOADER_BOARD_NAME := msm8937
TARGET_BOARD_SUFFIX := _32
BOOTLOADER_GCC_VERSION := arm-eabi-4.8
BOOTLOADER_PLATFORM := msm8952 # use 8952 LK configuration
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

## CPU
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
# MALLOC_SVELTE := true

ENABLE_CPUSETS := true

## Init
# TARGET_INIT_VENDOR_LIB := libinit_msm
# BOARD_HAL_STATIC_LIBRARIES := libhealthd.msm
TARGET_PLATFORM_DEVICE_BASE := /devices/soc/

# Kernel
TARGET_KERNEL_SOURCE := kernel/lge/ph2n
TARGET_KERNEL_CONFIG := ph2n_tmo_defconfig
# TARGET_KERNEL_CONFIG := ph2n_tmo_us-perf_defconfig
TARGET_KERNEL_VERSION := 3.18
TARGET_KERNEL_APPEND_DTB := true
# TARGET_USES_UNCOMPRESSED_KERNEL := true
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
# BOARD_KERNEL_SEPARATED_DT := true
# BOARD_KERNEL_LZ4C_DT := true

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.console=ttyHSL0
BOARD_KERNEL_CMDLINE += lpm_levels.sleep_disabled=1 user_debug=30
BOARD_KERNEL_CMDLINE += msm_rtb.filter=0x237 ehci-hcd.park=3
BOARD_KERNEL_CMDLINE += androidboot.bootdevice=7824900.sdhci
BOARD_KERNEL_CMDLINE += androidboot.hardware=ph2n
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_PAGESIZE	:= 2048
BOARD_KERNEL_BASE 		:= 0x80000000

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE		:= 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE	:= 33554432

BOARD_PERSISTIMAGE_PARTITION_SIZE	:= 33554432
BOARD_CACHEIMAGE_PARTITION_SIZE		:= 524288000
BOARD_SYSTEMIMAGE_PARTITION_SIZE	:= 3535798272
BOARD_USERDATAIMAGE_PARTITION_SIZE	:= 10887364608

BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE	:= f2fs
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE	:= ext4
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE:= ext4

BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true 
# TARGET_NOT_USE_GZIP_RECOVERY_RAMDISK := true

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true
PROTOBUF_SUPPORTED := false
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true
TARGET_NO_RPC := true

# Camera
# USE_CAMERA_STUB := true
USE_DEVICE_SPECIFIC_CAMERA := true
BOARD_QTI_CAMERA_32BIT_ONLY := true

# Wifi
WLAN_PATH = wlan-caf
BOARD_HAS_QCOM_WLAN              := true
#BOARD_HAS_QCOM_WLAN_SDK			 := true
BOARD_WLAN_DEVICE                := qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_AP           := "ap"
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_P2P          := "p2p"
WPA_SUPPLICANT_VERSION           := VER_0_8_X
TARGET_USES_WCNSS_CTRL           := true
TARGET_USES_QCOM_WCNSS_QMI       := true

# Display
BOARD_USES_ADRENO := true
TARGET_CONTINUOUS_SPLASH_ENABLED := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_OVERLAY := true
BOARD_EGL_CFG := $(DEVICE_PATH)/egl.cfg
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
HAVE_ADRENO_SOURCE:= false
#OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so
USE_OPENGL_RENDERER := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# QCRIL
TARGET_RIL_VARIANT := caf
FEATURE_QCRIL_UIM_SAP_SERVER_MODE := true

# Power
TARGET_POWERHAL_VARIANT := qcom
TARGET_TAP_TO_WAKE_NODE := /sys/devices/virtual/input/lge_touch/lpwg_data

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

# ANT+
BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true
# PRODUCT_BOOT_JARS += tcmiface tcmclient com.qti.dpmframework dpmapi com.qti.location.sdk

# QCNE (Qualcomm ConNectivity Engine)
BOARD_USES_QCNE := true
BOARD_USES_DPM := true
#Enable SSC Feature
TARGET_USES_SSC := true
#Enabling IMS Feature
TARGET_USES_IMS := true
#PCI RCS
TARGET_USES_PCI_RCS := false
#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true
# TARGET_LDPRELOAD := libNimsWrap.so

# Audio
include $(DEVICE_PATH)/audio.mk

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth
BLUETOOTH_HCI_USE_MCT := true
QCOM_BT_USE_BTNV := true

# Crypto
TARGET_HW_DISK_ENCRYPTION := true
TARGET_KEYMASTER_WAIT_FOR_QSEE := true

# Bootanimation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Media
TARGET_HAVE_SIGNED_VENUS_FW := true

# Hardware
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := \
    $(COMMON_PATH)/cmhw \
    hardware/cyanogen/cmhw

# SEPolicy
include device/qcom/sepolicy/sepolicy.mk
BOARD_SEPOLICY_DIRS	+= $(DEVICE_PATH)/sepolicy

BOARD_SECCOMP_POLICY:= $(DEVICE_PATH)/seccomp

# Keymaster
TARGET_PROVIDES_KEYMASTER := true

# Enable features in video HAL that can compile only on this platform
TARGET_USES_MEDIA_EXTENSIONS := true

# Offmode Charging
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_DISABLE_INIT_BLANK := true
BOARD_CHARGING_CMDLINE_NAME := "androidboot.mode"
BOARD_CHARGING_CMDLINE_VALUE := "chargerlogo"

# Fonts
EXTENDED_FONT_FOOTPRINT := true

## Recovery
TARGET_RECOVERY_UI_LIB := librecovery_ui_msm
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_msm
# TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_ph2n
TARGET_RELEASETOOLS_EXTENSIONS := device/qcom/common

# Recovery
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_RECOVERY_SWIPE := true
BOARD_SUPPRESS_EMMC_WIPE := true
BOARD_SUPPRESS_SECURE_ERASE := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBA_8888"
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/fstab.ph2n

# TWRP Support - Optional
ifeq ($(WITH_TWRP),true)
include $(DEVICE_PATH)/twrp.mk
endif

# Inherit from QC proprietary
ifneq ($(QCPATH),)
-include $(QCPATH)/common/msm8937_32/BoardConfigVendor.mk
# TARGET_USE_SDCLANG := true
endif
