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
#import "CODetailsProjectTBVCell.h"
#import "CODetailsTextCell.h"
#import "CODetailsSectionCell.h"
#import "CODetailsOffersObject.h"

@protocol CODetailsTableViewDelegate;

@interface CODetailsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) CODetailsOffersObject *object;

@property (strong, nonatomic) NSArray *arrObject;

- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectTBVCellDelegate,CODetailsTableViewDelegate>)controller tableView:(UITableView*)tableView ;

//- (CODetailsTextCell*)textCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
//- (CODetailsPhotoCell*)photoCellForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;

@end
