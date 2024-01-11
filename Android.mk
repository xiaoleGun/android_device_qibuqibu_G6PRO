#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),G6PRO)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

# Kernel headers
$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr: $(wildcard device/qibuqibu/G6PRO-kernel/kernel-headers/*)
	rm -rf $@
	mkdir -p $@/include
	cp -a device/qibuqibu/G6PRO-kernel/kernel-headers/. $@/include

LIBGUI_SYMLINK := $(TARGET_OUT_VENDOR)/lib/libgui.so
$(LIBGUI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "libgui.so link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/libgui_vendor.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBGUI_SYMLINK)

GATEKEEPER_SYMLINK := $(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so 
$(GATEKEEPER_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "libSoftGatekeeper.so link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/hw/libSoftGatekeeper.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(GATEKEEPER_SYMLINK)

# The device requires us to create mount points during building.
CACHE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/cache
$(CACHE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(CACHE_MOUNT_POINT)"
	@mkdir -p $(CACHE_MOUNT_POINT)

NVDATA_MOUNT_POINT:= $(TARGET_OUT_VENDOR)/nvdata
$(NVDATA_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(NVDATA_MOUNT_POINT)"
	@mkdir -p $(NVDATA_MOUNT_POINT)

PROTECT_F_MOUNT_POINT  := $(TARGET_OUT_VENDOR)/protect_f
$(PROTECT_F_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(PROTECT_F_MOUNT_POINT)"
	@mkdir -p $(PROTECT_F_MOUNT_POINT)

PROTECT_S_MOUNT_POINT := $(TARGET_OUT_VENDOR)/protect_s
$(PROTECT_S_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(PROTECT_S_MOUNT_POINT)"
	@mkdir -p $(PROTECT_S_MOUNT_POINT)

ALL_DEFAULT_INSTALLED_MODULES += $(CACHE_MOUNT_POINT) $(NVDATA_MOUNT_POINT) $(PROTECT_F_MOUNT_POINT) $(PROTECT_S_MOUNT_POINT)

endif
