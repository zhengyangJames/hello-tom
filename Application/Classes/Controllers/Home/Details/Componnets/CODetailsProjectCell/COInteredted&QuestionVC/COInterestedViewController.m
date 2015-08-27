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
#import "COLoginManager.h"

@interface COInterestedViewController () <UIAlertViewDelegate,COCheckBoxButtonDelegate>
{
    __weak IBOutlet COBorderTextField *_emailTextField;
    __weak IBOutlet COBorderTextField *_amountTextField;
    __weak IBOutlet COCheckBoxButton *_checkBoxButton;
    __weak COPopupInteredtedView *_popup;
    UITextField *_textField;
    BOOL _isCheck;
}
@end

@implementation COInterestedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.object = self.object;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self _setupRightNavigationButton];
    if (![kUserDefaults objectForKey:kUSER]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark SetUp UI 
- (void)_setupUI {
    self.title = NSLocalizedString(@"INTERESTED_TITLE", nil);
    _checkBoxButton.delegate = self;
}

- (void)_setupRightNavigationButton {
    UIBarButtonItem *btBack = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"DONE_TITLE", nil)
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone)];
    [btBack setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btBack;
}

#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
    [_emailTextField setText:[_object valueForKey:@"email"]];
    [_amountTextField setText:[[_object valueForKey:@"amount"] stringValue]];
}

#pragma mark Action
- (void)__actionDone {
    [self.view endEditing:YES];
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
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                _amountTextField.text = nil;
                _emailTextField.text = nil;
                _checkBoxButton.isCheck = NO;
            }];
            [kNotificationCenter postNotificationName:kNOTIFICATION_INTERESTED object:nil];
            [self _creatPopupView];
        }else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark Private
- (void)_creatPopupView {
    _popup = [COPopupInteredtedView showPopup:[self _setupTitlePopup]];
    [_popup setActionClosePopup:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (NSString*)_setupTitlePopup {
    NSString *string = [NSString stringWithFormat:@"Thank you for crowdfunding, \n%@. \n\nPlease e-sign the contract sent to your email & proceed to make fund transfer within 5 working days. \n\nIf you have any queries, please feel free to call 65327008 or email admin@coassets.com. \nThank you & happy crowdfunding.",[self.object valueForKey:@"offerTitle"]];
    return string;
}

- (BOOL)_checkEmailAmount {
    if([_emailTextField.text isEmpty]) {
        _textField = _emailTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if (![_emailTextField.text isValidEmail]) {
        _textField = _emailTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_INVALID", nil) delegate:self tag:0];
        return NO;
    } else if ([_amountTextField.text isEmpty]) {
        _textField = _amountTextField;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"AMOUNT_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if (!_isCheck) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"MESSAGE_CHECK_EMAIL", nil) delegate:self tag:0];
        return NO;
    }
    return YES;
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
