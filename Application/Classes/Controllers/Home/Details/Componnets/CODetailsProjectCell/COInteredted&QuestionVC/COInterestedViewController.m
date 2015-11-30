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
#import "WSPostSubscribeRequest.h"

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self _setupRightNavigationButton];
    if (![[COLoginManager shared] userModel]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    [self _reloadUI];
}

#pragma mark SetUp UI 
- (void)_setupUI {
    self.title = NSLocalizedString(@"INTERESTED_TITLE", nil);
    _checkBoxButton.delegate = self;
}

- (void)_reloadUI {
    _emailTextField.text = _coInterested.stringOfUserEmail;
    _amountTextField.text = [_coInterested.numberOfOfferAmount stringValue];
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
- (void)setCoInterested:(id<COInterestedAction>)coInterested {
    _coInterested = coInterested;
}
#pragma mark Action
- (void)__actionDone {
    [self.view endEditing:YES];
    if ([self _checkEmailAmount]) {
        [self _callWSInteredted];
    }
}

#pragma mark - Web Service
- (WSPostSubscribeRequest *)_createPostSubsRequest {
    WSPostSubscribeRequest *request = [[WSPostSubscribeRequest alloc] init];
    [request setHTTPMethod:METHOD_POST];
    NSString *url = [NSString stringWithFormat:WS_METHOD_POST_SUBSCRIBE,[self.coInterested.numberIdOfOffer stringValue]];
    [request setURL:[NSURL URLWithString:url]];
    [request setBodyParam:_amountTextField.text forKey:kPostSubsAmount];
    [request setBodyParam:_emailTextField.text forKey:kPostSubsEmail];
    [request setValueWithModel:[[COLoginManager shared] userModel]];
    return request;
}

- (void)_callWSInteredted {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsPostSubscribeWithRequest:[self _createPostSubsRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (responseObject && !error) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                _amountTextField.text = nil;
//                _emailTextField.text = nil;
//                _checkBoxButton.isCheck = NO;
//            }];
            [kNotificationCenter postNotificationName:kNOTIFICATION_INTERESTED object:nil];
            [self _creatPopupView];
        }else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
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
    NSString *string = [NSString stringWithFormat:NSLocalizedString(@"Interested_Popup", nil),self.coInterested.stringOfOfferTitle];
    
    return string;
}

- (BOOL)_checkMinimumInvestmentAmount {
    NSInteger current = _amountTextField.text.integerValue;
    NSInteger minimum = _coInterested.numberOfOfferAmount.integerValue;
    if (current && minimum && current >= minimum) {
        return YES;
    }
    return NO;
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
    } else if (![self _checkMinimumInvestmentAmount]) {
        [UIHelper showAlertViewErrorWithMessage:[NSString stringWithFormat:NSLocalizedString(@"MINIMUM_MESSAGE", nil),_coInterested.numberOfOfferAmount.stringValue] delegate:nil tag:0];
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
