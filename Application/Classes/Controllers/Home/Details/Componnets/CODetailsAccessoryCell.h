//
//  CODetailsAccessoryCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CODetailsAccessoryCellDelegate;

@interface CODetailsAccessoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel  *detailsLabel;
@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate> delegate;
@property (strong, nonatomic) NSString *object;

@end

@protocol CODetailsAccessoryCellDelegate <NSObject>

@optional
- (void)detailsAccessoryCell:(CODetailsAccessoryCell*)detailsAccessoryCell
               didSelectCell:(id) detailsAccessoryCellAction;

@end
