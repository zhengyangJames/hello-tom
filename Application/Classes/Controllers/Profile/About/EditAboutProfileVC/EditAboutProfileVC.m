//
//  EditAboutProfileVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditAboutProfileVC.h"
#import "CODropListView.h"
#import "COBorderTextField.h"
#import "CoDropListButtom.h"
#import "LoadFileManager.h"

@interface EditAboutProfileVC () <UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *emailNameTXT;
    __weak IBOutlet COBorderTextField *phoneNameTXT;
    __weak IBOutlet COBorderTextField *addressNameTXT;
    __weak IBOutlet CoDropListButtom  *dropListCountryCode;
    __weak COBorderTextField *_currentField;
    NSInteger _indexActtionCountryCode;
}

@property (strong,nonatomic) NSArray *arrayCountryCode;

@end

@implementation EditAboutProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.addressName = self.addressName;
    self.emailName = self.emailName;
    self.phoneCode = self.phoneCode;
    self.phoneName = self.phoneName;
    _indexActtionCountryCode = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Set Get
- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    addressNameTXT.text = _addressName;
}

- (void)setPhoneName:(NSString *)phoneName {
    _phoneName = phoneName;
    phoneNameTXT.text = _phoneName;
}

- (void)setEmailName:(NSString *)emailName {
    _emailName = emailName;
    emailNameTXT.text = _emailName;
}

- (void)setPhoneCode:(NSInteger)phoneCode {
    _phoneCode = phoneCode;
    NSString *phone = [self.arrayCountryCode[_phoneCode] objectForKey:@"code"];
    [dropListCountryCode setTitle:phone forState:UIControlStateNormal];
}

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

#pragma mark - Private 

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"Basic Info");
    [self _setupBarButtonCancel];
    [self _setupBarButtonDone];
    NSString *phoneCode = [self.arrayCountryCode[_indexActtionCountryCode] objectForKey:@"code"];
    [dropListCountryCode setTitle:phoneCode forState:UIControlStateNormal];
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Cancel")
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btCancel;
}

#pragma mark - Private
- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

- (BOOL)_isValidation {
    if ([emailNameTXT.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Email  is required."];
        _currentField = emailNameTXT;
        return NO;
    } else if (![emailNameTXT.text isValidEmail]) {
        [self _setupShowAleartViewWithTitle:@"Email is invalid."];
        _currentField = emailNameTXT;
        return NO;
    } else if ([phoneNameTXT.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Phone is required."];
        _currentField = phoneNameTXT;
        return NO;
    } else if ([addressNameTXT.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Address is required."];
        _currentField = addressNameTXT;
        return NO;
    }
    return YES;
}

#pragma mark - Action

- (void)__actionDone:(id)sender {
    if (self.actionDone) {
        self.actionDone(emailNameTXT.text,phoneNameTXT.text,_indexActtionCountryCode,addressNameTXT.text);
    }
    if (![self _isValidation]) {
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)__actionDCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)__actionCountryCode:(id)sender {
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Phone Codes" data:self.arrayCountryCode selectedIndex:_indexActtionCountryCode
                           didSelect:^(NSInteger index) {
        [dropListCountryCode setTitle:[self.arrayCountryCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionCountryCode = index;
    }];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        if (_currentField) {
            [_currentField becomeFirstResponder];
        }
    }
    _currentField = nil;
}

@end
