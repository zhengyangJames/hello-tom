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
#import "COBorderTextField.h"

@interface LoginViewController ()
{
    __weak IBOutlet COBorderTextField *_userName;
    __weak IBOutlet COBorderTextField *_passWord;
}

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

#pragma mark - Private
- (void)_login {
    BaseTabBarController *tabBar = [[BaseTabBarController alloc] init];
    NSArray *arrayNAV = @[[self _setupHomeListViewController],[self _setupProfileViewController],[self _setupSettingViewController]];
    tabBar.viewControllers = arrayNAV;
    [self.navigationController pushViewController:tabBar animated:YES];
}

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

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:nil
                                  tag:0
                     arrayTitleButton:nil];
}

- (BOOL)_isValidation {
    if ([_userName.text isEmpty] && ![_passWord.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"Username and Password is invalid"];
        return NO;
    } else {
        if (![_passWord.text isValidPassword]|| [_userName.text isEmpty]) {
            [self _setupShowAleartViewWithTitle:@"Username Or Password is invalid"];
            return NO;
        }
    }
    return YES;
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callAPILogin {
    
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    if (![self _isValidation]) {
        return;
    }
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
