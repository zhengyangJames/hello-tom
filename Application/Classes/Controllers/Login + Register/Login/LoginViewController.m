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
#import "NSString+MD5.h"
#import "WSURLSessionManager+Profile.h"
#import "COListProfileObject.h"
#import "NSUserDefaultHelper.h"
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
         return NO;
    }else if ([_passWord.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Password is required."];
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
            if (self.actionLogin) {
                self.actionLogin((COListProfileObject*)object);
            }
        } else {
            [UIHelper showAleartViewWithTitle:nil message:m_string(@"Invalid Grant") cancelButton:m_string(@"OK") delegate:nil tag:100 arrayTitleButton:nil];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - Action
- (IBAction)__actionLogin:(id)sender {
    if (![self _isValidation]) {
        return;
    } else {
        [self _login];
    }
}

- (IBAction)__actionRegister:(id)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [vc setActionRegister:^(){
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)__actionForgotPassword:(id)sender {
    ForgotPasswordViewController *vc = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

}

@end
