#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface EliteMenu : UIView <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation EliteMenu

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Cấu hình WebView để chạy mượt và không nền
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        
        self.webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];
        self.webView.navigationDelegate = self;
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.scrollView.bounces = NO;
        self.webView.scrollView.scrollEnabled = NO;

        // Link Netlify của bạn
        NSURL *url = [NSURL URLWithString:@"https://majestic-tartufo-52edcd.netlify.app/"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];

        [self addSubview:self.webView];
    }
    return self;
}

// Giáp bảo vệ: Nếu web lỗi, menu tự hủy thay vì làm văng App
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self removeFromSuperview];
}
@end

%ctor {
    // Delay 5 giây: Khoảng thời gian an toàn nhất cho iPhone 6s Plus
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *keyWin = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene* scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    for (UIWindow *w in scene.windows) {
                        if (w.isKeyWindow) { keyWin = w; break; }
                    }
                }
            }
        } else {
            keyWin = [UIApplication sharedApplication].keyWindow;
        }

        if (keyWin) {
            EliteMenu *menu = [[EliteMenu alloc] initWithFrame:keyWin.bounds];
            [keyWin addSubview:menu];
        }
    });
}
