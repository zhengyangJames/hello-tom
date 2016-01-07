//
//  COOfferFundedAmountModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/19/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProjectFundedAmountModel.h"

@implementation COProjectFundedAmountModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"goal"                 : @"goal",
        @"currentFundedAmount"  : @"current_funded_amount"
    };
}

+ (NSValueTransformer *)goalJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value && [value isKindOfClass:[NSNumber class]]) {
            return value;
        }
        return nil;
    }];
}

+ (NSValueTransformer *)currentFundedAmountJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value && [value isKindOfClass:[NSNumber class]]) {
            return value;
        }
        return nil;
    }];
}

#pragma mark - funded amount protocol

- (NSString *)offerInfoGoalToString {
    if (self.goal) {
        double value = ([self.goal doubleValue]);
        int intConvert = (int)round(value);
        NSString *returnString = [NSString stringWithFormat:m_string(@"GOAL"),intConvert];
        return returnString;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)currentFundedAmountToString {
    if (self.currentFundedAmount) {
        double number = [self.currentFundedAmount doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringCurrencyFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return m_string(@"N/A");
    }
}

- (NSString *)totalProgress {
    if (self.currentFundedAmount && self.goal) {
        double valueCurrent= [self.currentFundedAmount doubleValue];
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

- (NSNumber *)goalOrigin {
    return self.goal;
}

- (BOOL)showProgressBar {
    return self.goal && self.currentFundedAmount;
}

@end
