//
//  CODetailsDelegate.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IOS8_OR_ABOVE    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

@class COOfferModel;
@protocol CODetailsTableViewDelegate;


@interface CODetailsDelegate : NSObject <UITableViewDelegate>

- (instancetype)initWithController:(id<CODetailsTableViewDelegate>)controller;
@property (strong, nonatomic) COOfferModel *model;
@end

@protocol CODetailsTableViewDelegate <NSObject>

@optional
- (void)detailsViewController:(CODetailsDelegate *)detailViewController didSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end