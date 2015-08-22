//
//  UserProfileDetailModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserProfileDetailModel.h"

@implementation COUserProfileDetailModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"profileCountryPrefix" : @"country_prefix",
        @"profileCellPhone"     : @"cellphone",
        @"profileId"            : @"id",
        @"profileAddress1"      : @"address_1",
        @"profileCity"          : @"city",
        @"profileCountry"       : @"country",
        @"profileAddress2"      : @"address_2",
        @"profileRegionState"   : @"region_state",
    };
}
@end
