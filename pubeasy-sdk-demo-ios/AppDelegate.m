//
//  AppDelegate.m
//  pubeasy-sdk-demo-ios
//
//  Created by gy on 2025/9/2.
//

#import "AppDelegate.h"
@import PubeasySDK;
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AnyThinkSDK/AnyThinkSDK.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // It is recommended to call this before initializing the PubeasySDK
    if (@available(iOS 14.5, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
        }];
    }
    // Override point for customization after application launc
    
    [PubeasyManager initSDK:@"0E9CBC7B740B3776E1CCE54D6BA82B46" completionBlock:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"PubeasyManager sdk init success!");
        }
    }];
    
    // 初始化TopOn SDK
    [[ATAPI sharedInstance] startWithAppID:@"h68803d468189e"
                                    appKey:@"a9648f070ab3edebdc5cc21ea8822e726"
                                     error:nil];
    
    // Initialize the Google Mobile Ads SDK.
    [GADMobileAds.sharedInstance startWithCompletionHandler:nil];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
