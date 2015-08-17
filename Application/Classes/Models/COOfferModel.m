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

@end
