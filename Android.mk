#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),G6PRO)
include $(call all-subdir-makefiles,$(LOCAL_PATH))

LIBGUI_SYMLINK := $(TARGET_OUT_VENDOR)/lib/libgui.so
$(LIBGUI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "libgui.so link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/libgui_vendor.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(LIBGUI_SYMLINK)

endif
