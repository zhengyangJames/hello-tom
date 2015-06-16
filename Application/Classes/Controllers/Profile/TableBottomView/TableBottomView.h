//
//  TableBottomView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"
#define CORNERRADIUS 5.5

typedef void(^ActionButtonUpdate)();

@interface TableBottomView : BaseView

@property (strong, nonatomic) NSString *lblUpdateButton;
@property (copy, nonatomic) ActionButtonUpdate actionButtonUpdate;

@end
