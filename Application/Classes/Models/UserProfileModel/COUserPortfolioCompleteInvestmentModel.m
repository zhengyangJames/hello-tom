//
//  COUserPortfolioCompleteInvestmentModel.m
//  CoAssets
//
//  Created by Tony Tuong on 10/9/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COUserPortfolioCompleteInvestmentModel.h"

@implementation COUserPortfolioCompleteInvestmentModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"completedAmount" : @"SGD",
        @"completedCrrency" : @"MYR",
    };
}
@end
