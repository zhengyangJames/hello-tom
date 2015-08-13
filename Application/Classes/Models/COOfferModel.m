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
        @"offerId" : @"id",
        @"offerTitle" : @"offer_title",
        @"offerType" : @"offer_type"
    };
}
@end
