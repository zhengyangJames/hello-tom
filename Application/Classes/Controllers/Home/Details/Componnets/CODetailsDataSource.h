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

@protocol CODetailsAccessoryCellDelegate;
@protocol CODetailsProjectCellDelegate;

@interface CODetailsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *object;

- (instancetype)initWithController:(id<CODetailsProjectCellDelegate,CODetailsAccessoryCellDelegate>)controller tableView:(UITableView*)tableView ;

- (CODetailsTextCell*)textCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
- (CODetailsPhotoCell*)photoCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end
