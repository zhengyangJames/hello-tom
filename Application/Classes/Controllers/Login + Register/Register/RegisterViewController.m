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
#import "NSString+MD5.h"

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

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

- (BOOL)_isValidtion {
    if ([_fristNameTextField.text isEmpty]) {
        _currentField = _fristNameTextField;
        [self _setupShowAleartViewWithTitle:@"Frist Name is required."];
        return NO;
    } else if ([_lastNameTextField.text isEmpty]) {
        _currentField = _lastNameTextField;
        [self _setupShowAleartViewWithTitle:@"Last Name is required."];
        return NO;
    } else if ([_emailTextField.text isEmpty]) {
        _currentField = _emailTextField;
        [self _setupShowAleartViewWithTitle:@"Email  is required."];
        return NO;
    } else if (![_emailTextField.text isValidEmail]) {
        [self _setupShowAleartViewWithTitle:@"Email is invalid."];
        _currentField = _emailTextField;
        return NO;
    } else if ([_usernameTextField.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"User Name is required."];
        _currentField = _usernameTextField;
        return NO;
    } else if ([_passwordTextField.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Password is required."];
        _currentField = _passwordTextField;
        return NO;
    } else if (![_passwordTextField.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"Password is invalid."];
        _currentField = _passwordTextField;
        return NO;
    } else if ([_comfilmPasswordTextField.text isEmpty] ) {
        [self _setupShowAleartViewWithTitle:@"Password is required."];
        _currentField = _comfilmPasswordTextField;
        return NO;
    } else if (![_comfilmPasswordTextField.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"Password is invalid."];
        _currentField = _comfilmPasswordTextField;
        return NO;
    } else if (!_isCheckBox) {
        [self _setupShowAleartViewWithTitle:@"Please is Check Box"];
        return NO;
    }
    return YES;
}

- (NSDictionary*)_getUserInfo {
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

- (void)_pushViewController {
    [kUserDefaults setBool:YES forKey:KDEFAULT_LOGIN];
    [kUserDefaults synchronize];
    [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:NO completion:^{
        NSArray *array = [[kAppDelegate baseTabBarController] viewControllers];
        for (UIViewController *vc in array) {
            if ([vc isKindOfClass:[HomeListViewController class]]) {
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
    }];
}

- (NSMutableDictionary*)_creatUserInfo {
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[kCLIENT_ID] = CLIENT_ID;
    param[kCLIENT_SECRECT] = CLIENT_SECRECT;
    param[kGRANT_TYPE] = GRANT_TYPE;
    param[kUSER] = _usernameTextField.text;
    param[kPASSWORD] = _passwordTextField.text;
    return param;
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
    [[WSURLSessionManager shared] wsRegisterWithInfo:[self _getUserInfo] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if([[responseObject valueForKey:@"success"] isEqualToString:@"user created"]) {
                [self _callAPILogin:[self _creatUserInfo]];
                DBG( @"%@",responseObject);
            }else {
                [self _setupShowAleartViewWithTitle:@"Username Already Exist"];
            }
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_callAPILogin:(NSDictionary*)param {
    [[WSURLSessionManager shared] wsLoginWithUser:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            DBG(@"%@",responseObject);
            [kUserDefaults setValue:[responseObject valueForKey:kACCESS_TOKEN] forKey:kACCESS_TOKEN];
            [kUserDefaults setValue:[responseObject valueForKey:kTOKEN_TYPE] forKey:kTOKEN_TYPE];
            [kUserDefaults synchronize];
            [self _pushViewController];
        } else {
            [UIHelper showError:error];
        }
    }];
}

#pragma mark - Action
- (IBAction)__actionCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)__actionMR:(id)sender {
    NSArray *arr = @[@"Mr",@"Ms",@"Mdm",@"Dr"];
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Salutation" data:arr selectedIndex:_indexActtionSalutation didSelect:^(NSInteger index) {
        [btnSalutation setTitle:arr[index] forState:UIControlStateNormal];
        _indexActtionSalutation = index;
    }];
}

- (IBAction)__actionPhoneCode:(id)sender {
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Phone Codes" data:self.arrayListPhoneCode selectedIndex:_indexActtionPhoneCode didSelect:^(NSInteger index) {
        [btnMobileNumber setTitle:[self.arrayListPhoneCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionPhoneCode = index;
    }];
}

- (IBAction)__actionOpenSafari:(id)sender {
    WebViewSetting *vc = [[WebViewSetting alloc]init];
    vc.titler = m_string(@"Terms Of Use");
    vc.webLink = @"http://coassets.com/terms-of-use/";
    vc.isPresion = YES;
    BaseNavigationController *nav = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)__actionRegister:(id)sender {
    if (![self _isValidtion]) {
        return;
    }else{
        [self _callWSRegister];
    }
}

#pragma mark - UIAlertView delegate


- (void)checkBoxButton:(COCheckBoxButton *)checkBox didChangeCheckingStatus:(BOOL)isChecking {
    _isCheckBox = isChecking;
}


@end
