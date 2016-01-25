//
//  COCurrencyModel.h
//  CoAssets
//
//  Created by Macintosh HD on 1/25/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COBalanceModel : MTLModel<MTLJSONSerializing>
@property(nonatomic, strong) NSNumber *balance_amt;
@property(nonatomic, strong) NSString *currency;
@property(nonatomic, strong) NSString *updated;

- (NSString *)currencyName;

@end
