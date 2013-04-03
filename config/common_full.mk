# Inherit common SOA stuff
$(call inherit-product, vendor/soa/config/common.mk)

# Bring in all audio files
include frameworks/base/data/sounds/NewAudio.mk

# Extra Ringtones
include frameworks/base/data/sounds/AudioPackageNewWave.mk

# Bring in all video files
$(call inherit-product, frameworks/base/data/videos/VideoPackage2.mk)

# Include SOA audio files
include vendor/soa/config/soa_audio.mk

# Optional SOA packages
PRODUCT_PACKAGES += \
    HoloSpiralWallpaper \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam
