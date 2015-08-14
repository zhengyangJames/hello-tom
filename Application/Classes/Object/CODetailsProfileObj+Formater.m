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
        NSString *investor = [NSString stringWithFormat:NSLocalizedString(@"INVESTORS", nil),self.investor_count];
        return investor;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfStatus {
    if (self.status) {
        NSString *status = [NSString stringWithFormat:NSLocalizedString(@"STATUS", nil),self.status];
        return status;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfMinAnnualReturn {
    if (self.annualized_return) {
        NSString *annualized = [NSString stringWithFormat:NSLocalizedString(@"MIN_ANNUAL_RETURN", nil),self.annualized_return,self.annualized_return];
        return annualized;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)currencyStringFormatFromInvestment {
    if (self.min_investment) {
        double number = [self.min_investment doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringDecimalFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)stringOfDayLeft {
    if (self.day_left) {
        NSString *day_left = [NSString stringWithFormat:NSLocalizedString(@"DAY_LEFT", nil),self.day_left];
        return day_left;
    } else {
          return NSLocalizedString(@"N/A", nil);
    }
}
- (NSString *)stringOfTimeHorizon {
    if (self.time_horizon) {
        NSString *time_horizon = [NSString stringWithFormat:NSLocalizedString(@"MONTHS", nil),self.time_horizon];        return time_horizon;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}


@end
