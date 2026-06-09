#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#
# TB373FU - ROW (global) variant of the Lenovo Xiaoxin Pad Pro 12.7 (2025).
#
# Same MT6897 hardware as the PRC TB375FC and shares the entire device + vendor
# tree, kernel, partition layout and sepolicy. The only build-visible difference
# is the dtbo: the ROW bootloader validates its own dtbo AVB hash descriptor at
# boot, so a TB373FU build must ship the ROW dtbo (and pin the matching OEM salt)
# instead of the PRC one. DEVICE_PATH stays device/lenovo/TB375FC (set by the
# include below), so every other prebuilt/config resolves to the shared tree.
#
include device/lenovo/TB375FC/BoardConfig.mk

# ROW dtbo from a stock TB373FU readback, plus its OEM AVB salt. The salt pins
# the dtbo digest so the standalone dtbo.img and the vbmeta descriptor agree -
# same mechanism and rationale as the PRC salt in
# device/lenovo/TB375FC/BoardConfig.mk.
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilts/dtbo_TB373FU.img
BOARD_AVB_DTBO_ADD_HASH_FOOTER_ARGS := --salt 10cda046103a3dbdf6e0f4bfd7effe4ff2494dbc40a4bdcaef05766f822362f8

# ROW vendor props with spaces (marketname, pen name) - overrides the PRC
# vendor.prop the included TB375FC BoardConfig sets. See that file for the why.
TARGET_VENDOR_PROP := device/lenovo/TB373FU/vendor.prop
