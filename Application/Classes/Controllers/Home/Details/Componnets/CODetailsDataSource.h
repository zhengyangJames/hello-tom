//
//  CODetailsDataSource.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CODetailsAccessoryCell.h"
#import "CODetailsPhotoCell.h"
#import "CODetailsProjectCell.h"
#import "CODetailsTextCell.h"
#import "CODetailsSectionCell.h"
#import "CODetailsProgressViewCell.h"
#import "CODetailsProjectBottomTVCell.h"
#import "COProgressbarObj.h"
#import "CODetailsWebViewCell.h"

@protocol CODetailsAccessoryCellDelegate;
@protocol CODetailsProjectBottomTVCellDelegate;
@protocol CODetailsWebViewCellDelegate;

@interface CODetailsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrObject;
@property (strong, nonatomic) COProgressbarObj *progressBarObj;
@property (assign, nonatomic) CGFloat heightWebview;

- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate>)controller
                         tableView:(UITableView*)tableView ;

- (CODetailsPhotoCell*)tableView:(UITableView *)tableView cellDetailsPhotoForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CODetailsTextCell*)tableView:(UITableView *)tableView cellDetailsTextForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CODetailsAccessoryCell*)tableView:(UITableView *)tableView cellDetailsAccessoryForRowAtIndexPath:(NSIndexPath *)indexPath ;
- (CODetailsWebViewCell*)tableView:(UITableView*)tableView cellDetailsWebViewRowWithIndexPath:(NSIndexPath*)indexPath;
@end
