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
@property (strong, nonatomic) NSArray *arraySection;

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
- (NSArray*)arraySection {
    if (!_arraySection) {
        return _arraySection = @[@"",@"DECLARATION FORM",@"COMPANY REGISTRATION",@"OTHER DOCUMENTS",@""];
    }
    return _arraySection;
}

#pragma mark - Private

- (CGFloat)_heightForTableView:(UITableView*)tableView contentCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height;
}

#pragma mark - UITableViewDelegate

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CODetailsSectionCell *view   = [[CODetailsSectionCell alloc] initWithNibName:[CODetailsSectionCell identifier]];
    UILabel *label = [UILabel autoLayoutView];
    [label setFont:[UIFont fontWithName:@"Raleway-Medium" size:16]];
    [label setTextColor:KGREEN_COLOR];
    [label setText:[_arraySection objectAtIndex:section]];
    [view addSubview:label];
    [label pinToSuperviewEdges:JRTViewPinLeftEdge|JRTViewPinRightEdge inset:16];
    [label pinToSuperviewEdges:JRTViewPinTopEdge|JRTViewPinBottomEdge inset:0];
    [view setBackgroundColor:KGRAY_COLOR];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    CODetailsDataSource *dataSource = tableView.dataSource;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (IS_IOS8_OR_ABOVE) {
                return UITableViewAutomaticDimension;
            } else {
                id cell = [dataSource _photoCellForTableView:tableView indexPath:indexPath];
                return height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
            }
        } else if(indexPath.row == 1) {
            return height = 408;
        } else {
            if (IS_IOS8_OR_ABOVE) {
                return  UITableViewAutomaticDimension;
            } else {
                id cell = [dataSource _textCellForTableView:tableView indexPath:indexPath];
                return height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
            }
        }
    } else if(indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        return height = 44;
    } else {
        if (indexPath.row == 0) {
            if (IS_IOS8_OR_ABOVE) {
                return  UITableViewAutomaticDimension;
            } else {
                id cell = [dataSource _textCellForTableView:tableView indexPath:indexPath];
                return height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
            }
        } else {
            return height = 215;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 44;
    } else if (section == 2) {
        return 44;
    } else if (section == 3) {
        return 44;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return 408;
        } else {
            return 85;
        }
    } else if(indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        return  44;
    } else {
        if (indexPath.row == 0) {
            return 85;
        } else {
            return 215;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

@end
