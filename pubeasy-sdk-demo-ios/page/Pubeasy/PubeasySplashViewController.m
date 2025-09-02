#import "PubeasySplashViewController.h"
@import PubeasySDK;

@interface PubeasySplashViewController () <PubeasyAdSplashDelegate>

@property (nonatomic, strong) PubeasyAdSplash *splashAd;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation PubeasySplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Splash";

    self.splashAd = [[PubeasyAdSplash alloc] init];
    self.splashAd.delegate = self;
    // Splash ad unit id.
    [self.splashAd setAdUnitID:@"16A71BCD17A9B9F0917232A05F76F276"];

    self.loadButton = [self buildButtonWithTitle:@"Load" action:@selector(onTapLoad) frame:CGRectMake(20, 120, 120, 44)];
    self.showButton = [self buildButtonWithTitle:@"Show" action:@selector(onTapShow) frame:CGRectMake(160, 120, 120, 44)];
    [self.view addSubview:self.loadButton];
    [self.view addSubview:self.showButton];
}

#pragma mark - UI Helpers

- (UIButton *)buildButtonWithTitle:(NSString *)title action:(SEL)action frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark - Actions

- (void)onTapLoad {
    // Load splash ad. Provide current window. No bottom view for demo.
    UIWindow *keyWindow = UIApplication.sharedApplication.windows.firstObject;
    if (keyWindow == nil && UIApplication.sharedApplication.delegate.window != nil) {
        keyWindow = UIApplication.sharedApplication.delegate.window;
    }
    if (keyWindow != nil) {
        [self.splashAd loadAdWithWindow:keyWindow bottomView:nil];
    } else {
        NSLog(@"[Splash] No window found");
    }
}

- (void)onTapShow {
    // Show splash ad if ready.
    if (self.splashAd.isAdReady) {
        [self.splashAd show];
    } else {
        NSLog(@"[Splash] Not ready");
    }
}

#pragma mark - PubeasyAdSplashDelegate (required)

- (void)pubeasySplashAdLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Loaded: %@", adInfo);
}

- (void)pubeasySplashAdImpression:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Impression: %@", adInfo);
}

- (void)pubeasySplashAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Splash] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasySplashAdClicked:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Clicked: %@", adInfo);
}

- (void)pubeasySplashAdDismissed:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Dismissed: %@", adInfo);
}

#pragma mark - PubeasyAdSplashDelegate (optional - implement all)

- (void)pubeasySplashAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasySplashAdStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Start load: %@", adInfo);
}

- (void)pubeasySplashAdOneLayerStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Splash] One layer start load: %@", adInfo);
}

- (void)pubeasySplashAdIsLoading:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Is loading: %@", adInfo);
}

- (void)pubeasySplashAdBidStart:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Bid start: %@", adInfo);
}

- (void)pubeasySplashAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error {
    NSLog(@"[Splash] Bid end: %@, error=%@", adInfo, error);
}

- (void)pubeasySplashAdOneLayerLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Splash] One layer loaded: %@", adInfo);
}

- (void)pubeasySplashAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Splash] One layer load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasySplashAdAllLoaded:(BOOL)success adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Splash] All loaded: %d, info=%@", success, adInfo);
}

- (void)pubeasySplashAdSkip:(NSDictionary *)adInfo {
    NSLog(@"[Splash] Skip: %@", adInfo);
}

- (void)pubeasySplashAdZoomOutViewShow:(NSDictionary *)adInfo {
    NSLog(@"[Splash] ZoomOut show: %@", adInfo);
}

- (void)pubeasySplashAdZoomOutViewClose:(NSDictionary *)adInfo {
    NSLog(@"[Splash] ZoomOut close: %@", adInfo);
}

@end


