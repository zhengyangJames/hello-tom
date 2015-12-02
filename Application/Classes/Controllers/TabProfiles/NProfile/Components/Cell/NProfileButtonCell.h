//
//  NprofileButtonCell.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol profileButtonCellDelegate;

@interface NProfileButtonCell : UITableViewCell

@property (nonatomic, assign) NSInteger actionStyle;
@property (weak, nonatomic) id<profileButtonCellDelegate> delegate;

@end

@protocol profileButtonCellDelegate <NSObject> 

@optional
- (void)acctionButtonProfileCell:(NProfileButtonCell*)profileButtonCell buttonStyle:(NProfileActionStyle)buttonStyle;

@end

