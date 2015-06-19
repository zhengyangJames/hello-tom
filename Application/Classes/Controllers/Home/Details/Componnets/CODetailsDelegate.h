//
//  CODetailsDelegate.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IOS8_OR_ABOVE    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

@protocol CODetailsController;


@interface CODetailsDelegate : NSObject <UITableViewDelegate>

- (instancetype)initWithController:(id<CODetailsController>)controller;

@end

@protocol CODetailsController <NSObject>

@optional
- (instancetype)detailsController:(CODetailsDelegate*)feedController
       didSelectObject:(id)feedObj atIndexPath:(NSIndexPath*)indexPath;

@end