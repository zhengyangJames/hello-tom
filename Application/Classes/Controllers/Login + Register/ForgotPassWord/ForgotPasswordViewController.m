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

- (BOOL)_isValidation {
    if ([emailTextField.text isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_REQUIRED", nil) delegate:self tag:0];
        return NO;
    }else if (![emailTextField.text isValidEmail]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_INVALID", nil) delegate:self tag:0];
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
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {;
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"MESSEAGE_RESET_PASSWORD", nil) delegate:self tag:10];
        } else {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"YOUR_EMAIL_INVALID", nil) delegate:self tag:20];
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
