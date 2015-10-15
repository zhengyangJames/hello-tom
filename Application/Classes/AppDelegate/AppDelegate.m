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
#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>

@interface AppDelegate ()<UITabBarControllerDelegate,LoginViewControllerDelegate>
@property (strong, nonatomic) BaseNavigationController *baseHomeNAV;
@property (strong, nonatomic) BaseNavigationController *baseProfileNAV;
@property (strong, nonatomic) BaseNavigationController *baseSettingNAV;

@property (strong, nonatomic) HomeListViewController *homeVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.baseTabBarController;
    self.baseTabBarController.delegate = self;
    [self _setUp3rdSDKs];
    [self _setupParse];
    [self _setupNotifications:application];
    [self _checkVersionAndClearData];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[COLoginManager shared] setIsReloadListHome:NO];
}

- (void)applicationWillTerminate:(UIApplication *)application {}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if ([userInfo objectForKey:@"data"]) {
        NSDictionary *data = [userInfo objectForKey:@"data"];
        NSNumber *offerId = data[@"id"];
        [self.baseTabBarController setSelectedIndex:0];
        NSArray *array = self.baseHomeNAV.viewControllers;
        if (array.count > 1) {
            [self.baseHomeNAV popToViewController:self.homeVC animated:NO];
        }
        [[COLoginManager shared] setIsReloadListHome:YES];
        [self.homeVC checkIsShowLoginVCAndPushDetailOffer:nil offerId:[offerId stringValue]];
    }}

#pragma mark - Method

- (void)_setUp3rdSDKs {
    [Fabric with:@[CrashlyticsKit]];
}

- (void)_setupParse {
    [ParseCrashReporting enable];
    [Parse setApplicationId:kParseSDKAppID clientKey:kParseSDKClientID];
}

- (void)_setupNotifications:(UIApplication*)application {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
#endif
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                     UIRemoteNotificationTypeAlert |
                                                     UIRemoteNotificationTypeSound)];
}

#pragma mark - Private

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
        BaseNavigationController *homeNAV = [[BaseNavigationController alloc] initWithRootViewController:self.homeVC];
        UITabBarItem *tabbarHome = [[UITabBarItem alloc]initWithTitle:m_string(@"Home")
                                                                image:[UIImage imageNamed:@"ic_home"]
                                                        selectedImage:[UIImage imageNamed:@"ic_home_heightlight"]];
        homeNAV.tabBarItem = tabbarHome;
        _baseHomeNAV = homeNAV;
    }
    return _baseHomeNAV;
}

- (HomeListViewController*)homeVC {
    if (_homeVC) {
        return _homeVC;
    }
    return _homeVC = [[HomeListViewController alloc] init];
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

#pragma mark - CheckVertion

- (void)_checkVersionAndClearData {
    NSString *version = [kUserDefaults objectForKey:KEY_VERSION];
    NSString *buildVersion = [kUserDefaults objectForKey:KEY_BUILD_VERSION];
    NSString *getBuildVersionApp = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (!version || [version isEmpty]) {
        NSString *bundleVS = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        [kUserDefaults setObject:bundleVS forKey:KEY_VERSION];
        [kUserDefaults synchronize];
        [self clearData];
    } else {
        if (!buildVersion || [buildVersion isEmpty]) {
            [kUserDefaults setObject:getBuildVersionApp forKey:KEY_BUILD_VERSION];
            [kUserDefaults synchronize];
            [self clearData];
        } else {
            if (![buildVersion isEqualToString:getBuildVersionApp]) {
                [kUserDefaults setObject:getBuildVersionApp forKey:KEY_BUILD_VERSION];
                [kUserDefaults synchronize];
                [self clearData];
            }
        }
    }
}

#pragma mark - ClearData

- (void)clearData {
    [[COLoginManager shared] setUserModel:nil];
    [[COLoginManager shared] setCompanyModel:nil];
    [[COLoginManager shared] setInvestorModel:nil];
    [[COLoginManager shared] setAccountModel:nil];
    [kUserDefaults removeObjectForKey:kPROFILE_JSON];
//    [kUserDefaults removeObjectForKey:UPDATE_COMPANY_PROFILE_JSON];
    [kUserDefaults removeObjectForKey:UPDATE_INVESTOR_PROFILE_JSON];
    [kUserDefaults removeObjectForKey:UPDATE_ACCOUNT_PROFILE_JSON];
    [kUserDefaults synchronize];
}

#pragma mark - Tabbar Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 1) {
        if (![[COLoginManager shared] userModel]) {
            [self _setUpLogginVC];
            [tabBarController setSelectedIndex:[[kUserDefaults objectForKey:KEY_TABBARSELECT] integerValue]];
        } else {
            [[COLoginManager shared] setInvestorModel:nil];
            [[COLoginManager shared] wsGetAccountInverstment:^(id object, NSError *error) { }];
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
