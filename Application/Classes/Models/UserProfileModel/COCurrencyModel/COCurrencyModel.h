//
//  COCurrencyModel.h
//  CoAssets
//
//  Created by Macintosh HD on 1/25/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COCurrencyModel : MTLModel<MTLJSONSerializing>
@property(nonatomic, strong) NSDictionary *currencyPofolio;

- (NSDictionary *)dictionOfCurrncy;

@end
