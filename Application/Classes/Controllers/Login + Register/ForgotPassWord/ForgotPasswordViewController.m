//
//  ForgotPasswordViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "COBorderTextField.h"
#import "WSURLSessionManager+User.h"

@interface ForgotPasswordViewController () <UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *emailTextField;
    __weak COBorderTextField *_currentField;
}


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
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
    if ([emailTextField.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Email is required."];
        _currentField = emailTextField;
        return NO;
    }else if (![emailTextField.text isValidEmail]) {
        [self _setupShowAleartViewWithTitle:@"Email is invalid."];
        _currentField = emailTextField;
        return NO;
    }
    return YES;
}


#pragma mark - Action
- (IBAction)__actionCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)__actionReset:(id)sender {
    if (![self _isValidation]) {
        return;
    } else {
        [self _callWSProgotPassoword];
    }
}

#pragma mark - Web Service
- (void)_callWSProgotPassoword {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:emailTextField.text,@"email", nil];
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsForgotPassword:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [UIHelper showAleartViewWithTitle:nil message:m_string(@"Your email is invalid.") cancelButton:m_string(@"OK") delegate:nil tag:100 arrayTitleButton:nil];
        }
        [UIHelper hideLoadingFromView:self.view];
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
