//
//  TableBottomViewCell.h
//  CoAssets
//
//  Created by TUONG DANG on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"

@protocol TableBottomViewCellDelegate;

@interface TableBottomViewCell : BaseTableViewCell

@property (strong, nonatomic) NSString *lblUpdateButton;
@property (weak, nonatomic) id<TableBottomViewCellDelegate> delegate;

@end

@protocol TableBottomViewCellDelegate <NSObject>

- (void)tableBottomView:(TableBottomViewCell*)tableBottomView titlerButton:(NSString*)titlerButton;

@end