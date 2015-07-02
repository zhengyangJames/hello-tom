//
//  PasswordTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "PasswordTableViewCell.h"

@interface PasswordTableViewCell () <UITextFieldDelegate>
{

}

@end

@implementation PasswordTableViewCell

- (void)viewDidLoad {
    [kNotificationCenter addObserver:self selector:@selector(__actionCheckPassword) name:@"check_password" object:nil];
    self.comfilmPassowrdTXT.delegate = self;
    self.newpassowrdTXT.delegate = self;
}

- (void)__actionCheckPassword {
    if ([self.newpassowrdTXT.text isEqualToString: self.comfilmPassowrdTXT.text]) {
        if ([self.delegate respondsToSelector:@selector(passwordTableViewCellTextFieldAction:newPassowrd:comfilmPassowrd:)]) {
            [self.delegate passwordTableViewCellTextFieldAction:self newPassowrd:_newpassowrdTXT.text comfilmPassowrd:_comfilmPassowrdTXT.text];
        }
    } else {
        [self _setupShowAleartViewWithTitle:m_string(@"Passwords don't match")];
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
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

@end
