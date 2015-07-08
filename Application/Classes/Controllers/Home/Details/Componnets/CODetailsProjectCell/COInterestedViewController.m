//
//  COInterestedViewController.m
//  CoAssets
//
//  Created by TUONG DANG on 7/7/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COInterestedViewController.h"
#import "COBorderTextField.h"
#import "WSURLSessionManager+ListHome.h"
#import "KLCPopup.h"
#import "COPopupInteredtedView.h"
#import "COCheckBoxButton.h"

@interface COInterestedViewController () <UIAlertViewDelegate,COCheckBoxButtonDelegate>
{
    __weak IBOutlet COBorderTextField *_emailTextField;
    __weak IBOutlet COBorderTextField *_amountTextField;
    __weak IBOutlet COCheckBoxButton *_checkBoxButton;
    UITextField *_textField;
    BOOL _isCheck;
}
@end

@implementation COInterestedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark SetUp UI 
- (void)_setupUI {
    self.title = m_string(@"Interested");
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self _setupRightNavigationButton];
    _checkBoxButton.delegate = self;
}

- (void)_setupRightNavigationButton {
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone)];
    [btBack setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btBack;
}

#pragma mark Action
- (void)__actionDone {
    if ([self _checkEmailAmount]) {
        [self _callWSInteredted];
    }
}

#pragma mark - Web Service
- (void)_callWSInteredted {
    [UIHelper showLoadingInView:self.view];
    NSString *idoffer = [[self.object valueForKey:@"offerID"] stringValue];
    NSString *amount = _amountTextField.text;
    NSString *email = _emailTextField.text;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:amount,@"amount",email,@"email", nil];
    [[WSURLSessionManager shared] wsPostSubscribeWithOffersID:idoffer amount:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        DBG(@"%@",responseObject);
        if (responseObject && !error) {
            _amountTextField.text = nil;
            _emailTextField.text = nil;
            _checkBoxButton.isCheck = NO;
            [kNotificationCenter postNotificationName:kNOTIFICATION_INTERESTED object:nil];
            [self _creatPopupView];
        } else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark Private
- (void)_creatPopupView {
    [COPopupInteredtedView showPopup:[self _setupTitlePopup]];
}

- (NSString*)_setupTitlePopup {
    NSString *string = [NSString stringWithFormat:@"Thank you for crowdfunding, \n%@. \n\nPlease e-sign the contract sent to your email & proceed to make fund transfer within 5 working days. \n\nIf you have any queries, please feel free to call 65327008 or email admin@coassets.com. \nThank you & happy crowdfunding.",[self.object valueForKey:@"offerTitle"]];
    return string;
}

- (BOOL)_checkEmailAmount {
    if([_emailTextField.text isEmpty]) {
        _textField = _emailTextField;
        [self _setupShowAleartViewWithTitle:@"Email is required."];
        return NO;
    } else if (![_emailTextField.text isValidEmail]) {
        _textField = _emailTextField;
        [self _setupShowAleartViewWithTitle:@"Email is invalid."];
        return NO;
    } else if ([_amountTextField.text isEmpty]) {
        _textField = _amountTextField;
        [self _setupShowAleartViewWithTitle:@"Amount is required."];
        return NO;
    } else if (!_isCheck) {
        [self _setupShowAleartViewWithTitle:@"Please agree to allow CoAssets to contact you in order to facilitate the crowdfunding process."];
        return NO;
    }
    return YES;
}

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [self.view endEditing:YES];
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssets")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}


#pragma mark - Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_textField becomeFirstResponder];
    _textField = nil;
}

- (void)checkBoxButton:(COCheckBoxButton *)checkBox didChangeCheckingStatus:(BOOL)isChecking {
    _isCheck = isChecking;
}


@end
