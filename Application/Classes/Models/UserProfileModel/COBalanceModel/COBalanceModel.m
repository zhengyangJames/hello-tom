//
//  COCurrencyModel.m
//  CoAssets
//
//  Created by Macintosh HD on 1/25/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COBalanceModel.h"

@implementation COBalanceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"balance_amt"       : @"balance_amt",
        @"currency"       : @"currency",
        @"updated"       : @"updated",
    };
}


@end
