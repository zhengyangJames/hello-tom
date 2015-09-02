//
//  RegisterViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "RegisterViewController.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"
#import "COCheckBoxButton.h"
#import "LoadFileManager.h"
#import "COBorderTextField.h"
#import "NSString+Validation.h"
#import "WebViewSetting.h"
#import "WSURLSessionManager+User.h"
#import "HomeListViewController.h"
#import "COLoginManager.h"
#import "WSLoginRequest.h"
#import "WSRegisterRequest.h"

@interface RegisterViewController () <UIAlertViewDelegate,COCheckBoxButtonDelegate>
{
    __weak IBOutlet CoDropListButtom *btnSalutation;
    __weak IBOutlet CoDropListButtom *btnMobileNumber;
    __weak IBOutlet COCheckBoxButton *btnCheckBox;
    __weak IBOutlet COBorderTextField *_fristNameTextField;
    __weak IBOutlet COBorderTextField *_lastNameTextField;
    __weak IBOutlet COBorderTextField *_emailTextField;
    __weak IBOutlet COBorderTextField *_usernameTextField;
    __weak IBOutlet COBorderTextField *_passwordTextField;
    __weak IBOutlet COBorderTextField *_comfilmPasswordTextField;
    __weak IBOutlet COBorderTextField *_cellPhoneTextField;
    __weak COBorderTextField *_currentField;
    NSInteger _indexActtionSalutation;
    NSInteger _indexActtionPhoneCode;
    BOOL _isCheckBox;
}
@property (strong, nonatomic) NSArray *arrayListPhoneCode;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - Private
- (void)_setupUI {
    _indexActtionPhoneCode = 0;
    _indexActtionSalutation = 0;
    btnCheckBox.delegate = self;
}

- (BOOL)_isValidtion {
    if ([_fristNameTextField.text isEmpty]) {
        _currentField = _fristNameTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"FIRSTNAME_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if ([_lastNameTextField.text isEmpty]) {
        _currentField = _lastNameTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"LASTNAME_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if ([_emailTextField.text isEmpty]) {
        _currentField = _emailTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if (![_emailTextField.text isValidEmail]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_INVALID", nil) delegate:self tag:0];
        _currentField = _emailTextField;
        return NO;
    } else if ([_usernameTextField.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"USERNAME_REQUIRED", nil) delegate:self tag:0];
        _currentField = _usernameTextField;
        return NO;
    } else if ([_passwordTextField.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_REQUIRED", nil) delegate:self tag:0];
        _currentField = _passwordTextField;
        return NO;
    } else if ([_comfilmPasswordTextField.text isEmpty] ) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_REQUIRED", nil) delegate:self tag:0];
        _currentField = _comfilmPasswordTextField;
        return NO;
    } else if (![_comfilmPasswordTextField.text isEqualToString:_passwordTextField.text]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"CONFIRM_PASSWORD_MESSAGE", nil) delegate:self tag:0];
        _currentField = _comfilmPasswordTextField;
        return NO;
    }
    return YES;
}
- (WSRegisterRequest *)_setRegisterRequest {
    WSRegisterRequest *request = [[WSRegisterRequest alloc] initRegisterRequestWithBody:[self _setBodyInfo]];
    return request;
}

- (NSDictionary*)_setBodyInfo {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kUSER] = _usernameTextField.text;
    dic[kPASSWORD] = _passwordTextField.text;
    dic[KFRIST_NAME] = _fristNameTextField.text;
    dic[KLAST_NAME] = _lastNameTextField.text;
    dic[KEMAIL] = _emailTextField.text;
    dic[kNUM_COUNTRY] = [self.arrayListPhoneCode[_indexActtionPhoneCode] objectForKey:@"code"];
    dic[kNUM_CELL_PHONE] = _cellPhoneTextField.text;
    return dic;
}

- (WSLoginRequest*)_setLoginRequest {
    
    WSLoginRequest *request = [[WSLoginRequest alloc] initLoginRequestWithUserName:_usernameTextField.text passWord:_passwordTextField.text];
    return request;
}


#pragma mark - Set Get
- (NSArray*)arrayListPhoneCode {
    if (!_arrayListPhoneCode) {
        return _arrayListPhoneCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayListPhoneCode;
}

#pragma mark - Web Service
- (void)_callWSRegister {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsRegisterWithRequest:[self _setRegisterRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if([[responseObject valueForKey:@"success"] isEqualToString:@"user created"]) {
                [[COLoginManager shared] setUserModel:nil];
                [self _callWSLogin];
            }else {
                [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"USERNAME_ALREADY_EXISTS", nil) delegate:self tag:0];
                [UIHelper hideLoadingFromView:self.view];
            }
        } else {
            [UIHelper showError:error];
            [UIHelper hideLoadingFromView:self.view];
        }
    }];
}

- (void)_callWSLogin {
    [[COLoginManager shared] callAPILoginWithRequest:[self _setLoginRequest] actionLoginManager:^(id object, BOOL sucess) {
        if (object && sucess) {
            [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:YES completion:nil];
        } else {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"INVALID_GRANT", nil) delegate:self tag:100];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - Action
- (IBAction)__actionCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)__actionMR:(id)sender {
    NSArray *arr = @[@"Mr",@"Ms",@"Mdm",@"Dr"];
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:NSLocalizedString(@"SALUTATION_TITLE", nil) data:arr selectedIndex:_indexActtionSalutation didSelect:^(NSInteger index) {
        [btnSalutation setTitle:arr[index] forState:UIControlStateNormal];
        _indexActtionSalutation = index;
    }];
}

- (IBAction)__actionPhoneCode:(id)sender {
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:NSLocalizedString(@"PHONE_CODE_TITLE", nil) data:self.arrayListPhoneCode selectedIndex:_indexActtionPhoneCode didSelect:^(NSInteger index) {
        [btnMobileNumber setTitle:[self.arrayListPhoneCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionPhoneCode = index;
    }];
}

- (IBAction)__actionOpenSafari:(id)sender {
    WebViewSetting *vc = [[WebViewSetting alloc]init];
    vc.titler = NSLocalizedString(@"TERM_OF_USE", nil);
    vc.webLink = WEB_SAFARI_LINK;
    vc.isPresion = YES;
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)__actionRegister:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if (![self _isValidtion]) {
        return;
    }else{
        [self _callWSRegister];
    }
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [_currentField becomeFirstResponder];
    _currentField = nil;
}

- (void)checkBoxButton:(COCheckBoxButton *)checkBox didChangeCheckingStatus:(BOOL)isChecking {
    _isCheckBox = isChecking;
}


@end
