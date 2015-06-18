//
//  CODetailsProjectCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CODetailsProjectAction) {
    CODetailsProjectActionInterested,
    CODetailsProjectActionQuestions
};

@protocol CODetailsProjectCellDelegate;

@interface CODetailsProjectCell : UITableViewCell

@property (strong, nonatomic) NSDictionary *object;
@property (weak, nonatomic) id<CODetailsProjectCellDelegate> delegate;

@end

@protocol CODetailsProjectCellDelegate <NSObject>

@optional
- (void)detailsProfileAction:(CODetailsProjectCell*)detailsProfileCell didSelectAction:(CODetailsProjectAction)detailsProjectAction;

@end