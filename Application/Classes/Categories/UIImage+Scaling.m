//
//  UIImage+Scaling.m
//  CoAssets
//
//  Created by TUONG DANG on 6/25/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "UIImage+Scaling.h"

@implementation UIImage (Scaling)

+ (void)beginImageContextWithSize:(CGSize)size {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        CGFloat resolution = IS_IPHONE_6PLUS ? 3.0 : 2.0;
        if ([[UIScreen mainScreen] scale] == resolution) {
            UIGraphicsBeginImageContextWithOptions(size, YES, resolution);
        } else {
            UIGraphicsBeginImageContext(size);
        }
    } else {
        UIGraphicsBeginImageContext(size);
    }
}

+ (UIImage*)autoImageNamed:(NSString*)name {
    NSString *fixedName = name;
    NSArray *array = [name componentsSeparatedByString:@"."];
    if(array.count > 1) {
        fixedName = array[0];
    }
    if(IS_IPHONE_6PLUS) {
        name = [name stringByAppendingString:@"-736h"];
    } else if(IS_IPHONE_6) {
        name = [name stringByAppendingString:@"-667h"];
    } else if(IS_IPHONE_5) {
        name = [name stringByAppendingString:@"-568h"];
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
    BOOL isDirectory = NO;
    if(!url || ![kFileManager fileExistsAtPath:url.path isDirectory:&isDirectory] || isDirectory) {
        fixedName = name;
    }
    return [UIImage imageNamed:fixedName];
}

+ (void)endImageContext {
    UIGraphicsEndImageContext();
}

+ (UIImage*)imageFromView:(UIView*)view {
    [self beginImageContextWithSize:[view bounds].size];
    BOOL hidden = [view isHidden];
    [view setHidden:NO];
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    [view setHidden:hidden];
    return image;
}

+ (UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize {
    UIImage *image = [self imageFromView:view];
    if ([view bounds].size.width != newSize.width ||
        [view bounds].size.height != newSize.height) {
        image = [self imageWithImage:image scaledToSize:newSize];
    }
    return image;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    [self beginImageContextWithSize:newSize];
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    [self endImageContext];
    return newImage;
}

+ (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
