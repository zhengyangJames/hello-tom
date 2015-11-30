//
//  CODealProfileModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CODealProfileModel.h"
#import "CODealOngoingModel.h"

@implementation CODealProfileModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealOngoingModel"          : @"ongoing",
        @"dealFundedModel"           : @"funded",
        @"dealCompleteModel"         : @"completed",
        @"signContractInstruction"   : @"sign_contract_instruction",
        @"paymentInstruction"        : @"payment_instruction",
    };
}

+ (NSValueTransformer *)dealOngoingModelJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *array;
        if (value && [value isKindOfClass:[NSArray class]]) {
            array = (NSArray*)value;
        }
        *success = YES;
        return [MTLJSONAdapter modelsOfClass:[CODealOngoingModel class] fromJSONArray:array error:error];
    }];
}

+ (NSValueTransformer *)dealFundedModelJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *array;
        if (value && [value isKindOfClass:[NSArray class]]) {
            array = (NSArray*)value;
        }
        *success = YES;
        return [MTLJSONAdapter modelsOfClass:[CODealOngoingModel class] fromJSONArray:array error:error];
    }];
}

+ (NSValueTransformer *)dealCompleteModelJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSArray *array;
        if (value && [value isKindOfClass:[NSArray class]]) {
            array = (NSArray*)value;
        }
        *success = YES;
        return [MTLJSONAdapter modelsOfClass:[CODealOngoingModel class] fromJSONArray:array error:error];
    }];
}


@end
