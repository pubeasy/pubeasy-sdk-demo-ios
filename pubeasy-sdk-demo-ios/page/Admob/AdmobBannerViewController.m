#import "AdmobBannerViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdmobBannerViewController () <GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;
@property (nonatomic, copy) NSString *adUnitID;
@property (nonatomic, strong) UIButton *loadButton;

@end

@implementation AdmobBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Banner";

    // Banner ad unit id (provided by you).
    self.adUnitID = @"ca-app-pub-4514029919391152/5724570518";

    // Create banner view with a standard size.
    self.bannerView = [[GADBannerView alloc] initWithAdSize:GADAdSizeBanner];
    self.bannerView.adUnitID = self.adUnitID;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.bannerView];

    // Center the banner at the bottom.
    [NSLayoutConstraint activateConstraints:@[
        [self.bannerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.bannerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-12]
    ]];

    self.loadButton = [self buildButtonWithTitle:@"Load" action:@selector(onTapLoad) frame:CGRectMake(20, 120, 120, 44)];
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
    GADRequest *request = [GADRequest request];
    [self.bannerView loadRequest:request];
}

#pragma mark - GADBannerViewDelegate (implement all)

- (void)bannerViewDidReceiveAd:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Did receive ad");
}

- (void)bannerView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"[AdMob Banner] Failed to receive: %@", error);
}

- (void)bannerViewDidRecordImpression:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Impression recorded");
}

- (void)bannerViewDidRecordClick:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Click recorded");
}

- (void)bannerViewWillPresentScreen:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Will present screen");
}

- (void)bannerViewWillDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Will dismiss screen");
}

- (void)bannerViewDidDismissScreen:(GADBannerView *)bannerView {
    NSLog(@"[AdMob Banner] Did dismiss screen");
}

@end


