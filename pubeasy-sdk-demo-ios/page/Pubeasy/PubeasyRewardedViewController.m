#import "PubeasyRewardedViewController.h"
@import PubeasySDK;

@interface PubeasyRewardedViewController () <PubeasyAdRewardedDelegate, PubeasyAdRewardedPlayAgainDelegate>

@property (nonatomic, strong) PubeasyAdRewarded *rewardedAd;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation PubeasyRewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Rewarded";

    // Initialize rewarded instance and set delegates.
    self.rewardedAd = [[PubeasyAdRewarded alloc] init];
    self.rewardedAd.delegate = self;
    self.rewardedAd.playAgainDelegate = self;
    // Rewarded ad unit id.
    [self.rewardedAd setAdUnitID:@"B11E1D8624F2DDF12DEF8FC92F35CF69"];

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
    [self.rewardedAd loadAd];
}

- (void)onTapShow {
    if (self.rewardedAd.isAdReady) {
        [self.rewardedAd showAdFromRootViewController:self sceneId:nil];
    } else {
        NSLog(@"[Rewarded] Not ready");
    }
}

#pragma mark - PubeasyAdRewardedDelegate (required)

- (void)pubeasyRewardedAdLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Loaded: %@", adInfo);
}

- (void)pubeasyRewardedAdImpression:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Impression: %@", adInfo);
}

- (void)pubeasyRewardedAdShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Rewarded] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyRewardedAdClicked:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Clicked: %@", adInfo);
}

- (void)pubeasyRewardedAdDismissed:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Dismissed: %@", adInfo);
}

- (void)pubeasyRewardedAdReward:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Reward: %@", adInfo);
}

#pragma mark - PubeasyAdRewardedDelegate (optional - implement all)

- (void)pubeasyRewardedAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyRewardedAdStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Start load: %@", adInfo);
}

- (void)pubeasyRewardedAdOneLayerStartLoad:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] One layer start load: %@", adInfo);
}

- (void)pubeasyRewardedAdIsLoading:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Is loading: %@", adInfo);
}

- (void)pubeasyRewardedAdBidStart:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Bid start: %@", adInfo);
}

- (void)pubeasyRewardedAdBidEnd:(NSDictionary *)adInfo error:(NSError *)error {
    NSLog(@"[Rewarded] Bid end: %@, error=%@", adInfo, error);
}

- (void)pubeasyRewardedAdOneLayerLoaded:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] One layer loaded: %@", adInfo);
}

- (void)pubeasyRewardedAdOneLayerLoad:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Rewarded] One layer load failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyRewardedAdAllLoaded:(BOOL)success adInfo:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] All loaded: %d, info=%@", success, adInfo);
}

- (void)pubeasyRewardedAdPlayStart:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Play start: %@", adInfo);
}

- (void)pubeasyRewardedAdPlayEnd:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] Play end: %@", adInfo);
}

- (void)pubeasyRewardedAdNoReward:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded] No reward: %@", adInfo);
}

#pragma mark - PubeasyAdRewardedPlayAgainDelegate (required + optional)

- (void)pubeasyRewardedAdPlayAgainImpression:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded-PlayAgain] Impression: %@", adInfo);
}

- (void)pubeasyRewardedAdPlayAgainShow:(NSDictionary *)adInfo didFailWithError:(NSError *)error {
    NSLog(@"[Rewarded-PlayAgain] Show failed: %@, error=%@", adInfo, error);
}

- (void)pubeasyRewardedAdPlayAgainClicked:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded-PlayAgain] Clicked: %@", adInfo);
}

- (void)pubeasyRewardedAdPlayAgainReward:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded-PlayAgain] Reward: %@", adInfo);
}

- (void)pubeasyRewardedAdPlayAgainPlayStart:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded-PlayAgain] Play start: %@", adInfo);
}

- (void)pubeasyRewardedAdPlayAgainPlayEnd:(NSDictionary *)adInfo {
    NSLog(@"[Rewarded-PlayAgain] Play end: %@", adInfo);
}

@end


