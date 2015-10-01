//
//  NProfileDelegate.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileDelegate.h"
#import "NProfileDataSource.h"

@implementation NProfileDelegate

- (id)initWithTableview:(UITableView *)tableview {
    self = [super init];
    if (self) {
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NProfileDataSource *dataSource = (NProfileDataSource *)tableView.dataSource;
    return [dataSource tableview:tableView heightForRowAtIndexPath:indexPath];
}

@end
