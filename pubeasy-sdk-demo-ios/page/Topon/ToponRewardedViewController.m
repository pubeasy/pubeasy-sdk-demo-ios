#import "ToponRewardedViewController.h"
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <AnyThinkRewardedVideo/ATAdManager+RewardedVideo.h>
#import <AnyThinkRewardedVideo/ATRewardedVideoDelegate.h>

@interface ToponRewardedViewController () <ATAdLoadingDelegate, ATRewardedVideoDelegate>

@property (nonatomic, copy) NSString *placementID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIButton *showButton;

@end

@implementation ToponRewardedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Rewarded";

    // TopOn rewarded placement id (provided by you).
    self.placementID = @"n688040b5ca6b0";

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
    // Load a rewarded video ad via generic loader.
    [[ATAdManager sharedManager] loadADWithPlacementID:self.placementID extra:@{} delegate:self];
}

- (void)onTapShow {
    if ([[ATAdManager sharedManager] rewardedVideoReadyForPlacementID:self.placementID]) {
        [[ATAdManager sharedManager] showRewardedVideoWithPlacementID:self.placementID inViewController:self delegate:self];
    } else {
        NSLog(@"[TopOn Rewarded] Not ready");
    }
}

#pragma mark - ATAdLoadingDelegate (required)

- (void)didFinishLoadingADWithPlacementID:(NSString *)placementID {
    NSLog(@"[TopOn Rewarded][Load] Success: %@", placementID);
}

- (void)didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error {
    NSLog(@"[TopOn Rewarded][Load] Failed: %@, error=%@", placementID, error);
}

#pragma mark - ATAdLoadingDelegate (optional - implement all)

- (void)didRevenueForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded][Revenue] %@, extra=%@", placementID, extra);
}

- (void)didStartLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Rewarded][Load] Start source: %@, extra=%@", placementID, extra);
}

- (void)didFinishLoadingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Rewarded][Load] Source success: %@, extra=%@", placementID, extra);
}

- (void)didFailToLoadADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Rewarded][Load] Source failed: %@, extra=%@, error=%@", placementID, extra, error);
}

- (void)didStartBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Rewarded][Bid] Start: %@, extra=%@", placementID, extra);
}

- (void)didFinishBiddingADSourceWithPlacementID:(NSString *)placementID extra:(NSDictionary*)extra {
    NSLog(@"[TopOn Rewarded][Bid] Success: %@, extra=%@", placementID, extra);
}

- (void)didFailBiddingADSourceWithPlacementID:(NSString*)placementID extra:(NSDictionary*)extra error:(NSError*)error {
    NSLog(@"[TopOn Rewarded][Bid] Failed: %@, extra=%@, error=%@", placementID, extra, error);
}

#pragma mark - ATRewardedVideoDelegate (required)

- (void)rewardedVideoDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Play start: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoDidEndPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Play end: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Click: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoDidCloseForPlacementID:(NSString *)placementID rewarded:(BOOL)rewarded extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Close: %@, rewarded=%d, extra=%@", placementID, rewarded, extra);
}

- (void)rewardedVideoDidRewardSuccessForPlacemenID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Reward success: %@, extra=%@", placementID, extra);
}

#pragma mark - ATRewardedVideoDelegate (optional - implement all)

- (void)rewardedVideoDidFailToPlayForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded] Fail to play: %@, error=%@, extra=%@", placementID, error, extra);
}

- (void)rewardedVideoDidDeepLinkOrJumpForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra result:(BOOL)success {
    NSLog(@"[TopOn Rewarded] Deeplink/jump: %d, %@, extra=%@", success, placementID, extra);
}

- (void)rewardedVideoAgainDidStartPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded-Again] Play start: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoAgainDidEndPlayingForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded-Again] Play end: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoAgainDidFailToPlayForPlacementID:(NSString *)placementID error:(NSError *)error extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded-Again] Fail to play: %@, error=%@, extra=%@", placementID, error, extra);
}

- (void)rewardedVideoAgainDidClickForPlacementID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded-Again] Click: %@, extra=%@", placementID, extra);
}

- (void)rewardedVideoAgainDidRewardSuccessForPlacemenID:(NSString *)placementID extra:(NSDictionary *)extra {
    NSLog(@"[TopOn Rewarded-Again] Reward success: %@, extra=%@", placementID, extra);
}

@end


