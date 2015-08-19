//
//  DetailsViewController.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "CODetailsAccessoryCell.h"
#import "CODetailsDelegate.h"
#import "COProgressbarObj.h"
#import "CODetailsWebViewCell.h"
#import "CODetailsProjectBottomTVCell.h"

@class COOfferModel;

@interface DetailsViewController : BaseViewController <CODetailsAccessoryCellDelegate,CODetailsTableViewDelegate,CODetailsProjectBottomTVCellDelegate>
@property (nonatomic, strong) COOfferModel *offerModel;
@end

