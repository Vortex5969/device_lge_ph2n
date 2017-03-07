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

# Inherit proprietary blobs
$(call inherit-product-if-exists, vendor/lge/ph2n/ph2n-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:system/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.camera.raw.xml:system/etc/permissions/android.hardware.camera.raw.xml \
    frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.4.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-0.xml:system/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_0_3.xml:system/etc/permissions/android.hardware.vulkan.version.xml


# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_AAPT_PREBUILT_DPI := xhdpi hdpi

# Init
PRODUCT_PACKAGES += \
    fstab.ph2n \
    ueventd.ph2n.rc \
    init.ph2n.rc \
    init.ph2n.log.rc \
    init.ph2n.power.rc \
    init.ph2n.usb.rc

PRODUCT_PACKAGES += \
	init.ph2n.sh \
	init.ph2n.class_main.sh \
	init.ph2n.coresight.sh \
	init.ph2n.crash.sh \
	init.ph2n.crda.sh \
	init.ph2n.early_boot.sh \
	init.ph2n.ims.sh \
	init.ph2n.post_boot.sh \
	init.ph2n.sensors.sh \
	init.ph2n.time_in_state.sh \
	init.ph2n.usb.sh \
	init.ph2n.zram.sh

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.ph2n.rc

PRODUCT_PACKAGES += \
    nano \
    curl \
    libcurl \
    libgpg-error \
    libinit_ph2n \
    libglgps-compat \
    vcard \
    libGLES_android \
    libopencv

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    com.dsi.ant.antradio_library \
    libantradio \
    antradio_app

PRODUCT_COPY_FILES += \
    external/ant-wireless/antradio-library/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml

# Audio
PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio.primary.msm8937 \
    audio.r_submix.default \
    audio.usb.default \
    audio_amplifier.msm8937

# Audio effects
PRODUCT_PACKAGES += \
    libqcomvoiceprocessing \
    libqcomvoiceprocessingdescriptors \
    libqcomvisualizer \
    libqcompostprocbundle \
    libvolumelistener \
    libaudio-resampler \
    tinymix

# Sensors
PRODUCT_PACKAGES += \
    sensors.msm8937

# Browser
PRODUCT_PACKAGES += \
    Gello

# Camera
PRODUCT_PACKAGES += \
    camera.msm8937 \
    mm-qcamera-app \
    libmm-qcamera \
    Snap \
    org.codeaurora.camera

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# CNE
PRODUCT_PACKAGES += \
    libcnefeatureconfig

# Compatibility
PRODUCT_PACKAGES += \
    libboringssl-compat \
    libril_shim \
    libstlport \
    libssl \
    libcrypto

# Ebtables
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    libebtc

# Filesystem management tools
PRODUCT_PACKAGES += \
	e2fsck \
	e2fsck_static \
    make_ext4fs \
	resize2fs_static \
    setup_fs \
    setup_fs_static \
    tune2fs_static \
    make_f2fs

# Connectivity Engine support (CNE)
PRODUCT_PACKAGES += \
    cneapiclient \
    com.quicinc.cne \
    services-ext

# Display
PRODUCT_PACKAGES += \
    copybit.msm8937 \
    gralloc.msm8937 \
    hwcomposer.msm8937 \
    memtrack.msm8937 \
    liboverlay

# Lights
PRODUCT_PACKAGES += \
    lights.msm8937 \

# For android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files \
    mkbootimg \
    unpackbootimg

# Fingerprint sensor
PRODUCT_PACKAGES += \
	fingerprint.ph2n \
	fingerprintd

# LPWG Service
PRODUCT_PACKAGES += \
    GestureHandler

# GPS
PRODUCT_PACKAGES += \
	gps.default \
    gps.msm8937 \
	libgps.msm8937

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    NfcNci \
    nfc_nci.pn54x.default \
    Tag

# Keystore
PRODUCT_PACKAGES += \
	gatekeeper.msm8937 \
    keystore.msm8937 \
    keymaster_test

# Lights
PRODUCT_PACKAGES += \
    lights.msm8937

# LiveDisplay
PRODUCT_PACKAGES += \
    libjni_livedisplay

# Media config
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
	libextmedia_jni \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxSwVencHevc \
	libOmxSwVencMpeg4 \
	libOmxSwVdec \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Power HAL
PRODUCT_PACKAGES += \
    power.msm8937

# RIL
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    librmnetctl \
    rmnetcli \
    telephony-ext

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Wifi firmware
PRODUCT_PACKAGES += \
    libqsap_sdk \
    libQWiFiSoftApCfg \
    libwcnss_qmi \
    wcnss_service

PRODUCT_COPY_FILES += \
    kernel/lge/ph2n/drivers/staging/prima/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/lge/ph2n/drivers/staging/prima/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/rootdir/etc/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/wifi/WCNSS_qcom_wlan_nv.bin \
    $(LOCAL_PATH)/rootdir/etc/wifi/fstman.ini:system/etc/wifi/fstman.ini \
    $(LOCAL_PATH)/rootdir/etc/wifi/p2p_go_zone.txt:system/etc/wifi/p2p_go_zone.txt \
    $(LOCAL_PATH)/rootdir/etc/wifi/p2p_supplicant.conf:system/etc/wifi/p2p_supplicant.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/rootdir/etc/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf


# WPA Supplicant
PRODUCT_PACKAGES += \
    hostapd \
    hostapd_cli \
    dhcpcd.conf \
    libwpa_client \
    wpa_supplicant

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/rootdir/etc/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny

# Nano & Terminfo
PRODUCT_PACKAGES += \
    ansi \
    dumb \
    linux \
    nano \
    pcansi \
    screen \
    unknown \
    vt100 \
    vt102 \
    vt200 \
    vt220 \
    xterm \
    xterm-color \
    xterm-xfree86

# Bash
PRODUCT_PACKAGES += \
    bash \
    bash.bin \
    bashrc \
    inputrc \
    dumpstate.ph2n

# LG SDEncryption
PRODUCT_PACKAGES += \
	dumpsexp \
	hmac256 \
	ecryptfs_manager \
	ecryptfs_wrap_passphrase \
	ecryptfs_unwrap_passphrase \
	ecryptfs_insert_wrapped_passphrase_into_keyring \
	ecryptfs_rewrap_passphrase \
	ecryptfs_add_passphrase \
	ecryptfs-stat \
	gcryptrnd \
	getrandom \
	keyctl \
	mkerrcodes \
	mount.ecryptfs \
	libecryptfs \
	libecryptfs_key_mod_passphrase \
	libgcrypt \
	libgpg-error \
	libkeyutils \
	libtimescale_filter \
	request-key

# QuickCircle Case App
PRODUCT_PACKAGES += \
    FlipFlap

# LG other
PRODUCT_PACKAGES += \
	freeblk \
	libshims_wvm

# IPACM
PRODUCT_PACKAGES += \
    IPACM_cfg.xml \
    ipacm \
    ipacm_diag

# General
PRODUCT_PACKAGES += \
    libtinyxml \
    libxml2 

# Qcom other
PRODUCT_PACKAGES += \
	tcmiface \
    libjson

PRODUCT_PACKAGES += \
	libbt-vendor \
	libnetfilter_conntrack \
	libnfnetlink \
	libwifi-hal-qcom \
	libbthost_if

# setup dm-verity configs.
# PRODUCT_SUPPORTS_VERITY := true
# PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc/f9824900.sdhci/by-name/system
#PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/platform/soc/f9824900.sdhci/by-name/vendor
# $(call inherit-product, build/target/product/verity.mk)

# OEM Unlock reporting
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.oem_unlock_supported=1

# In userdebug, add minidebug info the the boot image and the system server to support
# diagnosing native crashes.
ifneq (,$(filter userdebug, $(TARGET_BUILD_VARIANT)))
    # Boot image.
    PRODUCT_DEX_PREOPT_BOOT_FLAGS += --generate-mini-debug-info
    # System server and some of its services.
    # Note: we cannot use PRODUCT_SYSTEM_SERVER_JARS, as it has not been expanded at this point.
    $(call add-product-dex-preopt-module-config,services,--generate-mini-debug-info)
    $(call add-product-dex-preopt-module-config,wifi-service,--generate-mini-debug-info)
endif

# facelock properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.facelock.black_timeout=700 \
    ro.facelock.det_timeout=2500 \
    ro.facelock.rec_timeout=3500 \
    ro.facelock.est_max_time=600

## System property declarations (used for entries with a space or that are empty)
TARGET_SYSTEM_PROP := $(LOCAL_PATH)/system.prop
## System property overrides
include $(LOCAL_PATH)/system_prop.mk
