//
//  CODetailsProjectCell.h
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CODetailsProfileObj.h"

typedef NS_ENUM(NSInteger, CODetailsProjectAction) {
    CODetailsProjectActionInterested,
    CODetailsProjectActionQuestions
};

@protocol CODetailsProjectCellDelegate;

@interface CODetailsProjectCell : BaseTableViewCell

@property (weak, nonatomic) id<CODetailsProjectCellDelegate> delegate;

@property (weak, nonatomic) CODetailsProfileObj *detailsProfile;

@end

@protocol CODetailsProjectCellDelegate <NSObject>

@optional
- (void)detailsProfileAction:(CODetailsProjectCell*)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction;

@end