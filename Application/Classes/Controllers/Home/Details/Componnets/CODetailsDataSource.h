//
//  CODetailsDataSource.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CODetailsAccessoryCell.h"
#import "CODetailsMapCell.h"
#import "CODetailsPhotoCell.h"
#import "CODetailsProjectCell.h"
#import "CODetailsTextCell.h"
#import "CODetailsSectionCell.h"
#import "CODetailsOffersObject.h"

@protocol CODetailsTableViewDelegate;

@interface CODetailsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrObject;

- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectCellDelegate,CODetailsTableViewDelegate>)controller tableView:(UITableView*)tableView ;

- (CODetailsPhotoCell*)tableView:(UITableView *)tableView cellDetailsPhotoForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CODetailsTextCell*)tableView:(UITableView *)tableView cellDetailsTextForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CODetailsAccessoryCell*)tableView:(UITableView *)tableView cellDetailsAccessoryForRowAtIndexPath:(NSIndexPath *)indexPath ;

@end
