#import "AdmobNativeViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AdmobNativeViewController () <GADNativeAdLoaderDelegate, GADNativeAdDelegate>

@property (nonatomic, strong) GADAdLoader *adLoader;
@property (nonatomic, strong) GADNativeAd *nativeAd;
@property (nonatomic, copy) NSString *adUnitID;
@property (nonatomic, strong) UIButton *loadButton;
@property (nonatomic, strong) UIView *adContainer;

@end

@implementation AdmobNativeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"Native";

    self.adUnitID = @"ca-app-pub-4514029919391152/5349165999";

    self.adContainer = [[UIView alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, 320)];
    self.adContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.adContainer.backgroundColor = [UIColor secondarySystemBackgroundColor];
    [self.view addSubview:self.adContainer];

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
    // Create ad loader for native ads.
    GADMultipleAdsAdLoaderOptions *multipleOptions = [[GADMultipleAdsAdLoaderOptions alloc] init];
    multipleOptions.numberOfAds = 1;
    self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:self.adUnitID rootViewController:self adTypes:@[ GADAdLoaderAdTypeNative ] options:@[ multipleOptions ]];
    self.adLoader.delegate = self;
    [self.adLoader loadRequest:[GADRequest request]];
}

#pragma mark - GADNativeAdLoaderDelegate

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error {
    NSLog(@"[AdMob Native] Load failed: %@", error);
}

- (void)adLoader:(GADAdLoader *)adLoader didReceiveNativeAd:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Loaded");
    self.nativeAd = nativeAd;
    self.nativeAd.delegate = self;

    // Simple rendering: show headline in a label.
    [self.adContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *title = [[UILabel alloc] initWithFrame:self.adContainer.bounds];
    title.numberOfLines = 0;
    title.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    title.text = nativeAd.headline ?: @"(no headline)";
    [self.adContainer addSubview:title];
}

#pragma mark - GADNativeAdDelegate (implement all)

- (void)nativeAdDidRecordImpression:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Impression recorded");
}

- (void)nativeAdDidRecordClick:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Click recorded");
}

- (void)nativeAdWillPresentScreen:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Will present screen");
}

- (void)nativeAdWillDismissScreen:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Will dismiss screen");
}

- (void)nativeAdDidDismissScreen:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Did dismiss screen");
}

- (void)nativeAdIsMuted:(GADNativeAd *)nativeAd {
    NSLog(@"[AdMob Native] Muted");
}

@end


