#import "ToponSplashViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkSplash/ATAdManager+Splash.h>
#import <AnyThinkSplash/ATSplashDelegate.h>

@interface ToponSplashViewController () <ATAdLoadingDelegate, ATSplashDelegate>

@property (nonatomic, copy) NSString *placementID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation ToponSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Splash";

    // TopOn splash placement id (provided by you).
    self.placementID = @"n6880408c60791";

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
    // Preload splash into cache; containerView can be nil.
    [[ATAdManager sharedManager] loadADWithPlacementID:self.placementID extra:@{} delegate:self containerView:nil];
}

- (void)onTapShow {
    // Show splash with current window.
    UIWindow *keyWindow = UIApplication.sharedApplication.windows.firstObject;
    ATShowConfig *config = [[ATShowConfig alloc] init];
    [[ATAdManager sharedManager] showSplashWithPlacementID:self.placementID config:config window:keyWindow inViewController:self extra:nil delegate:self];
}

#pragma mark - ATAdLoadingDelegate (required)

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Splash][Load] Success: %@", placementID);
}

- (void)didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"[TopOn Splash][Load] Failed: %@, error=%@", placementID, error);
}

#pragma mark - ATAdLoadingDelegate (optional - implement all)

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash][Revenue] %@, extra=%@", placementID, extra);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Splash][Load] Start source: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Splash][Load] Source success: %@, extra=%@", placementID, extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Splash][Load] Source failed: %@, extra=%@, error=%@", placementID, extra, error);
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Splash][Bid] Start: %@, extra=%@", placementID, extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Splash][Bid] Success: %@, extra=%@", placementID, extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Splash][Bid] Failed: %@, extra=%@, error=%@", placementID, extra, error);
}

#pragma mark - ATSplashDelegate (required)

- (void)splashDidShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Did show: %@, extra=%@", placementID, extra);
}

- (void)splashDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Did click: %@, extra=%@", placementID, extra);
}

- (void)splashDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Did close: %@, extra=%@", placementID, extra);
}

#pragma mark - ATSplashDelegate (optional - implement all)

- (void)splashWillCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Will close: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingSplashADWithPlacementID:(NSString *)placementID isTimeout:(BOOL)isTimeout {
    NSLog(@"[TopOn Splash] Did finish loading: %@, timeout=%d", placementID, isTimeout);
}

- (void)didTimeoutLoadingSplashADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Splash] Did timeout loading: %@", placementID);
}

- (void)splashDidShowFailedForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Show failed: %@, error=%@, extra=%@", placementID, error, extra);
}

- (void)splashDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"[TopOn Splash] Deeplink/jump: %d, %@, extra=%@", success, placementID, extra);
}

- (void)splashDetailDidClosedForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Detail closed: %@, extra=%@", placementID, extra);
}

- (void)splashDetailWillShowForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Detail will show: %@, extra=%@", placementID, extra);
}

- (void)splashZoomOutViewDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] ZoomOut click: %@, extra=%@", placementID, extra);
}

- (void)splashZoomOutViewDidCloseForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] ZoomOut close: %@, extra=%@", placementID, extra);
}

- (void)splashCountdownTime:(NSInteger)countdown forPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Splash] Countdown: %ld, %@, extra=%@", (long)countdown, placementID, extra);
}

- (void)splashVideoPlayerForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra statusChanged:(ATVideoPlayerStatus)videoPlayerStatus {
    NSLog(@"[TopOn Splash] Video status: %lu, %@, extra=%@", (unsigned long)videoPlayerStatus, placementID, extra);
}

- (void)splashVideoPlayerForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra playerError:(NSError *__nullable)error {
    NSLog(@"[TopOn Splash] Video error: %@, %@, extra=%@", error, placementID, extra);
}

@end


