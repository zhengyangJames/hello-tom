//
//  COOfferModel.m
//  CoAssets
//
//  Created by Linh NGUYEN on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferModel.h"

@implementation COOfferModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"offerId"                  : @"id",
        @"offerTitle"               : @"offer_title",
        @"offerType"                : @"offer_type",
        @"offerTimeHorizon"         : @"time_horizon",
        @"offerMaxAnnualReturn"     : @"max_annual_return",
        @"offerShortDescription"    : @"short_description",
        @"offerProject"             : @"project",
        @"offerMinInvestment"       : @"min_investment",
        @"offerOwnerType"           : @"owner_type",
        @"offerTokensPerFancy"      : @"tokens_per_fancy",
        @"offerInterested"          : @"interested",
        @"offerMinAnnualReturn"     : @"min_annual_return",
        @"offerCurrency"            : @"currency"
        
    };
}

+ (NSValueTransformer *)offerProjectJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COProjectModel.class];
}

@end
