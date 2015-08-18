//
//  CODetailsDataSource.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDataSource.h"
#import "CODetailsOffersObj.h"
#import "COOfferData.h"
#import "COOfferModel.h"
#import "CODocumentModel.h"

@interface CODetailsDataSource ()

@property (weak, nonatomic) id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate> controller;

@end

@implementation CODetailsDataSource


- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate>)controller tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.controller = controller;
        [tableView registerNib:[UINib nibWithNibName:[CODetailsAccessoryCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsAccessoryCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsSectionCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsSectionCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsPhotoCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsPhotoCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsTextCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsTextCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProjectCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsProjectCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProgressViewCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsProgressViewCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsProjectBottomTVCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsProjectBottomTVCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODetailsWebViewCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODetailsWebViewCell identifier]];
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private



#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   return kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.model.documents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kINDEX_SECTION_LOGO ||section == kINDEX_SECTION_OFFER_DESCRIPTION || section == kINDEX_SECTION_PROJECT_DESCRIPTION || section == kINDEX_SECTION_DOCUMENT || section == kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.model.documents.count - 1) {
        return 1;
    } else if ( section == kINDEX_SECTION_OFFER_INFO) {
        if ([self.progressBarObj.current_funded_amount isKindOfClass:[NSNumber class]]) {
            return kCOUNT_ROW_FULL_INFO;
        } else {
            return kCOUNT_ROW_NO_PROGRESS;
        }
    } else {
        CODocumentModel *document = [self.model.documents objectAtIndex:section - (kINDEX_SECTION_DOCUMENT+1)];
        if (document.items.count > 0) {
            return document.items.count;
        }
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self tableView:tableView cellDetailsPhotoForRowAtIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        if ([self.progressBarObj.current_funded_amount isKindOfClass:[NSNumber class]]) {
            if (indexPath.row == 0) {
                return [self tableView:tableView cellDetailsProjectTBVForRowAtIndexPath:indexPath];
            } else if (indexPath.row == 1) {
                return [self tableView:tableView detailsProgressViewRowAtIndexPath:indexPath];
            } else {
                return [self tableView:tableView detailsProjectBottomTVCellForRowAtIndexPath:indexPath];
            }
        } else {
            if (indexPath.row == 0) {
                return [self tableView:tableView cellDetailsProjectTBVForRowAtIndexPath:indexPath];
            } else {
                return [self tableView:tableView detailsProjectBottomTVCellForRowAtIndexPath:indexPath];
            }
        }
    }else if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == self.arrObject.count - 1) {
        return [self tableView:tableView cellDetailsTextForRowAtIndexPath:indexPath];
    } else if ( indexPath.section == 3) {
        return [self tableView:tableView cellDetailsWebViewRowWithIndexPath:indexPath];
    } else {
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
    CODetailsOffersObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOfferObj = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

- (CODetailsAccessoryCell*)tableView:(UITableView *)tableView cellDetailsAccessoryForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsAccessoryCell identifier]];
    CODetailsOffersObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOOfferItemObj = [obj.offerItemObjs objectAtIndex:indexPath.row - 1];
    return cell;
}

- (CODetailsSectionCell*)tableView:(UITableView *)tableView cellDetailsSectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsSectionCell identifier]];
    CODetailsOffersObj *obj = [self.arrObject objectAtIndex:indexPath.section];
    cell.titleSection = obj.type;
    return cell;
}

- (CODetailsTextCell*)tableView:(UITableView *)tableView cellDetailsTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsTextCell identifier]];
   
    cell.data = self.model;
    CODetailsOffersObj *obj = [self _getItemAtindexPath:indexPath];
    cell.coOfferItem = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

- (CODetailsProjectCell*)tableView:(UITableView *)tableView cellDetailsProjectTBVForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsOffersObj *obj = [self _getItemAtindexPath:indexPath];
    CODetailsProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectCell identifier]];
    cell.detailsProfile = [obj.offerItemObjs objectAtIndex:indexPath.row];
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    return cell;
}

- (CODetailsProjectBottomTVCell*)tableView:(UITableView *)tableView detailsProjectBottomTVCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsProjectBottomTVCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectBottomTVCell identifier]];
    cell.delegate = self.controller;
    return cell;
}

- (CODetailsProgressViewCell*)tableView:(UITableView *)tableView detailsProgressViewRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsProgressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProgressViewCell identifier]];
    cell.obj = self.progressBarObj;
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    return cell;
}

- (CODetailsWebViewCell*)tableView:(UITableView*)tableView cellDetailsWebViewRowWithIndexPath:(NSIndexPath*)indexPath {
    CODetailsWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsWebViewCell identifier]];
    CODetailsOffersObj *obj = [self _getItemAtindexPath:indexPath];
    cell.cOOfferItemObj = [obj.offerItemObjs objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Privace

- (NSInteger)_getNumofRowInSection:(NSInteger)section {
    NSInteger num = 0;
    CODetailsOffersObj *coOfer = [self.arrObject objectAtIndex:section];
    num = coOfer.offerItemObjs.count;
    return num;
}

- (CODetailsOffersObj *)_getItemAtindexPath:(NSIndexPath *)indexpath {
    CODetailsOffersObj *obj = [self.arrObject objectAtIndex:indexpath.section];
    return obj;
}
@end
