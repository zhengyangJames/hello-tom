//
//  COUserAccountModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/24/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserAccountModel.h"

@implementation COUserAccountModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"accountType"      : @"account_type",
        @"accountExpiry"    : @"account_axpiry"
    };
}
@end
