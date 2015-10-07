//
//  COAccountInvestmentModel.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>
#import "COUserData.h"

@interface COAccountInvestmentModel : MTLModel<MTLJSONSerializing,COAccountCompleted,COAccountFunded,COAccountOnGoing,COAccountPotential,COAccountRealised>

@property (nonatomic, strong) NSNumber                  *ongoingInvestment;
@property (nonatomic, strong) NSNumber                  *fundedInvestment;
@property (nonatomic, strong) NSNumber                  *completedInvestment;
@property (nonatomic, strong) NSNumber                  *realisedPayouts;
@property (nonatomic, strong) NSNumber                  *potentialPayouts;

@end
