//
//  CODealOngoingModel.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COOngoingStatusModel;

@interface CODealOngoingModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *dealOngoingNextPayoutDate;
@property (nonatomic, strong) NSString *dealOngoingCurrency;
@property (nonatomic, strong) NSNumber *dealOngoingInvestAmount;
@property (nonatomic, strong) NSNumber *dealOngoingNextPayoutAmount;
@property (nonatomic, strong) NSNumber *dealOngoingPotentialReturnAmount;
@property (nonatomic, strong) NSNumber *dealOngoingPotentialReturnPercent;
@property (nonatomic, strong) NSString *dealOngoingProjectName;
@property (nonatomic, strong) COOngoingStatusModel *dealOngoingStatus;

- (NSString *)stringOfdealCOOngoingStatusModelNextPayoutDate;
- (NSString *)stringOfdealCOOngoingStatusModelCurrency;
- (NSNumber *)numberOfdealCOOngoingStatusModelInvestAmount;
- (NSNumber *)numberOfdealCOOngoingStatusModelNextPayoutAmount;
- (NSNumber *)numberOfdealCOOngoingStatusModelPotentialReturnAmount;
- (NSNumber *)numberOfdealCOOngoingStatusModelPotentialReturnPercent;
- (NSString *)stringOfdealCOOngoingStatusModelProjectName;

@end
