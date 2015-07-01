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

@interface LoginViewController ()<UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *_userName;
    __weak IBOutlet COBorderTextField *_passWord;
    __weak COBorderTextField *_currentField;
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
    [self _callAPILogin:[self _creatUserInfo]];
    [kUserDefaults setBool:YES forKey:KDEFAULT_LOGIN];
    [kUserDefaults synchronize];
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
        if ([responseObject isKindOfClass:[NSDictionary class]]&& [responseObject valueForKey:kACCESS_TOKEN]) {
            [kUserDefaults setValue:[responseObject valueForKey:kACCESS_TOKEN] forKey:kACCESS_TOKEN];
            [kUserDefaults setValue:[responseObject valueForKey:kTOKEN_TYPE] forKey:kTOKEN_TYPE];
            [kUserDefaults synchronize];
            [self _callWSGetListProfile];
        } else {
            [UIHelper showAleartViewWithTitle:nil message:m_string(@"Invalid Grant") cancelButton:m_string(@"OK") delegate:nil tag:100 arrayTitleButton:nil];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_callWSGetListProfile {
    [UIHelper showLoadingInView:self.view];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = [kUserDefaults valueForKey:kACCESS_TOKEN];
    dic[kTOKEN_TYPE] = [kUserDefaults valueForKey:kTOKEN_TYPE];
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [self _zipDataProfile:responseObject];
            if (self.actionLogin) {
                [kNotificationCenter postNotificationName:kUPDATE_PROFILE object:nil];
                self.actionLogin(responseObject);
            }
        }else {
            [UIHelper showError:error];
        }
    }];
}

- (void)_zipDataProfile:(COListProfileObject*)object {
    [UIHelper showLoadingInView:self.view];
    [NSUserDefaultHelper saveUserDefaultWithProfileObject:object key:kPROFILE_OBJECT];
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
