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
#import "OfferViewController.h"
#import "WSURLSessionManager+User.h"
#import "NSString+MD5.h"
#import "WSURLSessionManager+Profile.h"
#import "COLoginManager.h"
#import "WSLoginRequest.h"

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
    //test
//    _userName.text = @"mrkyawkyawlinn";
//    _passWord.text = @"kklinn";
    
    //
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

#pragma mark - Private
- (void)_login {
    [self _callWSLogin];
    
}

- (WSLoginRequest*)_setLoginRequest {
    WSLoginRequest *request = [[WSLoginRequest alloc] init];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_POST_LOGIN]];
    [request setBodyParam:_userName.text forKey:kUserName];
    [request setBodyParam:_passWord.text forKey:kPassWord];

    return request;
}

- (BOOL)_isValid {
    if ([_userName.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:m_string(@"USERNAME_REQUIRED") delegate:self tag:0];
         return NO;
    }else if ([_passWord.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:m_string(@"PASSWORD_REQUIRED") delegate:self tag:0];

        return NO;
    }
    return YES;
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callWSLogin {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[COLoginManager shared] callAPILoginWithRequest:[self _setLoginRequest] actionLoginManager:^(id object, NSError *error) {
        if (object && !error ) {
            if ([self.delegate respondsToSelector:@selector(loginViewController:loginWithStyle:)]) {
                [self.delegate loginViewController:self loginWithStyle:PushLoginVC];
            }
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
    }];
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
    if ([self _isValid]) {
        [kUserDefaults setObject:_userName.text forKey:KEY_USERNAME];
        [kUserDefaults synchronize];
        [self _login];
    }
}

- (IBAction)__actionRegister:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)__actionForgotPassword:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    ForgotPasswordViewController *vc = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)__actionCancel:(id)sender {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if ([self.delegate respondsToSelector:@selector(loginViewController:loginWithStyle:)]) {
        [self.delegate loginViewController:self loginWithStyle:DismissLoginVC];
    }
}

@end
