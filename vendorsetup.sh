#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

cd vendor/lineage
if [ -z  "$(git apply --check ../../device/qibuqibu/G6PRO/patches/vendor_lineage/0001-soong-Remove-generated_kernel_includes-for-use-prebu.patch &> /dev/null)" ];then
    git am ../../device/qibuqibu/G6PRO/patches/vendor_lineage/0001-soong-Remove-generated_kernel_includes-for-use-prebu.patch
elif [ -z  "$(git apply --check ../../device/qibuqibu/G6PRO/patches/vendor_lineage/0002-lineage-Add-Android-Go-specific-configs.patch &> /dev/null)" ];then
    git am ../../device/qibuqibu/G6PRO/patches/vendor_lineage/0002-lineage-Add-Android-Go-specific-configs.patch
else
    echo "Check vendor/lineage or duplicate apply patches, please ignore."
fi
cd ../..
cd packages/apps/Trebuchet
if [ -z  "$(git apply --check ../../../device/qibuqibu/G6PRO/patches/packages_apps_Trebuchet/0001-TrebuchetGo-Add-Go-specific-default-workspace.patch &> /dev/null)" ];then
    git am ../../../device/qibuqibu/G6PRO/patches/packages_apps_Trebuchet/0001-TrebuchetGo-Add-Go-specific-default-workspace.patch
else
    echo "Check packages/apps/Trebuchet or duplicate apply patches, please ignore."
fi
cd ../../..
