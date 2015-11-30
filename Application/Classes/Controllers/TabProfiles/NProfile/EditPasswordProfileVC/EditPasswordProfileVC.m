//
//  EditPasswordProfileVC.m
//  CoAssets
//
//  Created by Tony Tuong on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditPasswordProfileVC.h"
#import "WSChangePassWordRequest.h"
#import "WSURLSessionManager+User.h"

@interface EditPasswordProfileVC () <UITextFieldDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *newpassowrdTXT;
    __weak IBOutlet UITextField *comfilmPassowrdTXT;
    UITextField *_boxTextField;
}

@end

@implementation EditPasswordProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _setupData];
}

#pragma mark - Private

- (void)_setupUI {
    self.navigationItem.title = m_string(@"VIEW_PASSWORD");
    [self _setupBarButtonDone];
    [self _setupBarButtonCancel];
    comfilmPassowrdTXT.delegate = self;
    newpassowrdTXT.delegate = self;
}

- (void)_setupData {
    
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"DONE_TITLE", nil)
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"CANCEL_TITLE", nil)
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btCancel;
}

- (BOOL)__actionCheckPassword {
    if ([comfilmPassowrdTXT.text isEmpty]&&[newpassowrdTXT.text isEmpty]) {
        _boxTextField = newpassowrdTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if ([newpassowrdTXT.text isEmpty]) {
        _boxTextField = newpassowrdTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"NEW_PASSWORD_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if ([comfilmPassowrdTXT.text isEmpty]) {
        _boxTextField = comfilmPassowrdTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"CONFIRM_PASSWORD_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if (![newpassowrdTXT.text isEqualToString: comfilmPassowrdTXT.text]) {
        _boxTextField = comfilmPassowrdTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"CONFIRM_PASSWORD_MESSAGE", nil) delegate:self tag:0];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == newpassowrdTXT && theTextField.returnKeyType == UIReturnKeyNext) {
        [comfilmPassowrdTXT becomeFirstResponder];
    }
    if (theTextField == comfilmPassowrdTXT && theTextField.returnKeyType == UIReturnKeyDone) {
        [comfilmPassowrdTXT resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField == comfilmPassowrdTXT && textField.returnKeyType == UIReturnKeyDone) {
        [comfilmPassowrdTXT resignFirstResponder];
    }
    return YES;
}

#pragma mark - WS
- (void)_callWSUpdatePassword:(NSString *)newPass{
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared]wsChangePasswordWithRequest:[self _setChangePassWordRequestWithPass:newPass] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_CHANGE_SUCCESSFULLY", nil) delegate:self tag:1];
        } else {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_NOT_CHANGED", nil) delegate:self tag:0];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.view endEditing:YES];
        }];
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
    }];
    
}

- (WSChangePassWordRequest *)_setChangePassWordRequestWithPass:(NSString *)password {
    WSChangePassWordRequest *request = [[WSChangePassWordRequest alloc] init];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_POST_CHANGE_PASSWORD]];
    NSString *body = [NSString stringWithFormat:@"%@=%@",kNewPassWord,password];
    NSData *parambody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:parambody];
    return request;
}

#pragma mark - Action
- (void)__actionDone:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if ([self __actionCheckPassword]) {
        [self _callWSUpdatePassword:newpassowrdTXT.text];
    }
}

- (void)__actionDCancel:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [_boxTextField becomeFirstResponder];
    _boxTextField = nil;
}

@end
