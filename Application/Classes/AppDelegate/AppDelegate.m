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
#import "TabProfileController.h"
#import "HomeListViewController.h"
#import "SettingViewController.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@interface AppDelegate ()<UITabBarControllerDelegate,LoginViewControllerDelegate>
@property (strong, nonatomic) BaseNavigationController *baseHomeNAV;
@property (strong, nonatomic) BaseNavigationController *baseProfileNAV;
@property (strong, nonatomic) BaseNavigationController *baseSettingNAV;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.baseTabBarController;
    self.baseTabBarController.delegate = self;
    [self _setUp3rdSDKs];
    [self.window makeKeyAndVisible];
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


- (BaseTabBarController*)baseTabBarController {
    if (!_baseTabBarController) {
        BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
        NSArray *arrayNAV = @[self.baseHomeNAV,self.baseProfileNAV,self.baseSettingNAV];
        [tabBar setViewControllers:arrayNAV animated:YES];
        _baseTabBarController = tabBar;
    }
    return _baseTabBarController;
}

#pragma mark - Private

//Setup Home
- (BaseNavigationController*)baseHomeNAV {
    if (!_baseHomeNAV) {
        HomeListViewController *homeVC = [[HomeListViewController alloc] init];
        BaseNavigationController *homeNAV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
        UITabBarItem *tabbarHome = [[UITabBarItem alloc]initWithTitle:m_string(@"Home")
                                                                image:[UIImage imageNamed:@"ic_home"]
                                                        selectedImage:[UIImage imageNamed:@"ic_home_heightlight"]];
        homeNAV.tabBarItem = tabbarHome;
        _baseHomeNAV = homeNAV;
    }
    return _baseHomeNAV;
}

//Setup Profile
- (BaseNavigationController*)baseProfileNAV {
    if (!_baseProfileNAV) {
        TabProfileController *profileVC = [[TabProfileController alloc] init];
        BaseNavigationController *profileNAV = [[BaseNavigationController alloc] initWithRootViewController:profileVC];
        UITabBarItem *tabbarProfile = [[UITabBarItem alloc]initWithTitle:m_string(@"Profile")
                                                                   image:[UIImage imageNamed:@"ic_contac_2"]
                                                           selectedImage:[UIImage imageNamed:@"ic_contac_2_heightlight"]];
        profileNAV.tabBarItem = tabbarProfile;
        _baseProfileNAV = profileNAV;
    }
    return _baseProfileNAV;
}

//Setup Setting
- (BaseNavigationController*)baseSettingNAV {
    if (!_baseSettingNAV) {
        SettingViewController *settingVC = [[SettingViewController alloc] init];
        BaseNavigationController *settingNAV = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
        UITabBarItem *tabbarSetting = [[UITabBarItem alloc]initWithTitle:m_string(@"Settings")
                                                                   image:[UIImage imageNamed:@"ic_setting_2_heighlight"]
                                                           selectedImage:[UIImage imageNamed:@"ic_setting_2"]];
        settingNAV.tabBarItem = tabbarSetting;
        _baseSettingNAV = settingNAV;
    }
    return _baseSettingNAV;
}


#pragma mark - Tabbar Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 1) {
        if ([[COLoginManager shared] userModel]) {
            [[COLoginManager shared] tokenObject:nil callWSGetListProfile:^(id object, NSError *error) {
            }];
        } else {
            [self _setUpLogginVC];
            [tabBarController setSelectedIndex:[[kUserDefaults objectForKey:KEY_TABBARSELECT] integerValue]];
        }

    }
}

- (void)_setUpLogginVC {
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    vcLogin.delegate = self;
    CATransition* transition = [CATransition animation];
    transition.duration = 1.5;
    transition.type = kCATransactionAnimationDuration;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [[kAppDelegate baseTabBarController].view.layer addAnimation:transition forKey:kCATransition];
    [[kAppDelegate baseTabBarController] presentViewController:base
                                                      animated:YES completion:nil];
}

- (void)loginViewController:(LoginViewController *)loginViewController loginWithStyle:(LoginWithStyle)loginWithStyle {
    switch (loginWithStyle) {
        case PushLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES
                                                                    completion:nil];
            [self.baseTabBarController setSelectedIndex:1];
        } break;
            
        case DismissLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES
                                                                    completion:nil];
        } break;
            
        default: break;
    }
}
@end
