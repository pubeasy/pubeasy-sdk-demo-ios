#import "AdmobRewardedViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdmobRewardedViewController () <GADFullScreenContentDelegate>

@property (nonatomic, strong) GADRewardedAd *rewardedAd;
@property (nonatomic, copy) NSString *adUnitID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation AdmobRewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Rewarded";

    // Rewarded ad unit id (provided by you).
    self.adUnitID = @"ca-app-pub-4514029919391152/2364087611";

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
    // Load a rewarded ad.
    GADRequest *request = [GADRequest request];
    __weak typeof(self) weakSelf = self;
    [GADRewardedAd loadWithAdUnitID:self.adUnitID request:request completionHandler:^(GADRewardedAd * _Nullable rewardedAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"[AdMob Rewarded] Load failed: %@", error);
            weakSelf.rewardedAd = nil;
            return;
        }
        weakSelf.rewardedAd = rewardedAd;
        weakSelf.rewardedAd.fullScreenContentDelegate = weakSelf;
        NSLog(@"[AdMob Rewarded] Loaded");
    }];
}

- (void)onTapShow {
    if (self.rewardedAd) {
        __weak typeof(self) weakSelf = self;
        [self.rewardedAd presentFromRootViewController:self userDidEarnRewardHandler:^{
            GADAdReward *reward = weakSelf.rewardedAd.adReward;
            NSLog(@"[AdMob Rewarded] User earned reward: %@ %lf", reward.type, reward.amount.doubleValue);
        }];
    } else {
        NSLog(@"[AdMob Rewarded] Not ready");
    }
}

#pragma mark - GADFullScreenContentDelegate (implement all)

- (void)adDidRecordImpression:(id)ad {
    NSLog(@"[AdMob Rewarded] Impression recorded");
}

- (void)adDidRecordClick:(id)ad {
    NSLog(@"[AdMob Rewarded] Click recorded");
}

- (void)adWillPresentFullScreenContent:(id)ad {
    NSLog(@"[AdMob Rewarded] Will present");
}

- (void)adDidDismissFullScreenContent:(id)ad {
    NSLog(@"[AdMob Rewarded] Did dismiss");
    self.rewardedAd = nil;
}

- (void)ad:(id)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
    NSLog(@"[AdMob Rewarded] Failed to present: %@", error);
    self.rewardedAd = nil;
}

@end


