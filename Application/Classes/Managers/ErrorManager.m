//
//  ErrorManager.m
//  CoAssets
//
//  Created by TruongVO07 on 11/24/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "ErrorManager.h"
#import "LoginViewController.h"

@interface ErrorManager() <LoginViewControllerDelegate>

@end

@implementation ErrorManager

+ (ErrorManager *)shared {
    static ErrorManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)showError:(NSError *)error {
    if(!error) return;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSString *message = nil;
        if([error.userInfo objectForKey:@"message"])
        {
            message = [error.userInfo objectForKey:@"message"];
        } else {
            message = error.localizedDescription;
        }
        if ([message isEqualToString:ERROR_AUTH_NOT_PROVIDED]) {
            [kAppDelegate clearData];
            [ErrorManager shared].isExpiredAuth = YES;
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:m_string(@"CoAssets")
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:m_string(@"OK")
                                                      otherButtonTitles:nil];
            [alertView show];
            alertView = nil;
        }
    }];
}


- (UIViewController *)getCurrentViewController {
    UIViewController *viewController;
    if ([kAppDelegate baseProfileNAV].presentedViewController) {
        viewController = [kAppDelegate baseProfileNAV].presentedViewController;
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

- (void)showLogin {
    UIViewController *vc = [self getCurrentViewController];
    if (vc && [vc isKindOfClass:[LoginViewController class]]) {
        return;
    }
    [[kAppDelegate baseProfileNAV] dismissViewControllerAnimated:NO completion:nil];
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    vcLogin.delegate = self;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [[kAppDelegate baseTabBarController] presentViewController:base animated:YES completion:nil];
}

- (void)loginViewController:(LoginViewController *)loginViewController loginWithStyle:(LoginWithStyle)loginWithStyle {
    switch (loginWithStyle) {
        case PushLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
            self.isExpiredAuth = NO;
        } break;
            
        case DismissLoginVC:
        {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
            [kAppDelegate baseTabBarController].selectedIndex = 0;
        } break;
            
        default: break;
    }
}

@end
