//
//  TableHeaderView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

typedef void(^ActionSegment)(NSInteger indexSelectSegment);
typedef void(^ActionPickerImageProfile)();

@interface TableHeaderView : BaseView

@property (copy, nonatomic) ActionSegment actionSegment;
@property (copy, nonatomic) ActionPickerImageProfile actionPickerImageProfile;
@property (strong, nonatomic) IBOutlet UIImageView *imageProfile;

@end
