//
//  CODetailsProgressViewTableViewCell.h
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "COOfferData.h"

@interface COOfferProgressCell : BaseTableViewCell

@property (strong, nonatomic) id<COProjectFundedAmount> projectInfoProgress;

@end