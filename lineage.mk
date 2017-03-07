# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from PH2N
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_NAME := lineage_ph2n
PRODUCT_DEVICE := ph2n
PRODUCT_BRAND := lge
PRODUCT_MODEL := LG-K550
PRODUCT_MANUFACTURER := LGE
PRODUCT_RELEASE_NAME := LG Stylo 2 Plus

PRODUCT_RESTRICT_VENDOR_FILES := false

TARGET_VENDOR_PRODUCT_NAME	:= "ph2n_tmo_us"
TARGET_VENDOR_DEVICE_NAME	:= "ph2n"
# TARGET_VENDOR_RELEASE_BUILD_ID := ""

PRODUCT_BUILD_PROP_OVERRIDES += \
	PRIVATE_BUILD_DESC="ph2n_tmo_us-user 6.0.1 MXB48T 170120951deab release-keys" \
 	BUILD_FINGERPRINT="lge/ph2n_tmo_us/ph2n:6.0.1/MXB48T/170120951deab:user/release-keys"
