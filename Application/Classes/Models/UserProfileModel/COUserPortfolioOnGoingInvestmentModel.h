//
//  COUserPortfolioOnGoingInvestmentModel.h
//  CoAssets
//
//  Created by Tony Tuong on 10/9/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface COUserPortfolioOnGoingInvestmentModel :  MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber *onGoingAmount;
@property (nonatomic, strong) NSString *onGoingCrrency;
@end
