//
//  NSString+Validation.m
//  CoAssest
//
//  Created by TUONG DANG on 6/20/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)

- (BOOL)isValidEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPassword {
    
//    NSCharacterSet *upperCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLKMNOPQRSTUVWXYZ"];
    NSCharacterSet *lowerCaseChars = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    
    if ( [self length]<6 || [self length]>20 )
        return NO;  // too long or too short
    NSRange rang;
    rang = [self rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length )
        return NO;  // no letter
//    rang = [self rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
//    if ( !rang.length )
//        return NO;  // no number;
//    rang = [self rangeOfCharacterFromSet:upperCaseChars];
//    if ( !rang.length )
//        return NO;  // no uppercase letter;
    rang = [self rangeOfCharacterFromSet:lowerCaseChars];
    if ( !rang.length )
        return NO;  // no lowerCase Chars;
    return YES;
}

- (BOOL)isValidPasswordRegExr {
//    NSString *laxString = @"^(?=.{2,8}$)(?=.*?[A-Za-z0-9])(?=.*?[\\W_])[\\w\\W]+";
    NSString *valid = @"(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{5,25}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valid];
    return [passwordTest evaluateWithObject:self];
}

@end
