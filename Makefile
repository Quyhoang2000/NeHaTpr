export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EliteLuxury
EliteLuxury_FILES = Tweak.xm
EliteLuxury_FRAMEWORKS = UIKit WebKit Foundation QuartzCore CoreGraphics
EliteLuxury_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
