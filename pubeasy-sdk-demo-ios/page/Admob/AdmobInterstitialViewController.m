#import "AdmobInterstitialViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdmobInterstitialViewController () <GADFullScreenContentDelegate>

@property (nonatomic, strong) GADInterstitialAd *interstitial;
@property (nonatomic, copy) NSString *adUnitID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation AdmobInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Interstitial";

    // Interstitial ad unit id (provided by you).
    self.adUnitID = @"ca-app-pub-4514029919391152/3652068807";

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
    // Load an interstitial ad.
    GADRequest *request = [GADRequest request];
    __weak typeof(self) weakSelf = self;
    [GADInterstitialAd loadWithAdUnitID:self.adUnitID request:request completionHandler:^(GADInterstitialAd * _Nullable interstitialAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"[AdMob Interstitial] Load failed: %@", error);
            weakSelf.interstitial = nil;
            return;
        }
        weakSelf.interstitial = interstitialAd;
        weakSelf.interstitial.fullScreenContentDelegate = weakSelf;
        NSLog(@"[AdMob Interstitial] Loaded");
    }];
}

- (void)onTapShow {
    // Present if loaded.
    if (self.interstitial) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"[AdMob Interstitial] Not ready");
    }
}

#pragma mark - GADFullScreenContentDelegate (implement all)

- (void)adDidRecordImpression:(id)ad {
    NSLog(@"[AdMob Interstitial] Impression recorded");
}

- (void)adDidRecordClick:(id)ad {
    NSLog(@"[AdMob Interstitial] Click recorded");
}

- (void)adWillPresentFullScreenContent:(id)ad {
    NSLog(@"[AdMob Interstitial] Will present");
}

- (void)adDidDismissFullScreenContent:(id)ad {
    NSLog(@"[AdMob Interstitial] Did dismiss");
    // Interstitial cannot be reused; clear reference.
    self.interstitial = nil;
}

- (void)ad:(id)ad didFailToPresentFullScreenContentWithError:(NSError *)error {
    NSLog(@"[AdMob Interstitial] Failed to present: %@", error);
    self.interstitial = nil;
}

@end


