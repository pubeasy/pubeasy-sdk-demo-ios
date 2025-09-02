#import "PubeasyBannerViewController.h"
@import PubeasySDK;

@interface PubeasyBannerViewController () <PubeasyAdBannerDelegate>

@property (nonatomic, strong) PubeasyAdBanner *bannerView;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation PubeasyBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Banner";

    // Create banner view and set delegate.
    self.bannerView = [[PubeasyAdBanner alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 100)];
    self.bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.bannerView.delegate = self;
    self.bannerView.autoShow = NO; // Manual show for demo.
    // Banner ad unit id.
    [self.bannerView setAdUnitID:@"623FCE0A903A2F605569C8BD93225CBB"];
    [self.view addSubview:self.bannerView];

    // Buttons to load/show.
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
    // Load banner ad (manual show flow).
    [self.bannerView loadAdWithSceneId:nil];
}

- (void)onTapShow {
    // Show banner ad when ready (manual show flow).
    if (self.bannerView.isAdReady) {
        [self.bannerView showWithSceneId:nil];
    } else {
        NSLog(@"[Banner] Not ready");
    }
}

#pragma mark - PubeasyAdBannerDelegate (required)

- (void)pubeasyBannerAdLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Loaded: %@", adInfo);
}

- (void)pubeasyBannerAdImpression:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Impression: %@", adInfo);
}

- (void)pubeasyBannerAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Banner] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyBannerAdClicked:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Clicked: %@", adInfo);
}

#pragma mark - PubeasyAdBannerDelegate (optional - implement all)

- (void)pubeasyBannerAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Load failed: %@, error=%@", adInfo, error);
}

- (TradPlusNativeRenderer *)pubeasyBannerCustomRenderer {
    // Return nil to use default renderer. Replace it if you have custom renderer.
    return nil;
}

- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

- (void)pubeasyBannerAdStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Start load: %@", adInfo);
}

- (void)pubeasyBannerAdOneLayerStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Banner] One layer start load: %@", adInfo);
}

- (void)pubeasyBannerAdIsLoading:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Is loading: %@", adInfo);
}

- (void)pubeasyBannerAdBidStart:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Bid start: %@", adInfo);
}

- (void)pubeasyBannerAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error {
    NSLog(@"[Banner] Bid end: %@, error=%@", adInfo, error);
}

- (void)pubeasyBannerAdOneLayerLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Banner] One layer loaded: %@", adInfo);
}

- (void)pubeasyBannerAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Banner] One layer load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyBannerAdAllLoaded:(BOOL)success adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Banner] All loaded: %d, info=%@", success, adInfo);
}

- (void)pubeasyBannerAdClose:(NSDictionary *)adInfo {
    NSLog(@"[Banner] Closed: %@", adInfo);
}

@end


