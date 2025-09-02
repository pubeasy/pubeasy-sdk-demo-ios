#import "ToponNativeViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkNative/ATAdManager+Native.h>
#import <AnyThinkNative/ATNativeADDelegate.h>
#import <AnyThinkNative/ATNativeADView.h>
#import <AnyThinkNative/ATNativeADConfiguration.h>

@interface ToponNativeViewController () <ATAdLoadingDelegate, ATNativeADDelegate>

@property (nonatomic, copy) NSString *placementID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIView *adContainer;
@property (nonatomic, strong) ATNativeADView *nativeView;

@end

@implementation ToponNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Native";

    // TopOn native placement id (provided by you).
    self.placementID = @"n6880405c2625f";

    self.adContainer = [[UIView alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, 320)];
    self.adContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.adContainer.backgroundColor = [UIColor secondarySystemBackgroundColor];
    [self.view addSubview:self.adContainer];

    self.loadButton = [self buildButtonWithTitle:@"Load&Show" action:@selector(onTapLoad) frame:CGRectMake(20, 120, 140, 44)];
    [self.view addSubview:self.loadButton];
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
    // Load a native ad via generic loader.
    [[ATAdManager sharedManager] loadADWithPlacementID:self.placementID extra:@{} delegate:self];
}

- (void)attachNativeIfReady {
    // Retrieve native offer and render using configuration.
    ATNativeAdOffer *offer = [[ATAdManager sharedManager] getNativeAdOfferWithPlacementID:self.placementID];
    if (offer == nil) {
        NSLog(@"[TopOn Native] Not ready");
        return;
    }
    ATNativeADConfiguration *config = [[ATNativeADConfiguration alloc] init];
    config.ADFrame = self.adContainer.bounds;
    config.context = @{};
    self.nativeView = [[ATNativeADView alloc] initWithConfiguration:config currentOffer:offer placementID:self.placementID];
    self.nativeView.delegate = self;
    self.nativeView.frame = self.adContainer.bounds;
    [self.adContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.adContainer addSubview:[self.nativeView embededAdView]];
}

#pragma mark - ATAdLoadingDelegate (required)

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Native][Load] Success: %@", placementID);
    [self attachNativeIfReady];
}

- (void)didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"[TopOn Native][Load] Failed: %@, error=%@", placementID, error);
}

#pragma mark - ATAdLoadingDelegate (optional - implement all)

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native][Revenue] %@, extra=%@", placementID, extra);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Native][Load] Start source: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Native][Load] Source success: %@, extra=%@", placementID, extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Native][Load] Source failed: %@, extra=%@, error=%@", placementID, extra, error);
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Native][Bid] Start: %@, extra=%@", placementID, extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Native][Bid] Success: %@, extra=%@", placementID, extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Native][Bid] Failed: %@, extra=%@, error=%@", placementID, extra, error);
}

#pragma mark - ATNativeADDelegate (required)

- (void)didShowNativeAdInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Did show: %@, extra=%@", placementID, extra);
}

- (void)didClickNativeAdInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Did click: %@, extra=%@", placementID, extra);
}

#pragma mark - ATNativeADDelegate (optional - implement all)

- (void)didStartPlayingVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Video start: %@, extra=%@", placementID, extra);
}

- (void)didEndPlayingVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Video end: %@, extra=%@", placementID, extra);
}

- (void)didTapCloseButtonInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Tap close: %@, extra=%@", placementID, extra);
}

- (void)didCloseDetailInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Detail closed: %@, extra=%@", placementID, extra);
}

- (void)didDeepLinkOrJumpInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"[TopOn Native] Deeplink/jump: %d, %@, extra=%@", success, placementID, extra);
}

- (void)didEnterFullScreenVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Enter full video: %@, extra=%@", placementID, extra);
}

- (void)didExitFullScreenVideoInAdView:(ATNativeADView *)adView placementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Native] Exit full video: %@, extra=%@", placementID, extra);
}

@end


