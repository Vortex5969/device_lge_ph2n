# Device was launched with M/6
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=23

PRODUCT_PROPERTY_OVERRIDES += \
    ro.hwui.texture_cache_size=56 \
    ro.hwui.layer_cache_size=32 \
    ro.hwui.r_buffer_cache_size=8 \
    ro.hwui.path_cache_size=16 \
    ro.hwui.gradient_cache_size=1 \
    ro.hwui.drop_shadow_cache_size=6 \
    ro.hwui.texture_cache_flushrate=0.4 \
    ro.hwui.text_small_cache_width=1024 \
    ro.hwui.text_small_cache_height=1024 \
    ro.hwui.text_large_cache_width=2048 \
    ro.hwui.text_large_cache_height=1024

PRODUCT_PROPERTY_OVERRIDES += \
	log.tag.GpsLocationProvider=DEBUG \
	log.tag.LocationManagerService=DEBUG \
	log.tag.NlpProxy=DEBUG \
	log.tag.LocSvc_java=DEBUG \
	log.tag.LgeGpsIndicator=DEBUG \
	log.tag.GeofenceHardwareImpl=DEBUG \
	log.tag.GeofenceManager=DEBUG \
	log.tag.FlpServiceProvider=DEBUG \
	log.tag.GeofenceProxy=DEBUG

PRODUCT_PROPERTY_OVERRIDES += \
	ro.frp.pst=/dev/block/bootdevice/by-name/persistent

### Dalvik ###
PRODUCT_PROPERTY_OVERRIDES += \
	dalvik.vm.heapstartsize=8m \
	dalvik.vm.heapgrowthlimit=256m \
	dalvik.vm.heapsize=512m \
	dalvik.vm.heaptargetutilization=0.75 \
	dalvik.vm.heapminfree=512k \
	dalvik.vm.heapmaxfree=8m \
	ro.config.max_starting_bg=32 \
	ro.sys.fw.bg_cached_ratio=0.33 \
	drm.service.enabled=true \
	ro.boot.svelte=1 \
	ro.sf.lcd_density=320 \
	vidc.disable.split.mode=1

PRODUCT_PROPERTY_OVERRIDES += \
	persist.console.silent.config=0

# LOGGER_*.sh
PRODUCT_PROPERTY_OVERRIDES += \
	persist.service.odm_log.noti=true \
	persist.service.odm_log.svc=true \
    persist.service.crash.enable=0 \
    persist.service.events.enable=6 \
    persist.service.kernel.enable=6 \
    persist.service.main.enable=6 \
    persist.service.radio.enable=6 \
    persist.service.system.enable=6 \
	persist.sys.ssr.restart_level=ALL_ENABLE

# Time Daemon
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# system props for the data modules
PRODUCT_PROPERTY_OVERRIDES += \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.data.mode=concurrent \
    DEVICE_PROVISIONED=1 \
    ril.subscription.types=NV,RUIM \
    rild.libpath=/system/vendor/lib/libril-qc-qmi-1.so

### Telephony ##########################################
PRODUCT_PROPERTY_OVERRIDES += \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.qcril.disable_retry=true \
    keyguard.no_require_sim=true \

#  0     WCDMA preferred
#  1     GSM only
#  2     WCDMA only
#  3     GSM auto (PRL)
#  4     CDMA auto (PRL)
#  5     CDMA only
#  6     EvDo only
#  7     GSM/CDMA (PRL)
#  8     LTE/CDMA auto (PRL)
#  9     LTE/GSM auto (PRL)
# 10     LTE/GSM/CDMA auto (PRL)
# 11     LTE only
# 12     Unknown
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=9

# GPS
# ro.qc.sdk.izat.premium_enabled=0 \
# ro.qc.sdk.izat.service_mask=0x8 \
# persist.gps.qc_nlp_in_use=1

PRODUCT_PROPERTY_OVERRIDES += \
    ro.gps.agps_provider=1

### SENSORS ###
# Sensor debugging
# Valid settings (and presumably what they mean):
#   0      - off
#   1      - all the things
#   V or v - verbose
#   D or d - debug
#   E or e - errors
#   W or w - warnings
#   I or i - info
#
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.sensors.hal=e \
    debug.qualcomm.sns.daemon=e \
    debug.qualcomm.sns.hal=e \
    debug.qualcomm.sns.libsensor1=e

# QCNE (Qualcomm ConNectivity Engine)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.cne.feature=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.core_ctl_min_cpu=2 \
	ro.core_ctl_max_cpu=4

# system props for widevine
# PRODUCT_PROPERTY_OVERRIDES += \
# 	persist.gralloc.cp.level3=1

PRODUCT_PROPERTY_OVERRIDES += \
	ro.adb.secure=0 \
	ro.secure=0 \
	ro.debuggable=1 \
	persist.sys.root_access=1 \
	persist.sys.usb.config=diag,adb \
    persist.sys.strictmode.disable=true

### ADB
PRODUCT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    persist.sys.root_access=1 \
    ro.debuggable=1 \
    debug.sf.hw=1 \
	debug.egl.hw=1 \
	persist.hwc.mdpcomp.enable=true \
	debug.mdpcomp.logs=0 \
	dev.pm.dyn_samplingrate=1 \
	persist.demo.hdmirotationlock=false \
	debug.enable.sglscale=1

# Factory Reset Protection
#PRODUCT_PROPERTY_OVERRIDES += \
#    ro.frp.pst=/dev/block/bootdevice/by-name/persistent

PRODUCT_PROPERTY_OVERRIDES += \
	ro.lge.swversion_arb=ARB00 \
	ro.lge.swversion=K55011p \
	ro.lge.swversion_short=V11p \
	ro.lge.swversion_rev=0 \
	ro.lge.factoryversion=LGK550AT-00-V11p-TMO-US-JAN-12-2017-ARB00+0

PRODUCT_PROPERTY_OVERRIDES += \
	ro.opengles.version=196609