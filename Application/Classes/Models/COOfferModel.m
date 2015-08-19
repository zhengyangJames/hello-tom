//
//  COOfferModel.m
//  CoAssets
//
//  Created by Linh NGUYEN on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferModel.h"
#import "COProjectModel.h"
#import "CODocumentModel.h"
#import "MTLValueTransformer.h"

@implementation COOfferModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"offerId"                  : @"id",
        @"offerTitle"               : @"offer_title",
        @"offerType"                : @"offer_type",
        @"offerProject"             : @"project",
        @"offerOwnerType"           : @"owner_type",
        @"offerCompanyLogo"         : @"company_logo",
        @"offerStatus"              : @"status",
        @"offerInvestorCount"       : @"investor_count",
        @"offerMinInvestment"       : @"min_investment",
        @"offerTimeHorizon"         : @"time_horizon",
        @"offerAnnualizedReturn"    : @"annualized_return",
        @"offerDayLeft"             : @"day_left",
        @"offerCurrentFundedAmount" : @"current_funded_amount",
        @"offerGoal"                : @"goal",
        @"offerShortDescription"    : @"short_description",
        @"offerProjectDescription"  : @"project_description",
        @"documents"                : @"documents",
        
        
    };
}

+ (NSValueTransformer *)offerProjectJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COProjectModel.class];
}

+ (NSValueTransformer *)documentsJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSMutableArray *array;
        if (value) {
            NSDictionary *dict = (NSDictionary*)value;
            array = [[NSMutableArray alloc] init];
            for (NSString *key in dict.allKeys) {
                NSArray *items = [dict objectForKey:key];
                NSDictionary *documentDict = @{@"title":key, @"items":items};
                [array addObject:documentDict];
            }
        }
        *success = YES;
        return [MTLJSONAdapter modelsOfClass:[CODocumentModel class] fromJSONArray:array error:error];
    }];
}

- (BOOL)showProgressBar {
    return self.offerCurrentFundedAmount && self.offerGoal;
}

- (NSString *)contentProjectWeb {
    return self.offerProjectDescription;
}
#pragma mark - logo protocol

- (NSString *)offerLogoImage {
    return self.offerCompanyLogo;
}

- (NSString *)offerLogoTitle {
    return self.offerTitle;
}

#pragma mark - offer description protocol

- (NSString *)offerDescriptionTitle {
    return NSLocalizedString(@"OFFER", nil);
}

- (NSString *)offerDescriptionContent {
    return self.offerShortDescription;
}

#pragma mark - offer project protocol

- (NSString *)offerProjectTitle {
    return NSLocalizedString(@"PROJECT", nil);
}
- (NSString *)offerProjectContent {
    return self.offerProjectDescription;
}
#pragma mark - offer document protocol

- (NSString *)offerDocumentTitle {
    return NSLocalizedString(@"DOCUMENT", nil);
}

- (NSString *)offerDocumentContent {
    return NSLocalizedString(@"DETAIL_DOCUMENT", nil);
}
#pragma mark - offer address protocol

- (NSString *)offerAddressTitle {
    return NSLocalizedString(@"ADDRESS", nil);
}

- (NSString *)offerAddressContent {
    return [[[[self.offerProject.projectAddress1 stringByAppendingString:@"\n"] stringByAppendingString:self.offerProject.projectCity] stringByAppendingString:@"\n"] stringByAppendingString:self.offerProject.projectCountry];
}

#pragma mark - offer document detail

- (NSArray *)offerDocumentDetail {
    return self.documents;
}

#pragma mark - offer info protocol

- (NSString *)offerInfoStatus {
    if (self.offerStatus) {
        NSString *status = [NSString stringWithFormat:NSLocalizedString(@"STATUS", nil),self.offerStatus];
        return status;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoInvestor {
    if (self.offerInvestorCount) {
        NSString *investor = [NSString stringWithFormat:NSLocalizedString(@"INVESTORS", nil),self.offerInvestorCount];
        return investor;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoMinInvesment {
    if (self.offerMinInvestment) {
        double number = [self.offerMinInvestment doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringDecimalFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoTimeHorizon {
    if (self.offerTimeHorizon) {
        NSString *time_horizon = [NSString stringWithFormat:NSLocalizedString(@"MONTHS", nil),self.offerTimeHorizon];        return time_horizon;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoYield {
    if (self.offerAnnualizedReturn) {
        NSString *annualized = [NSString stringWithFormat:NSLocalizedString(@"MIN_ANNUAL_RETURN", nil),self.offerAnnualizedReturn,self.offerAnnualizedReturn];
        return annualized;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoDayLeft {
    if (self.offerDayLeft) {
        NSString *day_left = [NSString stringWithFormat:NSLocalizedString(@"DAY_LEFT", nil),self.offerDayLeft];
        return day_left;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)offerInfoGoalToString {
    if (self.offerGoal) {
        double value = ([self.offerGoal doubleValue]);
        int intConvert = (int)round(value);
        NSString *returnString = [NSString stringWithFormat:NSLocalizedString(@"GOAL", nil),intConvert];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)currentFundedAmountToString {
    if (self.offerCurrentFundedAmount) {
        double number = [self.offerCurrentFundedAmount doubleValue];
        NSNumber *numberDouble = [NSNumber numberWithDouble:(double)number];
        NSString *returnString = [UIHelper stringCurrencyFormatFromNumberDouble:numberDouble];
        return returnString;
    } else {
        return NSLocalizedString(@"N/A", nil);
    }
}

- (NSString *)totalProgress {
    if (self.offerCurrentFundedAmount && self.offerGoal) {
        double valueCurrent= [self.offerCurrentFundedAmount doubleValue];
        double valueGoal = ([self.offerGoal doubleValue]);
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
    return self.offerGoal;
}
@end
