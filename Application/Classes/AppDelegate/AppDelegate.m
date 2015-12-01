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
#import "NotificationViewController.h"
#import "SettingViewController.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"
#import <Parse/Parse.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import "CONotificationBannerView.h"
#import "WSPostDeviceTokenRequest.h"
#import "WSURLSessionManager+Notification.h"
#import "CONotificationModel.h"
#import "WebViewSetting.h"

@interface AppDelegate ()<UITabBarControllerDelegate,LoginViewControllerDelegate,CONotificationBannerViewDelegate>
{
    BOOL _keyShowNotificationBanner;
    NSDictionary *_userInfo;
    NSUInteger sellectdate;
}

@property (strong, nonatomic) HomeListViewController *homeVC;
@property (strong, nonatomic) CONotificationBannerView *viewNotification;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *notificationInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.baseTabBarController;
    self.baseTabBarController.delegate = self;
    [self _setUp3rdSDKs];
    [self _setupParse];
    [self _setupNotifications:application];
    [self _checkVersionAndClearData];
    [self checkGetNotificationCountHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (response && error) {
            NSString *message = [error.userInfo objectForKey:@"message"];
            if (message && [message isEqualToString:MESSAGE_DEVICE_TOKEN_INVALID]) {
                [kUserDefaults setBool:NO forKey:DEVICE_TOKEN_EXIST];
                [kUserDefaults synchronize];
                [self checkAndCreadDeviceTokenHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
                    if (response && !error) {
                        [self callGetNotificationListHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
                            if (response && error) {
                                [ErrorManager showError:error];
                            }
                        }];
                    }
                }];
            } else {
                [ErrorManager showError:error];
                
            }
        }
    }];
    [self.window makeKeyAndVisible];
    [self performNotification:notificationInfo isCheckBannerNotfi:NO];
    return YES;
}

- (void)setupNotifications:(UIApplication*)application
{
    // Register for Push Notitications, if running iOS 8
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    _keyShowNotificationBanner = NO;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //    [[COLoginManager shared] setIsReloadListHome:NO];
    _keyShowNotificationBanner = YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
    
    
    NSString *deviceTokenStr = [NSString stringWithFormat:@"%@",deviceToken];
    NSString *stringWithoutSpaces = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *push_id = [stringWithoutSpaces stringByReplacingOccurrencesOfString:@"<" withString:@""];
    push_id = [push_id stringByReplacingOccurrencesOfString:@">" withString:@""];
    if (([push_id class] != [NSNull class]) && (push_id != NULL)) {
        [kUserDefaults setObject:push_id forKey:KEY_DEVICE_TOKEN];
        [kUserDefaults synchronize];
    }
    [self checkAndCreadDeviceTokenHandler:nil];
    application.applicationIconBadgeNumber = 0;
}

#pragma mark Remote Notification

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (_keyShowNotificationBanner) {
        if (userInfo) {
            _userInfo = userInfo;
            NSDictionary *dicMess = [userInfo objectForKey:@"aps"];
            self.viewNotification.textMessage = [dicMess objectForKey:@"alert"];
            self.viewNotification.delegate = self;
            BOOL check = [[[kAppDelegate window] subviews] containsObject:self.viewNotification];
            if (!check) {
                [self.viewNotification show];
            } else {
                [self.viewNotification delayPerform];
            }
        }
    } else {
        [self performNotification:userInfo isCheckBannerNotfi:NO];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    if (_keyShowNotificationBanner) {
        if (userInfo) {
            _userInfo = userInfo;
            NSDictionary *dicMess = [userInfo objectForKey:@"aps"];
            self.viewNotification.textMessage = [dicMess objectForKey:@"alert"];
            self.viewNotification.delegate = self;
            BOOL check = [[[kAppDelegate window] subviews] containsObject:self.viewNotification];
            if (!check) {
                [self.viewNotification show];
            } else {
                [self.viewNotification delayPerform];
            }
        }
    } else {
        [self performNotification:userInfo isCheckBannerNotfi:NO];
    }
}

- (void)notificationBannerViewDissmis:(CONotificationBannerView *)notificationView {
    [self performNotification:_userInfo isCheckBannerNotfi:YES];
    _userInfo = nil;
}

