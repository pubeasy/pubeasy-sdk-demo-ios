#import "ToponInterstitialViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkInterstitial/ATAdManager+Interstitial.h>
#import <AnyThinkInterstitial/ATInterstitialDelegate.h>

@interface ToponInterstitialViewController () <ATAdLoadingDelegate, ATInterstitialDelegate>

@property (nonatomic, copy) NSString *placementID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation ToponInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Interstitial";

    // TopOn interstitial placement id (provided by you).
    self.placementID = @"n6880407a9ac97";

    // Build simple UI.
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
    // Load an interstitial ad via generic loader.
    [[ATAdManager sharedManager] loadADWithPlacementID:self.placementID extra:@{} delegate:self];
}

- (void)onTapShow {
    // Present if ready.
    if ([[ATAdManager sharedManager] interstitialReadyForPlacementID:self.placementID]) {
        [[ATAdManager sharedManager] showInterstitialWithPlacementID:self.placementID inViewController:self delegate:self];
    } else {
        NSLog(@"[TopOn Interstitial] Not ready");
    }
}

#pragma mark - ATAdLoadingDelegate (required)

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Interstitial][Load] Success: %@", placementID);
}

- (void)didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"[TopOn Interstitial][Load] Failed: %@, error=%@", placementID, error);
}

#pragma mark - ATAdLoadingDelegate (optional - implement all)

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial][Revenue] %@, extra=%@", placementID, extra);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Interstitial][Load] Start source: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Interstitial][Load] Source success: %@, extra=%@", placementID, extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Interstitial][Load] Source failed: %@, extra=%@, error=%@", placementID, extra, error);
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Interstitial][Bid] Start: %@, extra=%@", placementID, extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Interstitial][Bid] Success: %@, extra=%@", placementID, extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Interstitial][Bid] Failed: %@, extra=%@, error=%@", placementID, extra, error);
}

#pragma mark - ATInterstitialDelegate (required)

- (void)interstitialDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Did show: %@, extra=%@", placementID, extra);
}

- (void)interstitialDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Did click: %@, extra=%@", placementID, extra);
}

- (void)interstitialDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Did close: %@, extra=%@", placementID, extra);
}

#pragma mark - ATInterstitialDelegate (optional - implement all)

- (void)interstitialFailedToShowForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Failed to show: %@, error=%@, extra=%@", placementID, error, extra);
}

- (void)interstitialDidStartPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Video start: %@, extra=%@", placementID, extra);
}

- (void)interstitialDidEndPlayingVideoForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Video end: %@, extra=%@", placementID, extra);
}

- (void)interstitialDidFailToPlayVideoForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] Video fail: %@, error=%@, extra=%@", placementID, error, extra);
}

- (void)interstitialDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"[TopOn Interstitial] Deeplink/jump result: %d, %@, extra=%@", success, placementID, extra);
}

- (void)interstitialDidLPCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Interstitial] LP closed: %@, extra=%@", placementID, extra);
}

@end


