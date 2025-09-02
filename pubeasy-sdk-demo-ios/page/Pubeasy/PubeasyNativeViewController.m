#import "PubeasyNativeViewController.h"
@import PubeasySDK;

@interface PubeasyNativeViewController () <PubeasyAdNativeDelegate>

@property (nonatomic, strong) PubeasyAdNative *nativeAd;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;
@property (nonatomic, strong) UIView *adContainer;

@end

@implementation PubeasyNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Native";

    self.nativeAd = [[PubeasyAdNative alloc] init];
    self.nativeAd.delegate = self;
    // Native ad unit id.
    [self.nativeAd setAdUnitID:@"C35635DF42EF4620E18F8F56DF41A09D"];

    self.adContainer = [[UIView alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, 300)];
    self.adContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.adContainer.backgroundColor = [UIColor secondarySystemBackgroundColor];
    [self.view addSubview:self.adContainer];

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
    // For template-based native, set render size before loading if required by networks.
    [self.nativeAd setTemplateRenderSize:CGSizeMake(self.adContainer.bounds.size.width, 300)];
    [self.nativeAd loadAd];
}

- (void)onTapShow {
    // Show native ad into container using default template rendering view.
    if (self.nativeAd.isAdReady) {
        [self.nativeAd showADWithRenderingViewClass:[UIView class] subview:self.adContainer sceneId:nil];
    } else {
        NSLog(@"[Native] Not ready");
    }
}

#pragma mark - PubeasyAdNativeDelegate (required)

- (void)pubeasyNativeAdLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Native] Loaded: %@", adInfo);
}

- (void)pubeasyNativeAdImpression:(NSDictionary *)adInfo {
    NSLog(@"[Native] Impression: %@", adInfo);
}

- (void)pubeasyNativeAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Native] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyNativeAdClicked:(NSDictionary *)adInfo {
    NSLog(@"[Native] Clicked: %@", adInfo);
}

#pragma mark - PubeasyAdNativeDelegate (optional - implement all)

- (void)pubeasyNativeAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Native] Load failed: %@, error=%@", adInfo, error);
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)pubeasyNativeAdStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Native] Start load: %@", adInfo);
}

- (void)pubeasyNativeAdOneLayerStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Native] One layer start load: %@", adInfo);
}

- (void)pubeasyNativeAdIsLoading:(NSDictionary *)adInfo {
    NSLog(@"[Native] Is loading: %@", adInfo);
}

- (void)pubeasyNativeAdClose:(NSDictionary *)adInfo {
    NSLog(@"[Native] Close: %@", adInfo);
}

- (void)pubeasyNativeAdBidStart:(NSDictionary *)adInfo {
    NSLog(@"[Native] Bid start: %@", adInfo);
}

- (void)pubeasyNativeAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error {
    NSLog(@"[Native] Bid end: %@, error=%@", adInfo, error);
}

- (void)pubeasyNativeAdOneLayerLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Native] One layer loaded: %@", adInfo);
}

- (void)pubeasyNativeAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Native] One layer load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyNativeAdAllLoaded:(BOOL)success adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Native] All loaded: %d, info=%@", success, adInfo);
}

- (void)pubeasyNativePasterDidPlayFinished:(NSDictionary *)adInfo {
    NSLog(@"[Native] Paster finished: %@", adInfo);
}

- (void)pubeasyNativeAdVideoPlayStart:(NSDictionary *)adInfo {
    NSLog(@"[Native] Video play start: %@", adInfo);
}

- (void)pubeasyNativeAdVideoPlayEnd:(NSDictionary *)adInfo {
    NSLog(@"[Native] Video play end: %@", adInfo);
}

- (void)pubeasyNativeAdDisLikeInfo:(NSDictionary *)dislikeInfo adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Native] Dislike: %@, adInfo=%@", dislikeInfo, adInfo);
}

@end


