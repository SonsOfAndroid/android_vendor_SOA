# Brand
PRODUCT_BRAND ?= Sons Of Android


PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/SOA/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/SOA/prebuilt/common/bin/50-SOA.sh:system/addon.d/50-SOA.sh \
    vendor/SOA/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/SOA/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# SOA-specific init file
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/etc/init.local.rc:root/init.SOA.rc

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/SOA/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/SOA/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/SOA/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is SOA!
PRODUCT_COPY_FILES += \
    vendor/SOA/config/permissions/com.SonsOfAndroid.android.xml:system/etc/permissions/com.SonsOfAndroid.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/SOA/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# T-Mobile theme engine
include vendor/SOA/config/themes_common.mk

# Required SOA packages
PRODUCT_PACKAGES += \
    Camera \
    Development \
    LatinIME \
    Superuser \
    su

# Optional SOA packages
PRODUCT_PACKAGES += \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic

# Custom SOA packages
PRODUCT_PACKAGES += \
    Trebuchet \
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf \
    SOAWallpapers \
    Apollo \
    LockClock

# Extra tools in SOA
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

PRODUCT_PACKAGE_OVERLAYS += vendor/SOA/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/SOA/overlay/common

PRODUCT_VERSION_MAJOR = 1
PRODUCT_VERSION_MINOR = 1
PRODUCT_VERSION_TAG = "Beta-1"

# Set SOA_BUILDTYPE

ifeq ($(RELEASE),true)
    SOA_VERSION := "SonsOfAndroid-JB-v"$(SOA_VERSION_MAJOR).$(SOA_VERSION_MINOR)-$(SOA_VERSION_TAG)
else
    SOA_VERSION := "SonsOfAndroid-JB-exp"-$(shell date +%0d%^b%Y-%H%M%S)
endiff

PRODUCT_PROPERTY_OVERRIDES += \
  ro.SOA.version=$(SOA_VERSION) \
