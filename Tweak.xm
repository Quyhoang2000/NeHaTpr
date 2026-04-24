#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

// Thay bằng link GitHub Pages chứa file HTML của bạn
#define kServerURL @"https://majestic-tartufo-52edcd.netlify.app/" 

@interface EliteController : UIViewController <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@end

@implementation EliteController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.preferences setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.navigationDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.opaque = NO;
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kServerURL]]];
    [self.view addSubview:self.webView];
}
@end

%hook UnityFramework
- (void)didMoveToWindow {
    %orig;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWindow *win = [UIApplication sharedApplication].keyWindow;
            EliteController *vc = [[EliteController alloc] init];
            vc.view.frame = win.bounds;
            [win addSubview:vc.view];
        });
    });
}
%end
