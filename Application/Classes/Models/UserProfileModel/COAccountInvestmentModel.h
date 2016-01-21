//
//  COAccountInvestmentModel.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COUserData.h"

@class COUserPortFolioModel;
@class COMultiPortfolioModel;
@class COMultiPortpolioModel;
@class COMultiPortpolioModel;

@interface COAccountInvestmentModel : MTLModel<MTLJSONSerializing,COAccountCompleted,COAccountFunded,COAccountOnGoing,COAccountPotential,COAccountRealised,COOngoingProjects,COOngoingInvestment,COCompletedInvestment,COCompletedProjects>

@property (nonatomic, strong) NSNumber                  *ongoingInvestment;
@property (nonatomic, strong) NSNumber                  *fundedInvestment;
@property (nonatomic, strong) NSNumber                  *completedInvestment;
@property (nonatomic, strong) NSNumber                  *realisedPayouts;
@property (nonatomic, strong) NSNumber                  *potentialPayouts;
@property (nonatomic, strong) COUserPortFolioModel      *userPortfolio;
@property (nonatomic, strong) COMultiPortpolioModel     *userMultiPortfolio;

@end
