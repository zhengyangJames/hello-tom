//
//  CODealProfileModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CODealOngoingModel;
@class CODealFundedModel;
@class CODealCompleteModel;

@interface CODealProfileModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) CODealOngoingModel  *dealOngoingModel;
@property (nonatomic, strong) CODealFundedModel   *dealFundedModel;
@property (nonatomic, strong) CODealCompleteModel *dealCompleteModel;
@property (nonatomic, strong) NSString *signContractInstruction;
@property (nonatomic, strong) NSString *paymentInstruction;

- (NSString *)stringOfSignContractInstruction;
- (NSString *)stringOfPaymentInstruction;

@end
