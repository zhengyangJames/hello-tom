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
    [self.layer setBorderColor:KLIGHT_GRAY_COLOR.CGColor];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self setImage:[UIImage imageNamed:@"ic_droplist"] forState:UIControlStateNormal];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    frame.origin.x = self.frame.size.width -20;
    frame.size.height = frame.size.height;
    frame.size.width = frame.size.width;
    return frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = 10;
    frame.origin.y = 0;
    frame.size.height = CGRectGetHeight(contentRect);
    frame.size.width = CGRectGetWidth(contentRect);
    return frame;
}

@end
