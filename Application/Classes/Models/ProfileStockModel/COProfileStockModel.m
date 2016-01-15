//
//  COProfileStockModel.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COProfileStockModel.h"

@implementation COProfileStockModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"code"          : @"code",
        @"currency"      : @"currency",
        @"price"          : @"price",
        @"price_date"     : @"price_date",
    };
}

- (NSString *)stringOfCode {
    return [self.code trim];
}

- (NSString *)stringOfCurrency {
    return [self.currency trim];
}

- (NSNumber *)numberOfPrice {
    return self.price;
}

- (NSString *)stringOfPriceDate {
    return [self.price_date trim];
}

@end
