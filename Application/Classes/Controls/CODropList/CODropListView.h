//
//  CODropListView.h
//  CoAssest
//
//  Created by TUONG DANG on 6/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseView.h"

@interface CODropListView : BaseView

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^didSelect)(NSInteger);

+ (void)presentWithTitle:(NSString*)title
                    data:(NSArray*)data
           selectedIndex:(NSInteger)index
               didSelect:(void (^)(NSInteger))didSelect;

@end
