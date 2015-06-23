//
//  RegisterViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "RegisterViewController.h"
#import "CODropListVC.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"
#import "LoadFileManager.h"
#import "COBorderTextField.h"
#import "NSString+Validation.h"
#import "WebViewSetting.h"

@interface RegisterViewController ()
{
    __weak IBOutlet CoDropListButtom *btnSalutation;
    __weak IBOutlet CoDropListButtom *btnMobileNumber;
    __weak IBOutlet COBorderTextField *_emailTextField;
    __weak IBOutlet COBorderTextField *_usernameTextField;
    __weak IBOutlet COBorderTextField *_passwordTextField;
    __weak IBOutlet COBorderTextField *_comfilmPasswordTextField;
    NSInteger _indexActtionSalutation;
    NSInteger _indexActtionPhoneCode;
}

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
}

#pragma mark - Private
- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:nil
                                  tag:0
                     arrayTitleButton:nil];
}

- (BOOL)_isValidtion {
    if (![_emailTextField.text isValidEmail]||[_usernameTextField.text isEmpty]||[_passwordTextField.text isValidPassword]||[_comfilmPasswordTextField.text isValidPassword]) {
        [self _setupShowAleartViewWithTitle:@"Profile is invalid"];
        return NO;
    }
    return YES;
}

#pragma mark - Action
- (IBAction)__actionCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)__actionMR:(id)sender {
    NSArray *arr = @[@"Mr",@"Ms"];
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Salutation" data:arr selectedIndex:_indexActtionSalutation didSelect:^(NSInteger index) {
        [btnSalutation setTitle:arr[index] forState:UIControlStateNormal];
        _indexActtionSalutation = index;
    }];
}

- (IBAction)__actionPhoneCode:(id)sender {
    NSArray *arr = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Phone Codes" data:arr selectedIndex:_indexActtionPhoneCode didSelect:^(NSInteger index) {
        [btnMobileNumber setTitle:[arr[index] objectForKey:@"code"] forState:UIControlStateNormal];
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
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate


@end
