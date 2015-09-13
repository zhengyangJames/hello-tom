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

- (NSString *)stringOfGoal {
    if (self.goal) {
        double value = ([self.goal doubleValue]);
        int intConvert = (int)round(value);
        NSString *returnString = [NSString stringWithFormat:NSLocalizedString(@"GOAL", nil),intConvert];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)currencyStringFormatFromCurrentFundedAmount {
    if (self.current_funded_amount) {
        double number = [self.current_funded_amount doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringCurrencyFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}


- (NSString *)stringOfTotalCurrency {
    if (self.current_funded_amount && self.goal) {
        double valueCurrent= [self.current_funded_amount doubleValue];
        double valueGoal = ([self.goal doubleValue]);
        int total;
        if(valueGoal != 0) {
            total = (int)round((valueCurrent * 100)/valueGoal);
        } else {
            total = 0;
        }
        double totalDouble = (double)total;
        NSNumber *numberTotal = [NSNumber numberWithDouble:totalDouble];
        NSString *totalString = [UIHelper stringCurrencyFormatFromNumberDouble:numberTotal];
        return totalString;
    } else {
        return nil;
    }
}
@end
