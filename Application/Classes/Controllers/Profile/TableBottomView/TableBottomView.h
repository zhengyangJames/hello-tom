//
//  TableBottomView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"
#define CORNERRADIUS 5.5

@protocol TableBottomViewDelegate;

@interface TableBottomView : BaseView

@property (strong, nonatomic) NSString *lblUpdateButton;
@property (weak, nonatomic) id<TableBottomViewDelegate> delegate;

@end

@protocol TableBottomViewDelegate <NSObject>

- (void)tableBottomView:(TableBottomView*)tableBottomView titlerButton:(NSString*)titlerButton;

@end