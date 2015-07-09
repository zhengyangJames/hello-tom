//
//  CODetailsProjectCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CODetailsOffersObject.h"

typedef NS_ENUM(NSInteger, DetailsProjectStyle) {
    DetailsProjectType,
    DetailsProjectSite
};

typedef NS_ENUM(NSInteger, CODetailsProjectActionButton) {
    CODetailsProjectActionButtonInterested,
    CODetailsProjectActionButtonQuestions
};

@protocol CODetailsProjectTBVCellDelegate;

@interface CODetailsProjectTBVCell : BaseTableViewCell

@property (strong, nonatomic) CODetailsOffersObject *object;
@property (weak, nonatomic) id<CODetailsProjectTBVCellDelegate> delegate;

@end

@protocol  CODetailsProjectTBVCellDelegate<NSObject>

@optional
- (void)actionButtonDetailsProject:(CODetailsProjectActionButton)detailsProjectStyle;

@end