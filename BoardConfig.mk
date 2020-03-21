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

PLATFORM_PATH := device/oneplus/oneplus3

TARGET_BOARD_PLATFORM := msm8996

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false

BOARD_USES_GENERIC_AUDIO := true
USE_CAMERA_STUB := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_PATH)/bluetooth

# Enable System As Root even for non-A/B from P onwards.
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

TARGET_RECOVERY_FSTAB := $(PLATFORM_PATH)/recovery/recovery.fstab

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3154116608
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57436708864
BOARD_FLASH_BLOCK_SIZE := 262144

BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Display/Graphics
MAX_VIRTUAL_DISPLAY_DIMENSION := 4096
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
QTI_S3D := true
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_HWC2 := true
TARGET_USES_GRALLOC1 := true
TARGET_USES_QCOM_DISPLAY_BSP := true
TARGET_USES_COLOR_METADATA := true

# FRP
BOARD_FRP_PARTITION_NAME := frp

# Manifests
DEVICE_MANIFEST_FILE := $(PLATFORM_PATH)/manifest.xml
DEVICE_MATRIX_FILE := $(PLATFORM_PATH)/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := $(PLATFORM_PATH)/framework_manifest.xml

# NFC
TARGET_USES_NQ_NFC := false

# Seccomp
BOARD_SECCOMP_POLICY := $(PLATFORM_PATH)/seccomp

# EGL
BOARD_EGL_CFG := $(PLATFORM_PATH)/egl.cfg

# Kernel
BOARD_KERNEL_CMDLINE += \
    ro \
    root=/dev/dm-0 \
    rootwait \
    skip_initramfs \
    init=/init \
    dm=\"system none ro,0 1 android-verity /dev/sde20\"

BOARD_KERNEL_CMDLINE += \
    console=ttyHSL0,115200,n8 \
    androidboot.console=ttyHSL0

BOARD_KERNEL_CMDLINE += \
    androidboot.hardware=qcom \
    user_debug=31 msm_rtb.filter=0x237 \
    ehci-hcd.park=3 \
    lpm_levels.sleep_disabled=1 \
    cma=32M@0-0xffffffff \
    loop.max_part=7

BOARD_KERNEL_BASE        := 0x80000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x02000000
BOARD_RAMDISK_OFFSET     := 0x02200000

BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_SOURCE := kernel/oneplus/msm8996
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_CONFIG := oneplus3_defconfig

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

# RPC
TARGET_NO_RPC := true

# Initialization
TARGET_PLATFORM_DEVICE_BASE := /devices/soc/
TARGET_INIT_VENDOR_LIB := libinit_msm

# Peripheral Manager
TARGET_PER_MGR_ENABLED := true

# Encryption
TARGET_CRYPTFS_HW_PATH := vendor/qcom/opensource/cryptfs_hw
TARGET_HW_DISK_ENCRYPTION := true

# Camera
BOARD_QTI_CAMERA_32BIT_ONLY := true
TARGET_BOOTIMG_SIGNED := true

DEX_PREOPT_DEFAULT := nostripping

# Enable dex pre-opt to speed up initial boot.
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds.
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

# Enable sensor multi HAL.
USE_SENSOR_MULTI_HAL := true

# Enable early mount support for MMC/UFS.
EARLY_MOUNT_SUPPORT := true

# Indicate that protobuf-c is supported in this build.
PROTOBUF_SUPPORTED := false

# Enable DRM plugins 64 bit compilation
TARGET_ENABLE_MEDIADRM_64 := true

# Vendor
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
PRODUCT_FULL_TREBLE_OVERRIDE := true
PRODUCT_VENDOR_MOVE_ENABLED := true
TARGET_COPY_OUT_VENDOR := vendor

#################################################################################
# This is the End of BoardConfig.mk file.
# Now, Pickup other split Board.mk files:
#################################################################################
-include vendor/qcom/defs/board-defs/legacy/*.mk
#################################################################################
