//
//  COUserPortFolioModel.h
//  CoAssets
//
//  Created by Tony Tuong on 10/9/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>
#import "COUserData.h"

@class COUserPortfolioCompleteInvestmentModel;
@class COUserPortfolioOnGoingInvestmentModel;

@interface COUserPortFolioModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSNumber                                   *ongoingProjects;
@property (nonatomic, strong) COUserPortfolioOnGoingInvestmentModel      *ongoingInvestment;
@property (nonatomic, strong) NSNumber                                   *fundedAndCompletedProjects;
@property (nonatomic, strong) COUserPortfolioCompleteInvestmentModel     *fundedAndCompletedInvestment;
@end
