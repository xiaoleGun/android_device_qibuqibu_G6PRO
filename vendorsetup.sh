#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

if [ ! -f device/qibuqibu/G6PRO/patches/vendor_lineage_prebuild_kernel.patch ];then
    mkdir -p device/qibuqibu/G6PRO/patches
    wget -O device/qibuqibu/G6PRO/patches/vendor_lineage_prebuild_kernel.patch https://gist.githubusercontent.com/xiaoleGun/c76817bb79e7916dcc9bf42319f77f62/raw/5622c18f25b7fcb56092cb98894fcc759b8d40b8/vendor_lineage_prebuild_kernel.patch
fi

cd vendor/lineage
if [ -n  "$(git apply --check ../../device/qibuqibu/G6PRO/patches/vendor_lineage_prebuild_kernel.patch &> /dev/null)" ];then
    git am ../../device/qibuqibu/G6PRO/patches/vendor_lineage_prebuild_kernel.patch
else
    echo "Check vendor/lineage or duplicate apply patches, please ignore."
fi
cd ../..
