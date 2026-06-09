#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
# TB373FU - ROW (global) variant of the Lenovo Xiaoxin Pad Pro 12.7 (2025).
# Shares the entire TB375FC device + vendor tree; the only build difference is
# the dtbo (see device/lenovo/TB373FU/BoardConfig.mk). Inheritance below mirrors
# lineage_TB375FC.mk - see that file for the per-inherit rationale.

# AOSP base. core_64_bit + full_base MUST precede the device/vendor makefiles.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
# Wi-Fi-only tablet: full_base.mk (no telephony), not full_base_telephony.mk.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
# Virtual A/B + vendor_ramdisk + compression.
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# LineageOS common add-ons
$(call inherit-product, vendor/lineage/config/common.mk)

# Device-specific (shared with TB375FC)
$(call inherit-product, device/lenovo/TB375FC/device.mk)

# Vendor blobs (shared with TB375FC)
$(call inherit-product-if-exists, vendor/lenovo/TB375FC/TB375FC-vendor.mk)
$(call inherit-product-if-exists, vendor/lenovo/TB375FC/TB375FC-overlays.mk)

# Tablet wifi-only base
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

PRODUCT_DEVICE := TB373FU
PRODUCT_NAME := lineage_TB373FU
PRODUCT_BRAND := Lenovo
PRODUCT_MODEL := TB373FU

# ROW SKU identity - matches stock TB373FU so Settings shows the right model and
# OTA targets the ROW channel.
PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.config.lgsi.hw.version=TB373FU \
    ro.vendor.config.lgsi.ota.model=TB373FU_ROW

PRODUCT_MANUFACTURER := Lenovo
PRODUCT_CHARACTERISTICS := tablet

PRODUCT_GMS_CLIENTID_BASE := android-lenovo-rev2
