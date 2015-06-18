//
//  CODetailsDelegate.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDelegate.h"

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

    return height;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if([self.controller respondsToSelector:@selector(feedController:didSelectObject:atIndexPath:)]) {
//        ALNewsFeedDataSource *dataSource = tableView.dataSource;
//        NewsFeedObj *feedObj = [dataSource newsFeedObjectAtSection:indexPath.section];
//        [self.controller feedController:self didSelectObject:feedObj atIndexPath:indexPath];
//    }
}

@end
