//
//  AppDelegate.m
//  CoAssest
//
//  Created by Macintosh HD on 6/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "ProfileViewController.h"
#import "HomeListViewController.h"
#import "SettingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UILabel appearanceWhenContainedIn:[UIAlertView class], nil] setTextColor:[UIColor redColor]];
    [self gotoHome];
    
    [self.window makeKeyAndVisible];
    [self _setUp3rdSDKs];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

#pragma mark - Method

- (void)_setUp3rdSDKs {
    [Fabric with:@[CrashlyticsKit]];
}

- (void)gotoHome {
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    NSArray *arrayNAV = @[[self _setupHomeListViewController],[self _setupProfileViewController],[self _setupSettingViewController]];
    tabBar.viewControllers = arrayNAV;
    self.window.rootViewController = tabBar;
}

#pragma mark - Private

//Setup Home
- (BaseNavigationController*)_setupHomeListViewController {
    HomeListViewController *homeVC = [[HomeListViewController alloc] init];
    BaseNavigationController *homeNAV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    UITabBarItem *tabbarHome = [[UITabBarItem alloc]initWithTitle:m_string(@"Home")
                                                            image:[UIImage imageNamed:@"ic_home"]
                                                    selectedImage:[UIImage imageNamed:@"ic_home_heightlight"]];
    homeNAV.tabBarItem = tabbarHome;
    return homeNAV;
}

//Setup Profile
- (BaseNavigationController*)_setupProfileViewController {
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    BaseNavigationController *profileNAV = [[BaseNavigationController alloc] initWithRootViewController:profileVC];
    UITabBarItem *tabbarProfile = [[UITabBarItem alloc]initWithTitle:m_string(@"Profile")
                                                               image:[UIImage imageNamed:@"ic_contac_2"]
                                                       selectedImage:[UIImage imageNamed:@"ic_contac_2_heightlight"]];
    profileNAV.tabBarItem = tabbarProfile;
    return profileNAV;
}

//Setup Setting
- (BaseNavigationController*)_setupSettingViewController {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    BaseNavigationController *settingNAV = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
    UITabBarItem *tabbarSetting = [[UITabBarItem alloc]initWithTitle:m_string(@"Settings")
                                                               image:[UIImage imageNamed:@"ic_setting_2_heighlight"]
                                                       selectedImage:[UIImage imageNamed:@"ic_setting_2"]];
    settingNAV.tabBarItem = tabbarSetting;
    return settingNAV;
}

@end
