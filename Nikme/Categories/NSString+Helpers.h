//
//  NSDictionary+Helpers.h
//  NikmeApp
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helpers)

- (NSString*)trim;
- (BOOL)isEmpty;
- (NSString*)urlEncode;
- (NSString*)urlDecode;
- (NSString *)firstLetter;
- (NSString*)uppercaseStringFristLeter;
@end
