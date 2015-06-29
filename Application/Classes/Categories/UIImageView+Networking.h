//
//  NSArray+Sort.h
//  CoAssets
//
//  Created by TUONG DANG on 6/25/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

// UIImageView Extentions resposipble for downloading the image from remote server.

typedef void (^DownloadCompletionBlock) (BOOL succes, UIImage *image, NSError *error);

@interface UIImageView (Networking)
@property (nonatomic) NSURL *imageURL;
@property (nonatomic) NSString *URLId;

- (void)setImageURL:(NSURL *)imageURL withCompletionBlock:(DownloadCompletionBlock)block placeHolder:(UIImage*)placeHolder;

@end
