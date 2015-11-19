//
//  CODealCompleteModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CODealCompleteModel.h"

@implementation CODealCompleteModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealOngoingModel"          : @"ongoing",
        @"dealFundedModel"           : @"funded",
        @"dealCompleteModel"         : @"completed",
        @"signContractInstruction"   : @"sign_contract_instruction",
        @"paymentInstruction"        : @"payment_instruction",
    };
}

@end
