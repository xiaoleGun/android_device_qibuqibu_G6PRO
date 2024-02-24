#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/go_defaults.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_mini_tablet_wifionly.mk)

# Inherit from G6PRO device
$(call inherit-product, device/qibuqibu/G6PRO/device.mk)

PRODUCT_DEVICE := G6PRO
PRODUCT_NAME := lineage_G6PRO
PRODUCT_BRAND := QiBuQibu
PRODUCT_MODEL := G6PRO
PRODUCT_MANUFACTURER := QiBuQibu

PRODUCT_CHARACTERISTICS := tablet,nosdcard

PRODUCT_GMS_CLIENTID_BASE := android-alps

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_k80_bsp-user 8.1.0 O11019 1641787554 release-keys" \
    PRODUCT_DEVICE="G6 PRO" \
    PRODUCT_NAME="G6 PRO" \
    PRODUCT_MODEL="G6 PRO"

BUILD_FINGERPRINT := alps/G6PRO/G6PRO:8.1.0/O11019/1641787554:user/release-keys
