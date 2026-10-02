TARGET = iphone:clang:latest:15.0
ARCHS = arm64 arm64e

SCHEME ?= rootless
ifeq ($(SCHEME),roothide)
    export THEOS_PACKAGE_SCHEME = roothide
    export FINALPACKAGE = 1
else ifeq ($(SCHEME),rootful)
    unexport THEOS_PACKAGE_SCHEME
else ifeq ($(SCHEME),rootless)
    export THEOS_PACKAGE_SCHEME = rootless
    export FINALPACKAGE = 1
else
    $(error Unknown SCHEME=$(SCHEME); use rootless, rootful, or roothide)
endif

ifeq ($(GITHUB_ACTIONS),true)
    export INSTALL = 0
    export FINALPACKAGE = 1
endif

export DEBUG = 0
INSTALL_TARGET_PROCESSES = Dragon Reading Eggplant XSFM

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = fanqiehehe

fanqiehehe_FILES = Tweak.x
fanqiehehe_CFLAGS = -fobjc-arc -w
fanqiehehe_FRAMEWORKS = UIKit Foundation

export THEOS_STRICT_LOGOS=0
export ERROR_ON_WARNINGS=0
export LOGOS_DEFAULT_GENERATOR=internal

include $(THEOS_MAKE_PATH)/tweak.mk

clean::
	@echo -e "\033[31m==>\033[0m Cleaning packages…"
	@rm -rf .theos packages

after-package::
	@echo -e "\033[32m==>\033[0m Packaging complete."
