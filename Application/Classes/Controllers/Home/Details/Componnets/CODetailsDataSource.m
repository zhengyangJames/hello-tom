//
//  CODetailsDataSource.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDataSource.h"
#import "COOferObj.h"



@interface CODetailsDataSource () <CODetailsProjectCellDelegate>

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate,CODetailsProjectCellDelegate,CODetailsTableViewDelegate> controller;

@end

@implementation CODetailsDataSource


- (instancetype)initWithController:(id<CODetailsProjectCellDelegate,CODetailsAccessoryCellDelegate,CODetailsTableViewDelegate>)controller tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.controller = controller;
        [tableView registerNib:[UINib nibWithNibName:[CODetailsAccessoryCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsAccessoryCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsSectionCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsSectionCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsPhotoCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsPhotoCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsTextCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsTextCell identifier]];
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProjectCell identifier] bundle:nil] forCellReuseIdentifier:[CODetailsProjectCell identifier]];
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private



#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.arrObject count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((section >= 0 && section < 5) || section == self.arrObject.count - 1) {
        return [self _getNumofRowInSection:section];
    } else {
        return [self _getNumofRowInSection:section] + 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self tableView:tableView cellDetailsPhotoForRowAtIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        return [self tableView:tableView cellDetailsProjectTBVForRowAtIndexPath:indexPath];
    }else if (indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4 || indexPath.section == self.arrObject.count - 1) {
        return [self tableView:tableView cellDetailsTextForRowAtIndexPath:indexPath];
    }else {
        if (indexPath.row == 0) {
            return [self tableView:tableView cellDetailsSectionForRowAtIndexPath:indexPath];
        }
        return [self tableView:tableView cellDetailsAccessoryForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - Cells

- (CODetailsPhotoCell*)tableView:(UITableView *)tableView cellDetailsPhotoForRowAtIndexPath:(NSIndexPath *)indexPath  {
    CODetailsPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsPhotoCell identifier]];
    COOferObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOfferObj = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

- (CODetailsAccessoryCell*)tableView:(UITableView *)tableView cellDetailsAccessoryForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsAccessoryCell identifier]];
    COOferObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOOfferItemObj = [obj.offerItemObjs objectAtIndex:indexPath.row - 1];
    return cell;
}

- (CODetailsSectionCell*)tableView:(UITableView *)tableView cellDetailsSectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsSectionCell identifier]];
    COOferObj *obj = [self.arrObject objectAtIndex:indexPath.section];
    cell.titleSection = obj.type;
    return cell;
}

- (CODetailsTextCell*)tableView:(UITableView *)tableView cellDetailsTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsTextCell identifier]];
    COOferObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOfferItem = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

- (CODetailsProjectCell*)tableView:(UITableView *)tableView cellDetailsProjectTBVForRowAtIndexPath:(NSIndexPath *)indexPath {
    COOferObj *obj = [self _getItemAtindexPath:indexPath];
    CODetailsProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectCell identifier]];
    cell.detailsProfile = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Privace

- (NSInteger)_getNumofRowInSection:(NSInteger)section {
    NSInteger num = 0;
    COOferObj *coOfer = [self.arrObject objectAtIndex:section];
    num = coOfer.offerItemObjs.count;
    return num;
}

- (COOferObj *)_getItemAtindexPath:(NSIndexPath *)indexpath {
    COOferObj *obj = [self.arrObject objectAtIndex:indexpath.section];
    return obj;
}


@end
