//
//  UIImage+Scaling.h
//  CoAssets
//
//  Created by TUONG DANG on 6/25/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scaling)

+ (UIImage*)imageFromView:(UIView*)view;
+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIImage*)autoImageNamed:(NSString*)name;
+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize;

@end
