//
//  PasswordTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "PasswordTableViewCell.h"

@interface PasswordTableViewCell () <UITextFieldDelegate,UIAlertViewDelegate>
{
    UITextField *_boxTextField;
}

@end

@implementation PasswordTableViewCell

- (void)viewDidLoad {
    [kNotificationCenter addObserver:self selector:@selector(__actionCheckPassword) name:kNOTIFICATION_CHECK_PASS object:nil];
    self.comfilmPassowrdTXT.delegate = self;
    self.newpassowrdTXT.delegate = self;
}

- (void)__actionCheckPassword {
    if (![self.comfilmPassowrdTXT.text isEmpty]&&![self.newpassowrdTXT.text isEmpty]&&[self.newpassowrdTXT.text isEqualToString: self.comfilmPassowrdTXT.text]) {
        if ([self.delegate respondsToSelector:@selector(passwordTableViewCellTextFieldAction:newPassowrd:)]) {
            [self.delegate passwordTableViewCellTextFieldAction:self newPassowrd:_newpassowrdTXT.text];
        }
    } else if ([self.comfilmPassowrdTXT.text isEmpty]&&[self.newpassowrdTXT.text isEmpty]) {
        _boxTextField = self.newpassowrdTXT;
         [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_REQUIRED", nil) delegate:self tag:0];
    } else if ([self.newpassowrdTXT.text isEmpty]) {
        _boxTextField = self.newpassowrdTXT;
         [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"NEW_PASSWORD_REQUIRED", nil) delegate:self tag:0];
    } else if ([self.comfilmPassowrdTXT.text isEmpty]) {
        _boxTextField = self.comfilmPassowrdTXT;
         [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"CONFIRM_PASSWORD_REQUIRED", nil) delegate:self tag:0];
    } else if (![self.newpassowrdTXT.text isEqualToString: self.comfilmPassowrdTXT.text]) {
        _boxTextField = self.comfilmPassowrdTXT;
         [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"CONFIRM_PASSWORD_MESSAGE", nil) delegate:self tag:0];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.newpassowrdTXT && theTextField.returnKeyType == UIReturnKeyNext) {
        [self.comfilmPassowrdTXT becomeFirstResponder];
    }
    if (theTextField == self.comfilmPassowrdTXT && theTextField.returnKeyType == UIReturnKeyDone) {
        [self.comfilmPassowrdTXT resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (textField == self.comfilmPassowrdTXT && textField.returnKeyType == UIReturnKeyDone) {
        [self.comfilmPassowrdTXT resignFirstResponder];
    }
    return YES;
}

#pragma mark Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_boxTextField becomeFirstResponder];
    _boxTextField = nil;
}

@end
