//
//  CODetailsAccessoryCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferData.h"

@protocol CODetailsAccessoryCellDelegate;

@interface CODetailsAccessoryCell : UITableViewCell

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate> delegate;
@property (nonatomic, strong) id<COOfferDocumentDetail> offerDocDetail;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@protocol CODetailsAccessoryCellDelegate <NSObject>

@optional
- (void)detailsAccessoryCell:(CODetailsAccessoryCell*)detailsAccessoryCell
               didSelectCell:(id) detailsAccessoryCellAction;

@end
