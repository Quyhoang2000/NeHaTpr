export ARCHS = arm64 arm64e
export TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = EliteLuxury

# Giữ nguyên đầy đủ các file và thư viện hệ thống
EliteLuxury_FILES = Tweak.xm
EliteLuxury_FRAMEWORKS = UIKit WebKit Foundation QuartzCore CoreGraphics
EliteLuxury_CFLAGS = -fobjc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/tweak.mk

# Tự động khởi động lại SpringBoard sau khi cài (để test)
after-install::
	install.exec "killall -9 SpringBoard"
