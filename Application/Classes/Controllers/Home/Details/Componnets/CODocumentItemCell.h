//
//  CODetailsAccessoryCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentItemModel.h"

@protocol CODetailsAccessoryCellDelegate;

@interface CODocumentItemCell : UITableViewCell

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate> delegate;
@property (nonatomic, strong) id<CODocumentItem> docDetailItem;

@end

@protocol CODetailsAccessoryCellDelegate <NSObject>

@optional
- (void)showWebsiteWithTitle:(NSString *)title andUrl:(NSString *)url;

@end
