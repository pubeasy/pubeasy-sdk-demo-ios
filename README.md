This is a demo showing how to integrate and display ads with the Pubeasy SDK on iOS.
Dependency versions:
PubeasySDK 0.3.9


## Getting Started (iOS)
### 1) Pod Dependencies
Add dependencies to your Podfile and install:
```ruby
# iOS 12+
platform :ios, '12.0'
inhibit_all_warnings!

target 'pubeasy-sdk-demo-ios' do
  use_frameworks!
  # PubeasySDK
  pod 'PubeasySDK', '0.3.9'
  # Google AdMob iOS SDK
  pod 'Google-Mobile-Ads-SDK','12.4.0'
  # TopOn iOS SDK (optional)
  pod 'TPNiOS','6.4.87'
end
```

Install:
```bash
pod install --repo-update
```

### 2) Info.plist Setup
- Add `NSUserTrackingUsageDescription` (ATT purpose string).
- If you need SKAdNetwork attribution, add `SKAdNetworkItems` according to each network’s documentation.

Example (snippet):
```xml
<key>NSUserTrackingUsageDescription</key>
<string>We use your device information to deliver personalized ads.</string>
```

### 3) SDK Initialization (Objective‑C)
Initialize in `application:didFinishLaunchingWithOptions:` and request ATT authorization on iOS 14.5+.
```objectivec
@import PubeasySDK;
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // iOS 14.5+ ATT authorization
    if (@available(iOS 14.5, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
    }

    // Initialize Pubeasy SDK (replace with your AppKey)
    [PubeasyManager initSDK:@"0E9CBC7B740B3776E1CCE54D6BA82B46" completionBlock:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"PubeasyManager sdk init success!");
        }
    }];

    // Initialize TopOn (optional)
    [[ATAPI sharedInstance] startWithAppID:@"h68803d468189e"
                                    appKey:@"a9648f070ab3edebdc5cc21ea8822e726"
                                     error:nil];

    // Initialize Google Mobile Ads
    [GADMobileAds.sharedInstance startWithCompletionHandler:nil];

    return YES;
}
```


## Ad Formats and Integration Examples (iOS)
The following examples are aligned with the demo project (Objective‑C). Replace the ad unit IDs with your own IDs configured in the Pubeasy console.

### Banner
Create `PubeasyAdBanner`, set `delegate` and the ad unit ID, call `loadAdWithSceneId:` to load, and call `showWithSceneId:` to display when ready (or set `autoShow=YES` to auto‑show).
```objectivec
@interface PubeasyBannerViewController () <PubeasyAdBannerDelegate>
@property (nonatomic, strong) PubeasyAdBanner *bannerView;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[PubeasyAdBanner alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, self.view.bounds.size.width, 100)];
    self.bannerView.delegate = self;
    self.bannerView.autoShow = NO; // manual show for demo
    [self.bannerView setAdUnitID:@"YOUR_BANNER_PLACEMENT_ID"];
    [self.view addSubview:self.bannerView];
}

- (void)loadBanner {
    [self.bannerView loadAdWithSceneId:nil];
}

- (void)showBanner {
    if (self.bannerView.isAdReady) {
        [self.bannerView showWithSceneId:nil];
    }
}
```

Common callbacks (excerpt):
```objectivec
- (void)pubeasyBannerAdLoaded:(NSDictionary *)adInfo {}
- (void)pubeasyBannerAdImpression:(NSDictionary *)adInfo {}
- (void)pubeasyBannerAdClicked:(NSDictionary *)adInfo {}
- (void)pubeasyBannerAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {}
```

### Native
`PubeasyAdNative` supports template rendering. Set template size before loading if needed, then render the ad into your container view.
```objectivec
@interface PubeasyNativeViewController () <PubeasyAdNativeDelegate>
@property (nonatomic, strong) PubeasyAdNative *nativeAd;
@property (nonatomic, strong) UIView *adContainer;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nativeAd = [[PubeasyAdNative alloc] init];
    self.nativeAd.delegate = self;
    [self.nativeAd setAdUnitID:@"YOUR_NATIVE_PLACEMENT_ID"];
    self.adContainer = [[UIView alloc] initWithFrame:CGRectMake(16, 200, self.view.bounds.size.width - 32, 300)];
    [self.view addSubview:self.adContainer];
}

- (void)loadNative {
    [self.nativeAd setTemplateRenderSize:CGSizeMake(self.adContainer.bounds.size.width, 300)];
    [self.nativeAd loadAd];
}

- (void)showNative {
    if (self.nativeAd.isAdReady) {
        [self.nativeAd showADWithRenderingViewClass:[UIView class] subview:self.adContainer sceneId:nil];
    }
}
```

