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

@interface LoginViewController ()<UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *_userName;
    __weak IBOutlet COBorderTextField *_passWord;
    
    __weak COBorderTextField *_currentField;
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
    [kUserDefaults setBool:YES forKey:KDEFAULT_LOGIN];
    [kUserDefaults synchronize];
}

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

/*
- (BOOL)_isValidation {
    if ([_userName.text isEmpty] && ![_passWord.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"invalid password or username"];
        return NO;
    } else {
        if (![_passWord.text isValidPassword]|| [_userName.text isEmpty]) {
            [self _setupShowAleartViewWithTitle:@"invalid password or username"];
            return NO;
        }
    }
    return YES;
}
 */

- (BOOL)_isValidation {
    if ([_userName.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Username is empty"];
        _currentField = _userName;
         return NO;
    } else if (![_passWord.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"invalid password"];
        _currentField = _passWord;
         return NO;
    }
    
    
    /*
    if ([_userName.text isEmpty] && ![_passWord.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"invalid password or username"];
        return NO;
    } else {
        if (![_passWord.text isValidPassword]|| [_userName.text isEmpty]) {
            [self _setupShowAleartViewWithTitle:@"invalid password or username"];
            return NO;
        }
    }
     */
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (_currentField) {
            [_currentField becomeFirstResponder];
        }
    }
}

@end
