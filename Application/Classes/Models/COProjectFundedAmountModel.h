//
//  COOfferFundedAmountModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/19/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COOfferData.h"

@interface COProjectFundedAmountModel : MTLModel<MTLJSONSerializing,COProjectFundedAmount>

@property (nonatomic, strong) NSNumber *goal;
@property (nonatomic, strong) NSNumber *currentFundedAmount;
- (BOOL)showProgressBar;
@end
