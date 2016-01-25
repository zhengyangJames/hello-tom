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

- (NSString *)currencyName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Currency" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in array ) {
        NSString *curencySymbol = dict[@"currencySymbol"];
        if ([curencySymbol isEqualToString:self.currency]) {
            return dict[@"currencyName"];
        }
    }
    return @"";
}

@end
