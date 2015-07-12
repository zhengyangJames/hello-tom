//
//  LoginHelpers.m
//  CoAssets
//
//  Created by TUONG DANG on 7/5/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "LoginHelpers.h"
#import "LoginViewController.h"

@implementation LoginHelpers


+ (void)callLoginViewController {
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    CATransition* transition = [CATransition animation];
    transition.duration = 1.5;
    transition.type = kCATransactionAnimationDuration;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [[kAppDelegate baseTabBarController].view.layer addAnimation:transition forKey:kCATransition];
    [[kAppDelegate baseTabBarController] presentViewController:base
                                                      animated:YES
                                                    completion:nil];

}

@end
