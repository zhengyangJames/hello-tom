//
//  CODetailsProjectBottomTVCell.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//
#import "BaseTableViewCell.h"

typedef NS_ENUM(NSInteger, CODetailsProjectAction) {
    CODetailsProjectActionInterested,
    CODetailsProjectActionQuestions
};

@protocol CODetailsProjectBottomTVCellDelegate;

@interface CODetailsProjectBottomTVCell : BaseTableViewCell

@property (weak, nonatomic) id<CODetailsProjectBottomTVCellDelegate> delegate;
@property (strong, nonatomic) NSDictionary *object;


@end

@protocol CODetailsProjectBottomTVCellDelegate <NSObject>

@optional
- (void)detailsProfileAction:(CODetailsProjectBottomTVCell*)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction;

@end