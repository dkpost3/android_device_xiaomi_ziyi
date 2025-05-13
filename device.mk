#
# Copyright (C) 2022-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from xiaomi sm8450-common
$(call inherit-product, device/xiaomi/sm8450-common/common.mk)

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/ziyi/ziyi-vendor.mk)

# call gamebar
$(call inherit-product, packages/apps/GameBar/gamebar.mk)

#Euicc
$(call inherit-product, hardware/xiaomi/packages/Euicc/euicc.mk)

# Call the MiuiCamera setup
$(call inherit-product, device/xiaomi/miuicamera-ziyi/device.mk)
$(call soong_config_set,camera, package_name, com.android.camera)

# Audio
PRODUCT_PACKAGES += \
    firmware_aw_cali.bin_symlink

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/mixer_paths_diwali_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_diwali/mixer_paths_diwali_idp.xml \
    $(LOCAL_PATH)/audio/resourcemanager_diwali_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_diwali/resourcemanager_diwali_idp.xml \
    $(LOCAL_PATH)/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

# Logging
SPAMMY_LOG_TAGS := \
    MiStcImpl \
    SDM \
    SDM-histogram \
    SRE \
    SensorService \
    WifiHAL \
    cnss-daemon \
    libcitsensorservice@2.0-impl \
    libsensor-displayalgo \
    libsensor-parseRGB \
    libsensor-ssccalapi \
    sensors \
    vendor.qti.hardware.display.composer-service \
    vendor.xiaomi.sensor.citsensorservice@2.0-service

ifneq ($(TARGET_BUILD_VARIANT),eng)
PRODUCT_VENDOR_PROPERTIES += \
    $(foreach tag,$(SPAMMY_LOG_TAGS),log.tag.$(tag)=W)
endif

# Light
$(call soong_config_set,xiaomi_sm8450_sensor_notifier,extension_lib,//device/xiaomi/ziyi:libsensor-notifier-ext-light)

# Overlay
PRODUCT_PACKAGES += \
    FrameworksResZiyi \
    NfcResZiyi \
    SettingsProviderResZiyi \
    SettingsProviderResZiyiCN \
    SettingsResZiyi \
    SystemUIResZiyi \
    WifiResZiyi \
    WifiResZiyiCN

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# System properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/properties/build_CN.prop:$(TARGET_COPY_OUT_ODM)/etc/build_CN.prop \
    $(LOCAL_PATH)/properties/build_GL.prop:$(TARGET_COPY_OUT_ODM)/etc/build_GL.prop

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/properties/build_CN.prop:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/odm/etc/build_CN.prop \
    $(LOCAL_PATH)/properties/build_GL.prop:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/odm/etc/build_GL.prop
