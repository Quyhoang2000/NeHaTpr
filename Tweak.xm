#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

#define kServerURL @"https://majestic-tartufo-52edcd.netlify.app/" // THAY LINK HTML CỦA BẠN VÀO ĐÂY

@interface EliteLuxuryController : UIViewController <WKNavigationDelegate, WKScriptMessageHandler>
@property (nonatomic, strong) WKWebView *menuWebView;
@end

@implementation EliteLuxuryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // Cho phép thực thi script và giao tiếp với H5GG
    [config.userContentController addScriptMessageHandler:self name:@"eliteHandler"];
    
    self.menuWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.menuWebView.navigationDelegate = self;
    self.menuWebView.backgroundColor = [UIColor clearColor];
    self.menuWebView.opaque = NO;
    self.menuWebView.scrollView.bounces = NO;
    self.menuWebView.scrollView.scrollEnabled = NO;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kServerURL]];
    [self.menuWebView loadRequest:request];
    [self.view addSubview:self.menuWebView];
}

// Xử lý khi có lệnh từ HTML gửi về (nếu cần mở rộng sau này)
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"eliteHandler"]) {
        NSLog(@"[Elite] Nhận lệnh từ Menu: %@", message.body);
    }
}

@end

%hook UnityFramework
- (void)didMoveToWindow {
    %orig;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            EliteLuxuryController *vc = [[EliteLuxuryController alloc] init];
            vc.view.frame = keyWindow.bounds;
            [keyWindow addSubview:vc.view];
        });
    });
}
%end