- (UIViewController *)_getCurrentViewController {
    UIViewController *viewController;
    if (self.baseTabBarController.presentedViewController) {
        viewController = self.baseTabBarController.presentedViewController;
        while ([viewController isKindOfClass:[UINavigationController class]] || [viewController isKindOfClass:[UITabBarController class]]) {
            if ([viewController isKindOfClass:[UINavigationController class]]) {
                viewController = ((UINavigationController *)viewController).topViewController;
            }
            if ([viewController isKindOfClass:[UITabBarController class]]) {
                viewController = ((UITabBarController *)viewController).viewControllers[((UITabBarController *)viewController).selectedIndex];
            }
        }
    }
    return viewController;
}

- (void)performNotification:(NSDictionary*)userInfo isCheckBannerNotfi:(BOOL)isCheck {
    if (userInfo && [userInfo objectForKey:@"data"]) {
        NSDictionary *data = [userInfo objectForKey:@"data"];
        NSString *urlString = [data objectForKeyNotNull:@"url"];
        NSString *type = [data objectForKeyNotNull:@"type"];
        if (urlString && ![urlString isEmpty]) {
//            if ([self.baseNotificationNAV.topViewController isKindOfClass:[WebViewSetting class]]) {
//                WebViewSetting *webViewSetting = (WebViewSetting *)self.baseNotificationNAV.topViewController;
//                webViewSetting.webLink = urlString;
//                [webViewSetting loadWebView];
//                [self.baseTabBarController setSelectedIndex:2];
//            } else
            if ([[self _getCurrentViewController] isKindOfClass:[WebViewSetting class]]) {
                WebViewSetting *webViewSetting = (WebViewSetting *)[self _getCurrentViewController];
                webViewSetting.webLink = urlString;
                [webViewSetting loadWebView];
            } else {
                WebViewSetting *webViewSetting = [[WebViewSetting alloc]init];
                webViewSetting.webLink = urlString;
                webViewSetting.titler = m_string(@"Notification");
                webViewSetting.isPresion = YES;
                BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:webViewSetting];
                [self.baseTabBarController presentViewController:nav animated:YES completion:nil];
            }
            
        } else if (type && [type isEqualToString:@"offer"]){
            NSNumber *offerId = [data objectForKeyNotNull:@"id"];
            [self.baseTabBarController setSelectedIndex:0];
            [self.baseTabBarController dismissViewControllerAnimated:YES completion:nil];
            NSArray *array = self.baseHomeNAV.viewControllers;
            if (array.count > 1) {
                [self.baseHomeNAV popToViewController:self.homeVC animated:NO];
            }
            [self.homeVC setNotificationOfferId:[offerId stringValue] isCheckNotificationBanner:isCheck];
        }
    }
}

- (CONotificationBannerView*)viewNotification {
    if (_viewNotification) {
        return _viewNotification;
    }
    return _viewNotification = [[CONotificationBannerView alloc] init];
}

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
        NSArray *arrayNAV = @[self.baseHomeNAV,self.baseProfileNAV,self.baseNotificationNAV,self.baseSettingNAV];
        [tabBar setViewControllers:arrayNAV animated:YES];
        _baseTabBarController = tabBar;
    }
    return _baseTabBarController;
}

- (void)checkGetNotificationCountHandler:(WSURLSessionHandler)handler {
    if ([kUserDefaults objectForKey:KEY_ACCESS_TOKEN]) {
        [self callGetNotificationListHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
            if (handler) {
                handler(responseObject, response, error);
            }
        }];
    } else {
        if (handler) {
            handler(nil, nil, nil);
        }
    }
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

