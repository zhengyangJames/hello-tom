//
//  CODealProfileModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CODealProfileModel.h"
#import "CODealCompleteModel.h"
#import "CODealFundedModel.h"
#import "CODealOngoingModel.h"

@implementation CODealProfileModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealOngoingModel"          : @"ongoing",
        @"dealFundedModel"           : @"funded",
        @"dealCompleteModel"         : @"completed",
        @"signContractInstruction"   : @"sign_contract_instruction",
        @"paymentInstruction"        : @"payment_instruction",
    };
}

+ (NSValueTransformer *)dealOngoingModelJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CODealCompleteModel.class];
}

+ (NSValueTransformer *)dealFundedModelJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CODealFundedModel.class];
}

+ (NSValueTransformer *)dealCompleteModelJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CODealOngoingModel.class];
}

- (NSString *)stringOfSignContractInstruction {
    return self.signContractInstruction;
}

- (NSString *)stringOfPaymentInstruction {
    return self.paymentInstruction;
}

@end
