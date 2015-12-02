//
//  COUserPortfolioCompleteInvestmentModel.h
//  CoAssets
//
//  Created by Tony Tuong on 10/9/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface COUserPortfolioCompleteInvestmentModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *completedAmount;
@property (nonatomic, strong) NSString *completedCrrency;
@end
