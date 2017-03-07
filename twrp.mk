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


RECOVERY_VARIANT := twrp

PRODUCT_COPY_FILES += \
	$(DEVICE_PATH)/rootdir/etc/twrp.fstab:recovery/root/etc/twrp.fstab \
	bionic/libc/zoneinfo/tzdata:recovery/root/system/usr/share/zoneinfo/tzdata

TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/twrp.fstab

TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"

RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/soc/78db000.usb/msm_hsusb/gadget/lun%d/file"

TW_THEME := portrait_hdpi

TW_NO_SCREEN_TIMEOUT := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 162
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"

TW_INCLUDE_CRYPTO := true
TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/cryptfs_hw

# TW_EXCLUDE_SUPERSU := true
TW_HAS_DOWNLOAD_MODE := true

# TW_MTP_DEVICE := "/dev/mtp_usb"

# TW_TARGET_USES_QCOM_BSP := true
TW_NEW_ION_HEAP := true

# TW_USE_TOOLBOX := true

TW_EXTRA_LANGUAGES := true

# TW_NO_EXFAT_FUSE := true
TW_INCLUDE_NTFS_3G := true

TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
