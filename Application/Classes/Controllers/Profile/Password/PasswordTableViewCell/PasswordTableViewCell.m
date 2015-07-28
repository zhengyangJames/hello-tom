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
    [kNotificationCenter addObserver:self selector:@selector(__actionCheckPassword) name:@"check_password" object:nil];
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
        [self _setupShowAleartViewWithTitle:m_string(@"Passwords is required")];
    } else if ([self.newpassowrdTXT.text isEmpty]) {
        _boxTextField = self.newpassowrdTXT;
        [self _setupShowAleartViewWithTitle:m_string(@"New password is required")];
    } else if ([self.comfilmPassowrdTXT.text isEmpty]) {
        _boxTextField = self.comfilmPassowrdTXT;
        [self _setupShowAleartViewWithTitle:m_string(@"Confirm password is required")];
    } else if (![self.newpassowrdTXT.text isEqualToString: self.comfilmPassowrdTXT.text]) {
        _boxTextField = self.comfilmPassowrdTXT;
        [self _setupShowAleartViewWithTitle:m_string(@"Confirm Passwords don't match")];
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

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [self endEditing:YES];
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssets")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

#pragma mark Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_boxTextField becomeFirstResponder];
    _boxTextField = nil;
}

@end
