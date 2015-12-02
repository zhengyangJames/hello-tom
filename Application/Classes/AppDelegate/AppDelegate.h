//
//  AppDelegate.h
//  CoAssest
//
//  Created by Macintosh HD on 6/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"
#import "WSURLSessionManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarController *baseTabBarController;
@property (strong, nonatomic) BaseNavigationController *baseHomeNAV;
@property (strong, nonatomic) BaseNavigationController *baseProfileNAV;
@property (strong, nonatomic) BaseNavigationController *baseNotificationNAV;
@property (strong, nonatomic) BaseNavigationController *baseSettingNAV;

@property (assign, nonatomic) BOOL keyShowNotificationBanner;

- (void)showLogginVC;
- (void)clearData;
- (void)setupNotifications:(UIApplication*)application;
- (void)checkGetNotificationCountHandler:(WSURLSessionHandler)handler;
- (void)checkAndCreadDeviceTokenHandler:(WSURLSessionHandler)handler;
- (void)callGetNotificationListHandler:(WSURLSessionHandler)handler;

@end

