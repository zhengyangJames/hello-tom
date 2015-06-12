//
//  CoDropListButtom.m
//  CoAssest
//
//  Created by TUONG DANG on 6/12/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CoDropListButtom.h"

@implementation CoDropListButtom

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer setBorderWidth:BORDER];
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
}

//- (void)setImageName:(NSString *)imageName {
//    _imageName = imageName;
//    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) {
//        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 10.0f)];
//    } else {
////        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 0.0f)];
//        [self setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 100.0f, 0.0f, 0.0f)];
//    }
//    UIImageView *ic = [UIImageView autoLayoutView];
//    ic.image = [UIImage imageNamed:imageName];
//    ic.contentMode = UIViewContentModeCenter;
//    [self addSubview:ic];
//    [ic constrainToHeight:12];
//    [ic constrainToWidth:12];
//    [ic pinAttribute:NSLayoutAttributeCenterY toAttribute:NSLayoutAttributeCenterY ofItem:self];
//    [ic pinToSuperviewEdges:JRTViewPinLeftEdge inset:23];
//}


@end
