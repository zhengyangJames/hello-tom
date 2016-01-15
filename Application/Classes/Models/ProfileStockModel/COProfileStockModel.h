//
//  COProfileStockModel.h
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COProfileStockModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *price_date;

- (NSString *)stringOfCode;
- (NSString *)stringOfCurrency;
- (NSNumber *)numberOfPrice;
- (NSString *)stringOfPriceDate;

@end
