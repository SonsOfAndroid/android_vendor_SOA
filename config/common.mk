PRODUCT_BRAND ?= sons of android

SUPERUSER_EMBEDDED := true
SUPERUSER_PACKAGE_PREFIX := com.android.settings.cyanogenmod.superuser

# TODO: remove once all devices have been switched
ifneq ($(TARGET_BOOTANIMATION_NAME),)
TARGET_SCREEN_DIMENSIONS := $(subst -, $(space), $(subst x, $(space), $(TARGET_BOOTANIMATION_NAME)))
ifeq ($(TARGET_SCREEN_WIDTH),)
TARGET_SCREEN_WIDTH := $(word 2, $(TARGET_SCREEN_DIMENSIONS))
endif
ifeq ($(TARGET_SCREEN_HEIGHT),)
TARGET_SCREEN_HEIGHT := $(word 3, $(TARGET_SCREEN_DIMENSIONS))
endif
endif

ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# clear TARGET_BOOTANIMATION_NAME 
TARGET_BOOTANIMATION_NAME :=

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/soa/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/soa/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1

# init.d support
PRODUCT_COPY_FILES += \
	vendor/soa/prebuilt/common/etc/init.d/00RAM:system/etc/init.d/00RAM \
	vendor/soa/prebuilt/common/etc/init.d/01perms:system/etc/init.d/01permsr \
	vendor/soa/prebuilt/common/etc/init.d/02Clean:system/etc/init.d/02Clean \
	vendor/soa/prebuilt/common/etc/init.d/03Scrub:system/etc/init.d/03Scrub \
	vendor/soa/prebuilt/common/etc/init.d/S98cpu_sleep:system/etc/init.d/S98cpu_sleep \
    vendor/soa/prebuilt/common/bin/sysinit:system/bin/sysinit

# SOA-specific init file
PRODUCT_COPY_FILES += \
    vendor/soa/prebuilt/common/etc/init.local.rc:root/init.cm.rc

# Launcher
PRODUCT_COPY_FILES +=  \
    vendor/soa/proprietary/ApexLauncher.apk:system/app/ApexLauncher.apk \

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/soa/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/soa/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# This is SOA!
PRODUCT_COPY_FILES += \
    vendor/soa/config/permissions/com.sonsofandroid.android.xml:system/etc/permissions/com.sonsofandroid.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/soa/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# T-Mobile theme engine
include vendor/soa/config/themes_common.mk

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
    DSPManager \
    libcyanogen-dsp \
    audio_effects.conf \
    Apollo \
    LockClock \
	SOAPapers \
	PerformanceControl \

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

PRODUCT_PACKAGE_OVERLAYS += vendor/soa/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/soa/overlay/common

BUILD = true
SOA_VERSION_MAJOR = Sons Of Android
SOA_VERSION_BUILD = 3

ifeq ($(BUILD),true)
        SOA_VERSION := $(BUILD_VERSION_MAJOR)-$(BUILD_VERSION_NUMBER)-$(shell date -u +%Y%m%d)
endif

PRODUCT_PROPERTY_OVERRIDES += \
ro.sonsofandroid.version=$(SOA_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
ro.ril.hsxpa=3 \
wifi.supplicant_scan_interval=180 \
windowsmgr.max_events_per_sec=350 \
ro.min_pointer_dur=8 \
ro.max.fling_velocity=12000 \
ro.min.fling_velocity=8000 \
ro.ril.disable.power.collapse=0 \
pm.sleep_mode=1 \
ro.kernel.android.checkjni=0 \
ro.config.nocheckin=1 \
persist.android.strictmode=0 \
persist.sys.use_dithering=1 \
persist.sys.ui.hw=true \
persist.sys.purgeable_assets=1 \
ro.com.google.networklocation=0 \
ro.kernel.android.checkjni=0 \
ro.config.nocheckin=1 \
ro.vold.umsdirtyratio=20 \
dalvik.vm.checkjni=false \
dalvik.vm.execution-mode=int:jit \
profiler.force_disable_err_rpt=1 \
profiler.force_disable_ulog=1 \

PRODUCT_PROPERTY_OVERRIDES += \
net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960 \
net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960 \
ro.ril.enable.amr.wideband=1 \
dalvik.vm.checkjni=false \
dalvik.vm.dexopt-data-only=1 \
dalvik.vm.verify-bytecode=false \
dalvik.vm.lockprof.threshold=250 \
dalvik.vm.dexopt-flags=m=v,o=y \
dalvik.vm.stack-trace-file=/data/anr/traces.txt \
dalvik.vm.jmiopts=forcecopy \
ro.ril.hep=1 \
ro.ril.enable.dtm=1 \
ro.ril.hsdpa.category=10 \
ro.ril.enable.a53=1 \
ro.ril.enable.3g.prefix=1 \
ro.ril.htcmaskw1.bitmask=4294967295 \
ro.ril.htcmaskw1=14449 \
ro.ril.hsupa.category=5 \
ro.secure=0 \
ro.debuggable=1 \
persist.service.adb.enable=1 \
ro.hdmi.enable=true \

-include $(WORKSPACE)/hudson/image-auto-bits.mk
