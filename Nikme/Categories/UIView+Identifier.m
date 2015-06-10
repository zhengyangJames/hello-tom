//
//  UIView+Identifier.m
//  NikmeCamera
//
//  Created by Linh NGUYEN on 10/24/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "UIView+Identifier.h"

@implementation UIView (Identifier)

+ (NSString*)identifier
{
    return NSStringFromClass([self class]);
}

@end
