//
//  LoginViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgotPasswordViewController.h"
#import "COBorderTextField.h"
#import "DetailsViewController.h"

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

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

#pragma mark - Private
- (void)_login {
    if (self.actionLogin) {
        self.actionLogin();
    }
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
