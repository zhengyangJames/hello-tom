//
//  TableHeaderView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

typedef void(^ActionPickerImageProfile)();

@protocol TableHeaderViewDelegate ;

@interface TableHeaderView : BaseView

@property (weak, nonatomic) id<TableHeaderViewDelegate> delegate;
@property (copy, nonatomic) ActionPickerImageProfile actionPickerImageProfile;
@property (strong, nonatomic) IBOutlet UIImageView *imageProfile;

@end

@protocol TableHeaderViewDelegate <NSObject>

@optional
- (void)tableHeaderView:(TableHeaderView*)tableHeaderView indexSelectSegment:(NSInteger)indexSelect;

@end