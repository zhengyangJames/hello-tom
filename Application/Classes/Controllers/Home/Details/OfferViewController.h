//
//  DetailsViewController.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "CODocumentItemCell.h"
#import "CODetailsDelegate.h"
#import "COProgressbarObj.h"
#import "COOfferWebViewCell.h"
#import "COOfferActionCell.h"

@class COOfferModel;

@interface OfferViewController : BaseViewController <CODetailsAccessoryCellDelegate,CODetailsTableViewDelegate,CODetailsProjectBottomTVCellDelegate>
@property (nonatomic, strong) COOfferModel *offerModel;
@property (nonatomic, strong) COOfferModel *offerModelProgress;
@end