//Setup Notification
- (BaseNavigationController*)baseNotificationNAV {
    if (!_baseNotificationNAV) {
        NotificationViewController *notificationVC = [[NotificationViewController alloc]init];
        BaseNavigationController *notificationNAV = [[BaseNavigationController alloc]initWithRootViewController:notificationVC];
        UITabBarItem *tabbarNotification = [[UITabBarItem alloc]initWithTitle:m_string(@"NOTIFICATION" ) image:[UIImage imageNamed:@"ic_notification"] selectedImage:[UIImage imageNamed:@"ic_notification_selected"]];
        notificationNAV.tabBarItem = tabbarNotification;
        _baseNotificationNAV = notificationNAV;
    }
    return _baseNotificationNAV;
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
    NSString *bundleVS = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    if (!version || [version isEmpty]) {
        [kUserDefaults setObject:bundleVS forKey:KEY_VERSION];
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
    //    NSString *bundleVS = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //    if ([bundleVS integerValue] < 1.2) {
    //        [self clearData];
    //    }
}

#pragma mark - ClearData

- (void)clearData {
    [[COLoginManager shared] setUserModel:nil];
    [[COLoginManager shared] setCompanyModel:nil];
    [[COLoginManager shared] setInvestorModel:nil];
    [[COLoginManager shared] setAccountModel:nil];
    [kUserDefaults removeObjectForKey:kPROFILE_JSON];
    [kUserDefaults removeObjectForKey:UPDATE_INVESTOR_PROFILE_JSON];
    [kUserDefaults removeObjectForKey:UPDATE_ACCOUNT_PROFILE_JSON];
    [kUserDefaults removeObjectForKey:UPDATE_COMPANY_PROFILE_JSON];
    [kUserDefaults removeObjectForKey:KEY_ACCESS_TOKEN];
    [kUserDefaults synchronize];
    [[self.baseTabBarController.tabBar.items objectAtIndex:2] setBadgeValue: nil];
}

#pragma mark - Tabbar Delegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == 1) {
        if (![[COLoginManager shared] userModel]) {
            sellectdate = 1;
            [self showLogginVC];
            [tabBarController setSelectedIndex:[[kUserDefaults objectForKey:KEY_TABBARSELECT] integerValue]];
        } else {
            [[COLoginManager shared] setInvestorModel:nil];
            [[COLoginManager shared] wsGetAccountInverstment:^(id object, NSError *error) {
                if (error) {
                    [ErrorManager showError:error];
                }
            }];
        }
    }
    if (tabBarController.selectedIndex == 2) {
        if (![[COLoginManager shared] userModel]) {
            sellectdate = 2;
            [self showLogginVC];
            [tabBarController setSelectedIndex:[[kUserDefaults objectForKey:KEY_TABBARSELECT] integerValue]];
        } else {
            [[COLoginManager shared] setInvestorModel:nil];
            [[COLoginManager shared] wsGetAccountInverstment:^(id object, NSError *error) {
                if (error) {
                    [ErrorManager showError:error];
                }
            }];
        }
    }
}

- (void)showLogginVC {
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
            [self.baseTabBarController setSelectedIndex:sellectdate];
        } break;
            
        case DismissLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES
                                                                    completion:nil];
        } break;
            
        default: break;
    }
}

#pragma mark - Web Service By Vincent
#pragma mark - POST Notification

- (void)checkAndCreadDeviceTokenHandler:(WSURLSessionHandler)handler {
    BOOL isExitDeviceToken = [kUserDefaults boolForKey:DEVICE_TOKEN_EXIST];
    NSString *deviceToken = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    if (!isExitDeviceToken && deviceToken) {
        [self _callPostDeviceTokenHandler:^(id responseObject, NSURLResponse *response, NSError *error) {
            if (handler) {
                handler(responseObject, response, error);
            }
        }];
    } else {
        if (handler) {
            handler(nil, nil, nil);
        }
    }
}

- (void)_callPostDeviceTokenHandler:(WSURLSessionHandler)handler {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [dic setObject:client_key forKey:client_key_dic];
    
    [[WSURLSessionManager shared]wsPostDeviceTokenRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (error) {
            NSString *message = [error.userInfo objectForKeyNotNull:@"message"];
            if (message && [message isEqualToString:MESSAGE_DEVICE_TOKEN_EXITS]) {
                [kUserDefaults setBool:YES forKey:DEVICE_TOKEN_EXIST];
                [kUserDefaults synchronize];
            }
            [ErrorManager showError:error];
            if (handler) {
                handler(nil, response, error);
            }
        } else {
            if (handler) {
                handler(responseObject, response, nil);
            }
        }
    }];
}

- (void)callGetNotificationListHandler:(WSURLSessionHandler)handler {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    if (device_token) {
         [dic setObject:device_token forKey:device_token_dic];
    }
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [[WSURLSessionManager shared] wsGetNotificationListRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            if ([[UIHelper setBadgeValueNotification:responseObject] isEqualToString:@"0"]) {
                [[self.baseTabBarController.tabBar.items objectAtIndex:2] setBadgeValue:nil];
            } else {
                [[self.baseTabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[UIHelper setBadgeValueNotification:responseObject]];
            }
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

@end
