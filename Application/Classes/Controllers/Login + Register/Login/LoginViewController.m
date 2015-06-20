//
//  LoginViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeListViewController.h"
#import "ProfileViewController.h"
#import "SettingViewController.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - Setup
- (void)_setupUI {
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

#pragma mark - Privace
- (void)_login {
    //Setup Home
    HomeListViewController *homeVC = [[HomeListViewController alloc] init];
    BaseNavigationController *homeNAV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    UITabBarItem *tabbarHome = [[UITabBarItem alloc]initWithTitle:m_string(@"Home")
                                                            image:[UIImage imageNamed:@"ic_home"]
                                                    selectedImage:[UIImage imageNamed:@"ic_home_heightline"]];
    homeNAV.tabBarItem = tabbarHome;
    
    //Setup Profile
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    BaseNavigationController *profileNAV = [[BaseNavigationController alloc] initWithRootViewController:profileVC];
    UITabBarItem *tabbarProfile = [[UITabBarItem alloc]initWithTitle:m_string(@"Profile")
                                                               image:[UIImage imageNamed:@"ic_peopel"]
                                                       selectedImage:[UIImage imageNamed:@"ic_people_heightline"]];
    profileNAV.tabBarItem = tabbarProfile;
    
    //Setup Setting
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    BaseNavigationController *settingNAV = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
    UITabBarItem *tabbarSetting = [[UITabBarItem alloc]initWithTitle:m_string(@"Setting")
                                                               image:[UIImage imageNamed:@"ic_setting"]
                                                       selectedImage:[UIImage imageNamed:@"ic_setting_heightline"]];
    settingNAV.tabBarItem = tabbarSetting;
    
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    NSArray *arrayNAV = @[homeNAV, profileNAV, settingNAV];
    tabBar.viewControllers = arrayNAV;
    [self.navigationController pushViewController:tabBar animated:YES];
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callAPILogin {
    
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    [self _login];
}

- (IBAction)__actionRegister:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)__actionForgotPassword:(id)sender {
    ForgotPasswordViewController *vc = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Delegate

@end
