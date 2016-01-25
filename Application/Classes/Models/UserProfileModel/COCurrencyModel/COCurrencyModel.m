//
//  COCurrencyModel.m
//  CoAssets
//
//  Created by Macintosh HD on 1/25/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COCurrencyModel.h"

@implementation COCurrencyModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"currencyPofolio"       : @"currency_list",
    };
}

- (NSDictionary *)dictionOfCurrncy {
    return self.currencyPofolio;
}

@end
