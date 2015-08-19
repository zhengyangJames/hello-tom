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
#import "CODetailsWebViewCell.h"
#import "COOfferModel.h"

@interface CODetailsDelegate ()
{
    
}
@property (nonatomic, weak) id<CODetailsTableViewDelegate> controller;


@end

@implementation CODetailsDelegate

- (instancetype)initWithController:(id<CODetailsTableViewDelegate>)controller {
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
    if (indexPath.section == 0) {
        if(IS_IOS8_OR_ABOVE) {
            return UITableViewAutomaticDimension;
        } else {
            id cell = [dataSource tableView:tableView cellDetailsPhotoForRowAtIndexPath:indexPath];
            height = [self _heightForTableView:tableView contentCell:cell atIndexPath:indexPath];
            return height;
        }
    } else if (indexPath.section == 1) {
        if (self.offerModelProgress.showProgressBar) {
            if (indexPath.row == 0) {
                return height = kHEIGHT_FOR_ROW_DEFAULT_INFO;
            } else if (indexPath.row == 1) {
                return height = kHEIGHT_FOR_ROW_PROGRESS_INFO;
            } else {
                return height = kHEIGHT_FOR_ROW_ACTION_INFO;
            }
        } else {
            if (indexPath.row == 0) {
                return height = kHEIGHT_FOR_ROW_DEFAULT_INFO;
            } else {
                return height = kHEIGHT_FOR_ROW_ACTION_INFO;
            }
        }
    }else if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 11) {
        if(IS_IOS8_OR_ABOVE) {
            return UITableViewAutomaticDimension;
        } else {
            id Cell = [dataSource tableView:tableView cellDetailsTextForRowAtIndexPath:indexPath];
            return height = [self _heightForTableView:tableView contentCell:Cell atIndexPath:indexPath];
        }
    }else if (indexPath.section == 3){
        return dataSource.heightWebview;
    } else {
        if (indexPath.row == 0) {
            return 44;
        } else {
            if(IS_IOS8_OR_ABOVE) {
                return UITableViewAutomaticDimension;
            } else {
                id Cell = [dataSource tableView:tableView cellDetailsAccessoryForRowAtIndexPath:indexPath];
                return height = [self _heightForTableView:tableView contentCell:Cell atIndexPath:indexPath];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    CODetailsDataSource *dataSource = tableView.dataSource;
    if (indexPath.section == 0) {
        return height = 67;
    } else if (indexPath.section == 1) {
        if (self.offerModelProgress.showProgressBar) {
            if (indexPath.row == 0) {
                return height = kHEIGHT_FOR_ROW_DEFAULT_INFO;
            } else if (indexPath.row == 1) {
                return height = kHEIGHT_FOR_ROW_PROGRESS_INFO;
            } else {
                return height = kHEIGHT_FOR_ROW_ACTION_INFO;
            }
        } else {
            if (indexPath.row == 0) {
                return height = kHEIGHT_FOR_ROW_DEFAULT_INFO;
            } else {
                return height = kHEIGHT_FOR_ROW_ACTION_INFO;
            }
        }
    }else if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 5) {
        return height = kHEIGHT_FOR_ROW_TEXT;
    }else if (indexPath.section == 3) {
        return dataSource.heightWebview;
    } else {
        return height = kHEIGHT_FOR_ROW_DEFAULT;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.controller respondsToSelector:@selector(detailsViewController:didSelectedAtIndexPath:)]) {
        [self.controller detailsViewController:self didSelectedAtIndexPath:indexPath];
    }
}

@end
