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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseTabBarController *baseTabBarController;
@property (strong, nonatomic) BaseNavigationController *baseHomeNAV;
@property (strong, nonatomic) BaseNavigationController *baseProfileNAV;
@property (strong, nonatomic) BaseNavigationController *baseNotificationNAV;
@property (strong, nonatomic) BaseNavigationController *baseSettingNAV;

@property (assign, nonatomic) BOOL keyShowNotificationBanner;
@property (assign, nonatomic) BOOL deviceTokenExist;

- (void)showLogginVC;
- (void)clearData;
- (void)setupNotifications:(UIApplication*)application;

@end

