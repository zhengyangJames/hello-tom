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

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if ([self.delegate respondsToSelector:@selector(passwordTableViewCellTextFieldAction:stringTextField:)]) {
//        [self.delegate passwordTableViewCellTextFieldAction:self stringTextField:textField.text];
//    }
//    return YES;
//}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (![_oldPassowrdTXT.text isEmpty]&&![_newpassowrdTXT.text isEmpty]&&![_comfilmPassowrdTXT.text isEmpty]&&([_newpassowrdTXT.text isEqualToString:_comfilmPassowrdTXT.text])) {
        if ([self.delegate respondsToSelector:@selector(passwordTableViewCellTextFieldAction:oldPassowrd:newPassowrd:comfilmPassowrd:)]) {
            [self.delegate passwordTableViewCellTextFieldAction:self oldPassowrd:_oldPassowrdTXT.text newPassowrd:_newpassowrdTXT.text comfilmPassowrd:_comfilmPassowrdTXT.text];
        }
    }
    return YES;
}

@end
