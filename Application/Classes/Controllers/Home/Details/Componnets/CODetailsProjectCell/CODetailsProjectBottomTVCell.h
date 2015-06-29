//
//  CODetailsProjectBottomTVCell.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//
#import "BaseView.h"

typedef NS_ENUM(NSInteger, CODetailsProjectAction) {
    CODetailsProjectActionInterested,
    CODetailsProjectActionQuestions
};

@protocol CODetailsProjectBottomTVCellDelegate;

@interface CODetailsProjectBottomTVCell : BaseView

@property (weak, nonatomic) id<CODetailsProjectBottomTVCellDelegate> delegate;

@end

@protocol CODetailsProjectBottomTVCellDelegate <NSObject>

@optional
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell*)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction;

@end