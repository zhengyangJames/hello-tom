//
//  NProfileDelegate.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

static const CGFloat kHeightForCellDefaultText = 60;
static const CGFloat kHeightForCellDefaultButton = 75;

@protocol ProfileActionTableViewDelegate;

@interface NProfileDelegate : NSObject <UITableViewDelegate>

- (instancetype)initWithController:(id<ProfileActionTableViewDelegate>)controller;

@end

@protocol ProfileActionTableViewDelegate <NSObject>

@optional
- (void)actionProfileDelegate:(NProfileDelegate*)profileDelegate didSelectedAtIndexPath:(NSIndexPath *)indexPath;



@end