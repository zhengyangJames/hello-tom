//
//  CODetailsTextCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

@class CODetailsOffersItemObj;
#import "COOfferData.h"

@interface CODetailsTextCell : UITableViewCell
@property (strong, nonatomic) CODetailsOffersItemObj *coOfferItem;
@property (nonatomic, strong) id<COOfferData> data;
@end