Common callbacks (excerpt):
```objectivec
- (void)pubeasyNativeAdLoaded:(NSDictionary *)adInfo {}
- (void)pubeasyNativeAdImpression:(NSDictionary *)adInfo {}
- (void)pubeasyNativeAdClicked:(NSDictionary *)adInfo {}
- (void)pubeasyNativeAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {}
```

### Splash
Pass a `UIWindow` when loading; when ready, call `show` to display.
```objectivec
@interface PubeasySplashViewController () <PubeasyAdSplashDelegate>
@property (nonatomic, strong) PubeasyAdSplash *splashAd;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.splashAd = [[PubeasyAdSplash alloc] init];
    self.splashAd.delegate = self;
    [self.splashAd setAdUnitID:@"YOUR_SPLASH_PLACEMENT_ID"];
}

- (void)loadSplash {
    UIWindow *keyWindow = UIApplication.sharedApplication.windows.firstObject ?: UIApplication.sharedApplication.delegate.window;
    if (keyWindow) {
        [self.splashAd loadAdWithWindow:keyWindow bottomView:nil];
    }
}

- (void)showSplash {
    if (self.splashAd.isAdReady) {
        [self.splashAd show];
    }
}
```

Common callbacks (excerpt):
```objectivec
- (void)pubeasySplashAdLoaded:(NSDictionary *)adInfo {}
- (void)pubeasySplashAdImpression:(NSDictionary *)adInfo {}
- (void)pubeasySplashAdClicked:(NSDictionary *)adInfo {}
- (void)pubeasySplashAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {}
```

### Interstitial
```objectivec
@interface PubeasyInterstitialViewController () <PubeasyAdInterstitialDelegate>
@property (nonatomic, strong) PubeasyAdInterstitial *interstitialAd;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.interstitialAd = [[PubeasyAdInterstitial alloc] init];
    self.interstitialAd.delegate = self;
    [self.interstitialAd setAdUnitID:@"YOUR_INTERSTITIAL_PLACEMENT_ID"];
}

- (void)loadInterstitial {
    [self.interstitialAd loadAd];
}

- (void)showInterstitial {
    if (self.interstitialAd.isAdReady) {
        [self.interstitialAd showAdFromRootViewController:self sceneId:nil];
    }
}
```

Common callbacks (excerpt):
```objectivec
- (void)pubeasyInterstitialAdLoaded:(NSDictionary *)adInfo {}
- (void)pubeasyInterstitialAdImpression:(NSDictionary *)adInfo {}
- (void)pubeasyInterstitialAdClicked:(NSDictionary *)adInfo {}
- (void)pubeasyInterstitialAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {}
```

### Rewarded
```objectivec
@interface PubeasyRewardedViewController () <PubeasyAdRewardedDelegate>
@property (nonatomic, strong) PubeasyAdRewarded *rewardedAd;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rewardedAd = [[PubeasyAdRewarded alloc] init];
    self.rewardedAd.delegate = self;
    [self.rewardedAd setAdUnitID:@"YOUR_REWARDED_PLACEMENT_ID"];
}

- (void)loadRewarded {
    [self.rewardedAd loadAd];
}

- (void)showRewarded {
    if (self.rewardedAd.isAdReady) {
        [self.rewardedAd showAdFromRootViewController:self sceneId:nil];
    }
}
```

Common callbacks (excerpt):
```objectivec
- (void)pubeasyRewardedAdLoaded:(NSDictionary *)adInfo {}
- (void)pubeasyRewardedAdImpression:(NSDictionary *)adInfo {}
- (void)pubeasyRewardedAdClicked:(NSDictionary *)adInfo {}
- (void)pubeasyRewardedAdLoadFailWithError:(NSError *)error adInfo:(NSDictionary *)adInfo {}
- (void)pubeasyRewardedAdReward:(NSDictionary *)adInfo {}
```


## Privacy and Consent (iOS)
- ATT (AppTrackingTransparency): request authorization on iOS 14.5+ (see the init code above).
- GDPR/LGPD/CCPA: recommend using Google UMP (iOS) to collect consent and propagate it to networks:
  - AdMob iOS UMP docs: `https://developers.google.com/admob/ios/privacy`.
- If you use TopOn, apply its iOS privacy setup as required by your regions.


## AdMob Custom Event (iOS)
This project includes `AdmobCMediationEventAdapter.framework` for AdMob custom events. Configure a custom event in the AdMob waterfall to connect to Pubeasy.

Backend configuration highlights:
- Add a Custom event in the AdMob waterfall.
- Class Name: `AdmobCMediationEventAdapter`
- Parameters (example):
```json
{ "appid": "Your Pubeasy App ID", "pid": "Your Pubeasy Placement ID" }
```

Set eCPM priorities for testing and tuning as needed.


## Testing and Verification
- Use test mode or official test ad units where available.
- For debugging, you can temporarily elevate the custom event eCPM to prioritize Pubeasy during integration tests.


Docs:  
https://www.pubeasy.io/doc.html


