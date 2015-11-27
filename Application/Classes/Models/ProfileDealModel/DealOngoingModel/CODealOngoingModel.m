//
//  CODealOngoingModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CODealOngoingModel.h"
#import "COOngoingStatusModel.h"

@implementation CODealOngoingModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealOngoingNextPayoutDate"            : @"next_payout_date",
        @"dealOngoingCurrency"                  : @"currency",
        @"dealOngoingInvestAmount"              : @"invest_amount",
        @"dealOngoingNextPayoutAmount"          : @"next_payout_amount",
        @"dealOngoingPotentialReturnAmount"     : @"potential_return_amount",
        @"dealOngoingPotentialReturnPercent"    : @"potential_return_percent",
        @"dealOngoingProjectName"               : @"project_name",
        @"dealOngoingStatus"                    : @"status",
        @"dealOngoingPaymentInstruction"        : @"payment_instruction",
        @"dealOngoingContractInstruction"       : @"sign_contract_instruction",
        
    };
}


+ (NSValueTransformer *)dealOngoingStatusJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COOngoingStatusModel.class];
}

- (NSString *)stringOfdealCOOngoingStatusModelNextPayoutDate {
    return [self.dealOngoingNextPayoutDate trim];
}
- (NSString *)stringOfdealCOOngoingStatusModelCurrency {
    return [self.dealOngoingCurrency trim];
}
- (NSNumber *)numberOfdealCOOngoingStatusModelInvestAmount {
    return self.dealOngoingInvestAmount;
}
- (NSNumber *)numberOfdealCOOngoingStatusModelNextPayoutAmount {
    return self.dealOngoingNextPayoutAmount;
}
- (NSNumber *)numberOfdealCOOngoingStatusModelPotentialReturnAmount {
    return self.dealOngoingPotentialReturnAmount;
}
- (NSNumber *)numberOfdealCOOngoingStatusModelPotentialReturnPercent {
    return self.dealOngoingPotentialReturnPercent;
}
- (NSString *)stringOfdealCOOngoingStatusModelProjectName {
    return [self.dealOngoingProjectName trim];
}
@end
