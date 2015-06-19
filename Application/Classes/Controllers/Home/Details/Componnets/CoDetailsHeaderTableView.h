//
//  CoDetailsHeaderTableView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

typedef void(^ActionPopView)();

@interface CoDetailsHeaderTableView : BaseView

@property (copy, nonatomic) ActionPopView actionPopView;

@end
