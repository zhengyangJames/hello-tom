//
//  HomeListViewCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "COOfferData.h"

@interface HomeListViewCell : BaseTableViewCell

@property (strong, nonatomic) id<COHomeOffer> homeOffer;
@end
