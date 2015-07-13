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

#define MESSEAGE_RESET_PASSWORD @"Password Reset Successful We've e-mailed you instructions for setting your password to the e-mail address you submitted. You should be receiving it shortly"

@interface ForgotPasswordViewController () <UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *emailTextField;

}


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [emailTextField becomeFirstResponder];
}


#pragma mark - Private
- (void)_setupShowAleartViewWithTitle:(NSString*)message tag:(NSInteger)tag {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssets")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:tag
                     arrayTitleButton:nil];
}

- (BOOL)_isValidation {
    if ([emailTextField.text isEmpty]) {
        [self _setupShowAleartViewWithTitle:@"Email is required." tag:0];
        return NO;
    }else if (![emailTextField.text isValidEmail]) {
        [self _setupShowAleartViewWithTitle:@"Email is invalid." tag:0];
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
        [emailTextField resignFirstResponder];
        [self _callWSProgotPassoword];
    }
}

#pragma mark - Web Service
- (void)_callWSProgotPassoword {
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:emailTextField.text,@"email", nil];
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsForgotPassword:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {
            [self _setupShowAleartViewWithTitle:m_string(MESSEAGE_RESET_PASSWORD) tag:10];
        } else {
            [self _setupShowAleartViewWithTitle:m_string(@"Your email is invalid.") tag:20];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [emailTextField becomeFirstResponder];
}

@end
