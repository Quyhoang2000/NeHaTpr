export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EliteLuxury
# Đảm bảo tên file bên dưới trùng với file code của bạn (Tweak.xm hoặc Tweak.x)
EliteLuxury_FILES = Tweak.xm
EliteLuxury_FRAMEWORKS = UIKit WebKit Foundation QuartzCore
# Dòng dưới này là "thuốc giải" cho lỗi keyWindow bạn vừa gặp
EliteLuxury_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
