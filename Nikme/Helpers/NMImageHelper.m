//
//  NMImageHelper.m
//  ToeicTestPro
//
//  Created by Linh NGUYEN on 9/7/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NMImageHelper.h"

@implementation NMImageHelper

+ (CGFloat)getScaleHeight:(UIImage*)image scaleWidth:(CGFloat)scaleWidth
{
    if(!image)
    {
        return 0;
    }
    CGFloat scaleHeight = scaleWidth * image.size.height / image.size.width;
    return scaleHeight;
}

@end
