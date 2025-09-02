#import "PubeasyInterstitialViewController.h"
@import PubeasySDK;

@interface PubeasyInterstitialViewController () <PubeasyAdInterstitialDelegate>

@property (nonatomic, strong) PubeasyAdInterstitial *interstitialAd;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation PubeasyInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Interstitial";

    // Initialize interstitial instance and set delegate.
    self.interstitialAd = [[PubeasyAdInterstitial alloc] init];
    self.interstitialAd.delegate = self;
    // Interstitial ad unit id.
    [self.interstitialAd setAdUnitID:@"F12C3A991B46844545DFDDFD830E95AD"];

    // Build simple UI: Load and Show buttons.
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
    // Start loading an interstitial ad.
    [self.interstitialAd loadAd];
}

- (void)onTapShow {
    // Show interstitial if ready. Root VC can be nil to let SDK resolve.
    if (self.interstitialAd.isAdReady) {
        [self.interstitialAd showAdFromRootViewController:self sceneId:nil];
    } else {
        NSLog(@"[Interstitial] Not ready");
    }
}

#pragma mark - PubeasyAdInterstitialDelegate (required)

- (void)pubeasyInterstitialAdLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Loaded: %@", adInfo);
}

- (void)pubeasyInterstitialAdImpression:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Impression: %@", adInfo);
}

- (void)pubeasyInterstitialAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Interstitial] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyInterstitialAdClicked:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Clicked: %@", adInfo);
}

- (void)pubeasyInterstitialAdDismissed:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Dismissed: %@", adInfo);
}

#pragma mark - PubeasyAdInterstitialDelegate (optional - implement all)

- (void)pubeasyInterstitialAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyInterstitialAdStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Start load: %@", adInfo);
}

- (void)pubeasyInterstitialAdOneLayerStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] One layer start load: %@", adInfo);
}

- (void)pubeasyInterstitialAdIsLoading:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Is loading: %@", adInfo);
}

- (void)pubeasyInterstitialAdBidStart:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Bid start: %@", adInfo);
}

- (void)pubeasyInterstitialAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error {
    NSLog(@"[Interstitial] Bid end: %@, error=%@", adInfo, error);
}

- (void)pubeasyInterstitialAdOneLayerLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] One layer loaded: %@", adInfo);
}

- (void)pubeasyInterstitialAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Interstitial] One layer load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyInterstitialAdAllLoaded:(BOOL)success adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] All loaded: %d, info=%@", success, adInfo);
}

- (void)pubeasyInterstitialAdPlayStart:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Play start: %@", adInfo);
}

- (void)pubeasyInterstitialAdPlayEnd:(NSDictionary *)adInfo {
    NSLog(@"[Interstitial] Play end: %@", adInfo);
}

@end


