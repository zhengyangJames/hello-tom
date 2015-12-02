//
//  UserTokensModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserTokensModel.h"

@implementation COUserTokensModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"tokenId"          : @"id",
        @"tokenCreditQty"   : @"credit_qty",
    };
}
@end
