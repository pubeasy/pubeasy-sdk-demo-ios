#import "ToponBannerViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkBanner/ATAdManager+Banner.h>
#import <AnyThinkBanner/ATBannerView.h>
#import <AnyThinkBanner/ATBannerDelegate.h>

@interface ToponBannerViewController () <ATAdLoadingDelegate, ATBannerDelegate>

@property (nonatomic, copy) NSString *placementID;
@property (nonatomic, strong) ATBannerView *bannerView;
@property (nonatomic, strong) UIButton *loadButton;

@end

@implementation ToponBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Banner";

    // TopOn banner placement id (provided by you).
    self.placementID = @"n6880409ec42b6";

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
    // Load banner ad via generic loader, then retrieve and attach.
    [[ATAdManager sharedManager] loadADWithPlacementID:self.placementID extra:@{} delegate:self];
}

- (void)attachBannerIfReady {
    // Retrieve banner view when ready and attach to bottom.
    ATBannerView *view = [[ATAdManager sharedManager] retrieveBannerViewForPlacementID:self.placementID];
    if (view == nil) {
        NSLog(@"[TopOn Banner] Not ready");
        return;
    }
    self.bannerView = view;
    self.bannerView.delegate = self;
    self.bannerView.presentingViewController = self;
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bannerView];
    [NSLayoutConstraint activateConstraints:@[
        [self.bannerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.bannerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-12]
    ]];
}

#pragma mark - ATAdLoadingDelegate (required)

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Banner][Load] Success: %@", placementID);
    [self attachBannerIfReady];
}

- (void)didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"[TopOn Banner][Load] Failed: %@, error=%@", placementID, error);
}

#pragma mark - ATAdLoadingDelegate (optional - implement all)

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner][Revenue] %@, extra=%@", placementID, extra);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Banner][Load] Start source: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Banner][Load] Source success: %@, extra=%@", placementID, extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Banner][Load] Source failed: %@, extra=%@, error=%@", placementID, extra, error);
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Banner][Bid] Start: %@, extra=%@", placementID, extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Banner][Bid] Success: %@, extra=%@", placementID, extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Banner][Bid] Failed: %@, extra=%@, error=%@", placementID, extra, error);
}

#pragma mark - ATBannerDelegate (required)

- (void)bannerView:(ATBannerView *)bannerView didShowAdWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner] Did show: %@, extra=%@", placementID, extra);
}

- (void)bannerView:(ATBannerView *)bannerView didClickWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner] Did click: %@, extra=%@", placementID, extra);
}

#pragma mark - ATBannerDelegate (optional - implement all)

- (void)bannerView:(ATBannerView *)bannerView didAutoRefreshWithPlacement:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner] Auto refresh: %@, extra=%@", placementID, extra);
}

- (void)bannerView:(ATBannerView *)bannerView failedToAutoRefreshWithPlacementID:(NSString *)placementID error:(NSError *)error {
    NSLog(@"[TopOn Banner] Auto refresh failed: %@, error=%@", placementID, error);
}

- (void)bannerView:(ATBannerView *)bannerView didTapCloseButtonWithPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner] Close button: %@, extra=%@", placementID, extra);
}

- (void)bannerView:(ATBannerView *)bannerView didLPCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Banner] LP close: %@, extra=%@", placementID, extra);
}

- (void)bannerView:(ATBannerView *)bannerView didDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"[TopOn Banner] Deeplink/jump: %d, %@, extra=%@", success, placementID, extra);
}

@end


