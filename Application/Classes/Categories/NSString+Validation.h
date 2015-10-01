//
//  NSString+Validation.h
//  CoAssest
//
//  Created by TUONG DANG on 6/20/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validation)

- (BOOL)isValidEmail;
- (BOOL)isValidPasswordRegExr;
- (BOOL)isValidPassword;
- (BOOL)isCheckWhitleSpace;
- (BOOL)isCheckCharacterRequiesment;
@end
