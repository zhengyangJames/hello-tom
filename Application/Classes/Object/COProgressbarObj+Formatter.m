//
//  COProgressbarObj+Formatter.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/11/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProgressbarObj+Formatter.h"
#import "UIHelper.h"

@implementation COProgressbarObj (Formatter)

+ (NSString *)currencyStringFormatFromValue:(NSString *)value {
    NSString *returnString;
    double number = [value doubleValue];
    NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
    returnString = [UIHelper stringCurrencyFormatFromNumberDouble:numberDouble];
    return returnString;
}

@end
