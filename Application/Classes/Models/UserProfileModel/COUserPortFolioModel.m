//
//  COUserPortFolioModel.m
//  CoAssets
//
//  Created by Tony Tuong on 10/9/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COUserPortFolioModel.h"
#import "COUserPortfolioCompleteInvestmentModel.h"
#import "COUserPortfolioOnGoingInvestmentModel.h"

@implementation COUserPortFolioModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"ongoingProjects"              : @"ongoing_projects",
        @"ongoingInvestment"            : @"ongoing_investment",
        @"fundedAndCompletedProjects"   : @"funded_and_completed_projects",
        @"fundedAndCompletedInvestment" : @"funded_and_completed_investment",
    };
}

+ (NSValueTransformer *)ongoingInvestmentJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserPortfolioOnGoingInvestmentModel.class];
}

+ (NSValueTransformer *)fundedAndCompletedInvestmentInvestmentJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserPortfolioCompleteInvestmentModel.class];
}

@end
