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
#import "WSURLSessionManager+User.h"

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

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

#pragma mark - Private
- (void)_login {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:_userName.text,kUSER,_passWord.text,kPASSWORD, nil];
    [self _callAPILogin:param];
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


- (BOOL)_isValidation {
    if ([_userName.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Username is required."];
        _currentField = _userName;
         return NO;
    }else if ([_passWord.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Password is required."];
        _currentField = _passWord;
        return NO;
    }else if (![_passWord.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"Invalid password."];
        _currentField = _passWord;
        return NO;
    }
    return YES;
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callAPILogin:(NSDictionary*)param {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsLoginWithUser:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        DBG(@"%@",responseObject);
    }];
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

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        if (_currentField) {
//            [_currentField becomeFirstResponder];
//        }
//        _currentField = nil;
//    }
}

@end
