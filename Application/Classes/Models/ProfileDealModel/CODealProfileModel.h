//
//  CODealProfileModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "MTLModel.h"

@class CODealOngoingModel;

@interface CODealProfileModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSArray   *dealOngoingModel;
@property (nonatomic, strong) NSArray   *dealFundedModel;
@property (nonatomic, strong) NSArray   *dealCompleteModel;
@property (nonatomic, strong) NSString *signContractInstruction;
@property (nonatomic, strong) NSString *paymentInstruction;

- (NSString *)stringOfSignContractInstruction;
- (NSString *)stringOfPaymentInstruction;

@end
