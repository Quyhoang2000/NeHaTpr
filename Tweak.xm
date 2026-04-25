#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

// Khai báo các hàm H5GG có sẵn trong bộ nạp
extern "C" void h5gg_setValue(NSString* address, NSString* value, NSString* type);
extern "C" NSString* h5gg_getValue(NSString* address, NSString* type);

@interface EliteMenu : UIView <WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation EliteMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // Tạo cầu nối tên là "h5gg_bridge"
        [config.userContentController addScriptMessageHandler:self name:@"h5gg_bridge"];
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        
        NSURL *url = [NSURL URLWithString:@"https://elaborate-smakager-c156f2.netlify.app"];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self addSubview:self.webView];
    }
    return self;
}

// Xử lý lệnh can thiệp game từ HTML gửi lên
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"h5gg_bridge"]) {
        NSDictionary *data = message.body;
        NSString *action = data[@"action"]; // Ví dụ: "set_value"
        
        if ([action isEqualToString:@"hack_antenna"]) {
            // Ví dụ: Can thiệp vào Offset của game
            // h5gg_setValue(@"0x102xxxx", @"100", @"float"); 
            NSLog(@"[Elite] Đã kích hoạt Antenna qua H5GG!");
        }
    }
}
@end

%ctor {
    // Delay 8 giây để chống văng và chống lag khi vào game
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        if (keyWindow) {
            EliteMenu *menu = [[EliteMenu alloc] initWithFrame:keyWindow.bounds];
            [keyWindow addSubview:menu];
        }
    });
}
