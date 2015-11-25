//
//  COUserInverstorModel.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserInverstorModel.h"

@implementation COUserInverstorModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"investor"  : @"investor_type",
//        @"investor_list" : @"investor_type_list",
        @"project"   : @"project_type",
//        @"project_list" : @"project_type_list",
        @"currency"   : @"currency_preference",
//        @"currency_list" : @"currency_list",
        @"investment"  : @"investment_budget",
        @"target"   : @"target_annualize_return",
        @"countries"   : @"country",
        @"descriptions"   : @"description",
        @"website"   : @"website",
        @"duration"   : @"duration_preference_in_month",
    };
}

#pragma mark - Cureency
- (NSString *)COCureencyContent {
    if (self.currency) {
        return self.currency;
    }
    return @"Singapore Dollars";
}

- (void)setCOCureencyContent:(NSString *)string {
    self.currency = string;
}

#pragma mark - Description
- (NSString *)CODescriptionsContent {
    if (self.descriptions) {
        return self.descriptions;
    }
    return @"";
}

- (void)setCODescriptionsContent:(NSString *)string {
    self.descriptions = string;
}

#pragma mark - Website
- (NSString *)COWebsiteContent {
    if (self.website) {
        return self.website;
    }
    return @"";
}

- (void)setCOWebsiteContent:(NSString *)string {
    self.website = string;
}

#pragma mark - Investor

- (NSString *)COInvestorTypeTitle {
    return m_string(@"INVESTOR_TYPE");
}
- (NSString *)COInvestorTypeContent {
    if (self.investor) {
        return self.investor;
    }
    return @"Retail Investor";
}

- (void)setCOInvestorTypeContent:(NSString *)string {
    self.investor = string;
}

#pragma mark - Project
- (NSString *)COInvestorPreferenceTitle {
    return m_string(@"INVESTOR_PREFERENCE");
}
- (NSString *)COInvestorPreferenceContent {
    if (self.project) {
        return self.project;
    }
    return @"Crowdfunding";
}

- (void)setCOInvestorPreferenceContent:(NSString *)string {
    self.project = string;
}

#pragma mark - Investment

- (NSString *)COInvestorAmountTitle {
    return m_string(@"INVESTOR_AMOUNT");
}

- (NSString *)COInvestorAmountContent {
    if (self.investment) {
        return [self.investment stringValue];
    }
    return @"1000";
}

- (void)setCOInvestorAmountContent:(NSString *)string {
    self.investment = [NSNumber numberWithInteger:[string integerValue]];
}

#pragma mark - Target

- (NSString *)COInvestorTargetTitle {
    return m_string(@"INVESTOR_TARGET");
}

- (NSString *)COInvestorTargetContent {
    if (self.target) {
        return [self.target stringValue];
    }
    return @"Unknown";
}

- (void)setCOInvestorTargetContent:(NSString *)string {
    self.target = [NSNumber numberWithInteger:[string integerValue]];
}

#pragma mark - Duration

- (NSString *)COInvestorDurationTitle {
    return m_string(@"INVESTOR_DURATION");
}
- (NSString *)COInvestorDurationContent {
    if (self.duration) {
        return [self.duration stringValue];
    }
    return @"Unknown";
}

- (void)setCOInvestorDurationContent:(NSString *)string {
    self.duration = [NSNumber numberWithInteger:[string integerValue]];
}

#pragma mark - Countries

- (NSString *)COInvestorCountriesTitle {
    return m_string(@"INVESTOR_COUNTRIES");
}

- (NSString *)COInvestorCountriesContent {
    if (self.countries) {
        return self.countries;
    }
    return @"";
}

- (void)setCOInvestorCountriesContent:(NSString *)string {
    self.countries = string;
}

@end
