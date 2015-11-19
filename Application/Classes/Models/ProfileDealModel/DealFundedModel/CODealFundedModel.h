//
//  CODealFundedModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CODealFundedModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *dealFundNextPayoutamount;
@property (nonatomic, strong) NSString *dealFundCurrency;
@property (nonatomic, strong) NSNumber *dealFundInvestAmount;
@property (nonatomic, strong) NSNumber *dealFundNextPayoutAmount;
@property (nonatomic, strong) NSNumber *dealFundPotentialReturnAmount;
@property (nonatomic, strong) NSString *dealFundPotentialReturnRercent;
@property (nonatomic, strong) NSString *dealFundProjectName;

@end
