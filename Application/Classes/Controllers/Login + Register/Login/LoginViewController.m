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
#import "COListProfileObject.h"
#import "COLoginManager.h"

@interface LoginViewController ()<UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *_userName;
    __weak IBOutlet COBorderTextField *_passWord;
}
@property (strong, nonatomic) COListProfileObject *profileObject;

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
    [self _callWSLogin];
}

- (NSMutableDictionary*)_creatUserInfo {
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[kCLIENT_ID] = CLIENT_ID;
    param[kCLIENT_SECRECT] = CLIENT_SECRECT;
    param[kGRANT_TYPE] = GRANT_TYPE;
    param[kUSER] = _userName.text;
    param[kPASSWORD] = _passWord.text;
    return param;
}

- (BOOL)_isValid {
    if ([_userName.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"USERNAME_REQUIRED", nil) delegate:self tag:0];
         return NO;
    }else if ([_passWord.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_REQUIRED", nil) delegate:self tag:0];

        return NO;
    }
    return YES;
}

#pragma mark - Setter, Getter


#pragma mark - CallAPI
- (void)_callWSLogin {
    [UIHelper showLoadingInView:self.view];
    [[COLoginManager shared] callAPILogin:[self _creatUserInfo] actionLoginManager:^(id object, BOOL sucess) {
        if (object && sucess) {
            if ([self.delegate respondsToSelector:@selector(loginViewController:loginWithStyle:)]) {
                [self.delegate loginViewController:self loginWithStyle:PushLoginVC];
            }
        } else {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"INVAlID_USERNAME_OR_PASSWORD", nil) delegate:self tag:100];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    [_userName resignFirstResponder];
    [_passWord resignFirstResponder];
    if ([self _isValid]) {
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

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}

@end
