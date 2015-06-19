//
//  CODetailsDelegate.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDelegate.h"
#import "CODetailsSectionCell.h"
#import "CODetailsDataSource.h"

@interface CODetailsDelegate ()
{
    
}
@property (nonatomic, weak) id<CODetailsController> controller;


@end

@implementation CODetailsDelegate

- (instancetype)initWithController:(id<CODetailsController>)controller {
    self = [super init];
    if(self) {
        self.controller = controller;
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private

- (CGFloat)_heightForTableView:(UITableView*)tableView contentCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height;
}



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    CODetailsDataSource *dataSource = tableView.dataSource;
    if (indexPath.row == 0) {
        if (IS_IOS8_OR_ABOVE) {
            return UITableViewAutomaticDimension;
        } else {
            id cell = [dataSource photoCellForTableView:tableView indexPath:indexPath];
            height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
        }
    } else if(indexPath.row == 1) {
        return 408;
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 16 ){
        if (IS_IOS8_OR_ABOVE) {
            return  UITableViewAutomaticDimension;
        } else {
            id cell = [dataSource textCellForTableView:tableView indexPath:indexPath];
            height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
        }
    } else if (indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 10) {
        return 44;
    } else if (indexPath.row == 17) {
        return 215;
    } else {
        return 44;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 67;
    } else if(indexPath.row == 1) {
        return 408;
    } else if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 16 ){
        return 84;
    } else if (indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 10) {
        return 44;
    } else if (indexPath.row == 17) {
        return 215;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
