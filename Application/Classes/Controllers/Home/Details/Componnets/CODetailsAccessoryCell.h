//
//  CODetailsAccessoryCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CODetailsOffersItemObj;

@protocol CODetailsAccessoryCellDelegate;

@interface CODetailsAccessoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel  *detailsLabel;
@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate> delegate;

@property (nonatomic, strong) CODetailsOffersItemObj *coOOfferItemObj;

@end

@protocol CODetailsAccessoryCellDelegate <NSObject>

@optional
- (void)detailsAccessoryCell:(CODetailsAccessoryCell*)detailsAccessoryCell
               didSelectCell:(id) detailsAccessoryCellAction;

@end
