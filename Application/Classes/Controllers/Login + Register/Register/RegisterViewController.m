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

@interface RegisterViewController ()
{
    __weak IBOutlet CoDropListButtom *btnSalutation;
    __weak IBOutlet CoDropListButtom *btnMobileNumber;
    __weak IBOutlet COBorderTextField *_emailTextField;
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
    NSURL *url = [NSURL URLWithString:@"http://coassets.com/terms-of-use/"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)__actionRegister:(id)sender {
    NSString *string = _emailTextField.text;
    if (![string isValidEmail]) {
        [UIHelper showAleartViewWithTitle:m_string(@"CoAssets") message:m_string(@"Email invalid") cancelButton:m_string(@"OK") delegate:nil tag:0 arrayTitleButton:nil];
        return;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TextField Delegate


@end
