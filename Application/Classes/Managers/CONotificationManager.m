//
//  CONotificationManager.m
//  CoAssets
//
//  Created by Tony Tuong on 10/20/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CONotificationManager.h"

@implementation CONotificationManager

+ (CONotificationManager *)shared {
    static CONotificationManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
