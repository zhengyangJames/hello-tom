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
        @"investor"  : @"iv_investor",
        @"project"   : @"iv_project",
        @"currency"   : @"iv_currency",
        @"investment"  : @"iv_investment",
        @"target"   : @"iv_target",
        @"countries"   : @"iv_countries",
        @"descriptions"   : @"iv_descriptions",
        @"website"   : @"iv_website",
        @"duration"   : @"iv_duration",
    };
}

#pragma mark - Cureency
- (NSString *)COCureencyContent {
    if (self.currency) {
        return self.currency;
    }
    return @"SGD";
}
#pragma mark - Description
- (NSString *)CODescriptionsContent {
    if (self.descriptions) {
        return self.descriptions;
    }
    return @"";
}
#pragma mark - Website
- (NSString *)COWebsiteContent {
    if (self.website) {
        return self.website;
    }
    return @"";
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

#pragma mark - Investment

- (NSString *)COInvestorAmountTitle {
    return m_string(@"INVESTOR_AMOUNT");
}
- (NSString *)COInvestorAmountContent {
    if (self.investment) {
        return self.investment;
    }
    return @"1000";
}

#pragma mark - Target

- (NSString *)COInvestorTargetTitle {
    return m_string(@"INVESTOR_TARGET");
}
- (NSString *)COInvestorTargetContent {
    if (self.target) {
        return self.target;
    }
    return @"Unknown";
}

#pragma mark - Duration

- (NSString *)COInvestorDurationTitle {
    return m_string(@"INVESTOR_DURATION");
}
- (NSString *)COInvestorDurationContent {
    if (self.target) {
        return self.target;
    }
    return @"Unknown";
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

@end
