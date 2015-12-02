//
//  NProfileDelegate.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileDelegate.h"
#import "NProfileDataSource.h"

@interface NProfileDelegate ()

@end

@implementation NProfileDelegate

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_HEIGHT_CELL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NProfileDataSource *dataSource = (NProfileDataSource *)tableView.dataSource;
    return [dataSource tableview:tableView heightForRowAtIndexPath:indexPath];
}

@end
