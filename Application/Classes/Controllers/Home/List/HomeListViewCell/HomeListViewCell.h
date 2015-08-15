//
//  HomeListViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "COListOffersObject.h"

@class COOfferModel;

@interface HomeListViewCell : BaseTableViewCell

@property (strong, nonatomic) COListOffersObject *object;
@property (strong, nonatomic) COOfferModel *offerobject;

@end
