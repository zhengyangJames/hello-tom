//
//  COUserInverstorModel.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserInverstorModel.h"

@implementation COUserInverstorModel

- (NSString *)COInvestorTypeTitle {
    return m_string(@"INVESTOR_TYPE");
}
- (NSString *)COInvestorTypeContent {
    return @"Retail Investor";
}

- (NSString *)COInvestorPreferenceTitle {
    return m_string(@"INVESTOR_PREFERENCE");
}
- (NSString *)COInvestorPreferenceContent {
    return @"Crowdfunding";
}

- (NSString *)COInvestorAmountTitle {
    return m_string(@"INVESTOR_AMOUNT");
}
- (NSString *)COInvestorAmountContent {
    return @"SGD 1000";
}

- (NSString *)COInvestorTargetTitle {
    return m_string(@"INVESTOR_TARGET");
}
- (NSString *)COInvestorTargetContent {
    return @"Unknown";
}

- (NSString *)COInvestorDurationTitle {
    return m_string(@"INVESTOR_DURATION");
}
- (NSString *)COInvestorDurationContent {
    return @"Unknown";
}

- (NSString *)COInvestorCountriesTitle {
    return m_string(@"INVESTOR_COUNTRIES");
}
- (NSString *)COInvestorCountriesContent {
    return @"";
}

@end
