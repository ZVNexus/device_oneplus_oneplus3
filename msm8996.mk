# Copyright (C) 2020 Paranoid Android
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

$(call inherit-product, device/oneplus/oneplus3/base.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS := \
    $(LOCAL_PATH)/overlay

# Add soft home, back and multitask keys.
PRODUCT_PROPERTY_OVERRIDES += \
    qemu.hw.mainkeys=0

# Video Seccomp policy files.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/seccomp/mediaextractor-seccomp.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediaextractor.policy

# Enable features in video HAL that can compile only on this platform.
TARGET_USES_MEDIA_EXTENSIONS := true

# Copy customized media_profiles and media_codecs xmls for MSM8996.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_profiles.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles.xml \
    $(LOCAL_PATH)/media/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_codecs_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(LOCAL_PATH)/media/media_codecs_vendor_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_vendor_audio.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.0-service \
    android.hardware.power@1.0-impl

# Override heap growth limit due to high display density on device.
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product, device/oneplus/oneplus3/common64.mk)

# WiFi/WLAN
PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf \
    wificond \
    wifilogd \
    wpa_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/hostapd.accept:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/hostapd.accept \
    $(LOCAL_PATH)/wifi/hostapd.deny:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/hostapd.deny

# Wi-Fi passpoint support.
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.passpoint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.passpoint.xml

# OpenGLES
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PROPERTY_OVERRIDES  += \
    ro.opengles.version=196610

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

# EGL
PRODUCT_PACKAGES += \
    libGLES_android

# Audio
-include $(TOPDIR)hardware/qcom/audio/configs/msm8996/msm8996.mk

# MIDI
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# ANT+
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# Display/Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.memtrack@1.0-impl \
    android.hardware.memtrack@1.0-service \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service \
    android.hardware.configstore@1.0-service \
    android.hardware.broadcastradio@1.0-impl

PRODUCT_PACKAGES += \
    vendor.display.color@1.0-service \
    vendor.display.color@1.0-impl

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:$(TARGET_OUT_KEYLAYOUT)/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:$(TARGET_OUT_KEYLAYOUT)/qpnp_pon.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:$(TARGET_OUT_KEYLAYOUT)/synaptics_dsx.kl

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service

# VB XML
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.verified_boot.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.verified_boot.xml

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    android.hardware.camera.provider@2.4-service \
    camera.device@3.2-impl \
    camera.device@1.0-impl

PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hifi_sensors.xml

# VR
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vr.high_performance.xml

# MSM IRQ Balancer
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# List of AAPT configurations.
PRODUCT_AAPT_CONFIG += xlarge large

# Powerhint
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/powerhint.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/powerhint.xml

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-service \
    libhealthd.msm

# For android_filesystem_config.h.
PRODUCT_PACKAGES += \
    fs_config_files

PRODUCT_PACKAGES += \
    libandroid_net \
    libandroid_net_32

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl

# Enable AOSP KEYMASTER and GATEKEEPER HIDLs.
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# Defined the locales.
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/vendor/lib64/libril-qc-qmi-1.so
    persist.vendor.radio.apm_sim_not_pwdn=1 \
    persist.vendor.radio.sib16_support=1 \
    persist.vendor.radio.custom_ecc=1 \
    persist.vendor.radio.rat_on=combine \
    persist.backup.ntpServer=0.pool.ntp.org \
    sys.vendor.shutdown.waittime=500 \
    persist.vendor.radio.procedure_bytes=SKIP

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=rome

# Set this true as ROME which is programmed
# as embedded wipower mode by default.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.emb_wp_mode=true \
    ro.vendor.bluetooth.emb_wp_mode=true

# System property for WiPower support.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bluetooth.wipower=true \
    ro.vendor.bluetooth.wipower=true

# Thermal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    android.hardware.thermal@1.0-service

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so

# Verity
PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system
PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/bootdevice/by-name/vendor

# Whitelisted applications.
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    $(LOCAL_PATH)/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml

###################################################################################
# This is the End of target.mk file.
# Now, Pickup other split product.mk files:
###################################################################################
$(call inherit-product-if-exists, vendor/qcom/defs/product-defs/legacy/*.mk)
###################################################################################
