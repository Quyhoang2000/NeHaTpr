export ARCHS = arm64
export TARGET = iphone:clang:latest:13.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EliteLuxury
EliteLuxury_FILES = Tweak.xm
EliteLuxury_FRAMEWORKS = UIKit WebKit Foundation
EliteLuxury_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-error -O2

include $(THEOS_MAKE_PATH)/tweak.mk
