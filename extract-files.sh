#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=G6PRO
VENDOR=qibuqibu

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib/egl/libGLES_mali.so|vendor/lib/hw/gralloc.mt6580.so|vendor/lib/hw/hwcomposer.mt6580.so)
            "${PATCHELF}" --add-needed "libutilscallstack.so" "${2}"
            ;;
        vendor/lib/libnvram.so)
            "${PATCHELF}" --add-needed "libbase_shim.so" "${2}"
            ;;
        vendor/lib/android.hardware.audio@2.0-v27.so)
            "${PATCHELF}" --replace-needed "android.hardware.audio.common@2.0.so" "android.hardware.audio.common@2.0-v27.so" "${2}"
            ;;
        vendor/lib/hw/android.hardware.audio@2.0-impl-mediatek.so)
            "${PATCHELF}" --replace-needed "android.hardware.audio.common@2.0-util.so" "android.hardware.audio.common@2.0-util-v27.so" "${2}"
            ;;
        vendor/lib/vendor.mediatek.hardware.audio@2.1_vendor.so)
            "${PATCHELF}" --replace-needed "android.hardware.audio@2.0.so" "android.hardware.audio@2.0-v27.so" "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
