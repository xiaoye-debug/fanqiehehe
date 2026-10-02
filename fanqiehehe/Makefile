TARGET = iphone:clang:latest:15.0
ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = Dragon Reading Eggplant XSFM

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = fanqiehehe

fanqiehehe_FILES = Tweak.x
fanqiehehe_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += fanqiehehePrefs

include $(THEOS_MAKE_PATH)/aggregate.mk
