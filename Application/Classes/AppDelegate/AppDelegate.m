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
    [self gotoHome];
    [self _setUp3rdSDKs];
    [self _setUpDatabase];
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

- (void)_setUpDatabase {
    [NSPersistentStoreCoordinator MR_setDefaultStoreCoordinator:self.persistentStoreCoordinator];
    [NSManagedObjectContext MR_initializeDefaultContextWithCoordinator:self.persistentStoreCoordinator];
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

#pragma mark - CoreData Stack
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:COREDATA_STORE_NAME withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                              NSInferMappingModelAutomaticallyOption:@YES,
                              NSSQLitePragmasOption: @{@"journal_mode": @"WAL"}
                              };
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[kFileManager publicDirectory] URLByAppendingPathComponent:
                       [NSString stringWithFormat:@"%@.sqlite",COREDATA_STORE_NAME]];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        abort();
    }
    
    return _persistentStoreCoordinator;
}


@end
