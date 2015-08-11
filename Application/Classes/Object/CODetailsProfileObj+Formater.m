//
//  CODetailsProfileObj+Formater.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/11/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProfileObj+Formater.h"
#import "UIHelper.h"

@implementation CODetailsProfileObj (Formater)

- (NSString *)stringOfInvestorCount {
    if (self.investor_count) {
        NSString *investor = [NSString stringWithFormat:@"%@ INVESTORS",self.investor_count];
        return investor;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfStatus {
    if (self.status) {
        NSString *status = [NSString stringWithFormat:@"%@",self.status];
        return status;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfMinAnnualReturn {
    if (self.min_annual_return) {
        NSString *YIELD = [NSString stringWithFormat:@"%@ %% (%@%%)",self.min_annual_return,self.min_annual_return];
        return YIELD;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)currencyStringFormatFromInvestment {
    if (self.min_investment) {
        double number = [self.min_investment doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringCurrencyFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)stringOfDayLeft {
    if (self.day_left) {
        NSString *day_left = [NSString stringWithFormat:@"%@",self.day_left];
        return day_left;
    } else {
          return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfTimeHorizon {
    if (self.time_horizon) {
        NSString *time_horizon = [NSString stringWithFormat:@"%@ MONTHS",self.time_horizon];
        return time_horizon;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}


@end
