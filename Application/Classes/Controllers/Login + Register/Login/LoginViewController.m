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
    
}

#pragma mark - Privace
- (void)_login {
    
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callAPILogin {
    
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    HomeListViewController *homeVC = [[HomeListViewController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    
    BaseNavigationController *homeNAV = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    BaseNavigationController *profileNAV = [[BaseNavigationController alloc] initWithRootViewController:profileVC];
    BaseNavigationController *settingNAV = [[BaseNavigationController alloc] initWithRootViewController:settingVC];
    
    homeNAV.tabBarItem.title = m_string(@"Home");
    profileNAV.tabBarItem.title = m_string(@"Profile");
    settingNAV.tabBarItem.title =  m_string(@"Setting");
    
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    NSArray *arrayNAV = @[homeNAV, profileNAV, settingNAV];
    tabBar.viewControllers = arrayNAV;
    [self.navigationController pushViewController:tabBar animated:YES];
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
