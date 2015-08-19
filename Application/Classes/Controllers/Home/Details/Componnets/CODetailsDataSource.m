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
    if (self.offerModel.documents) {
        return kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.documents.count;
    }
    return kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kINDEX_SECTION_OFFER_INFO) {
        if (self.offerModelProgress.showProgressBar) {
            return kCOUNT_ROW_FULL_INFO;
        } else {
            return kCOUNT_ROW_NO_PROGRESS;
        }
    } else if ( section > kINDEX_SECTION_DOCUMENT) {
        if (self.offerModel.documents && self.offerModel.documents.count > 0) {
            if (section <= kINDEX_SECTION_DOCUMENT + self.offerModel.documents.count) {
                CODocumentModel *document = [self.offerModel.documents objectAtIndex:section - (kINDEX_SECTION_DOCUMENT+1)];
                if (document.items && document.items.count > 0) {
                    return document.items.count + kDEFAULT_COUNT_OF_ROW;
                } else {
                    return kDEFAULT_NUMBER_ROW_DOC_DETAIL;
                }
            }
        }
    }
    return kDEFAULT_COUNT_OF_ROW;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kINDEX_SECTION_LOGO) {
        return [self tableView:tableView cellDetailsPhotoForRowAtIndexPath:indexPath];
    } else if (indexPath.section == kINDEX_SECTION_OFFER_INFO) {
        if (self.offerModelProgress.showProgressBar) {
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
    }else if (indexPath.section == kINDEX_SECTION_OFFER_DESCRIPTION || indexPath.section == kINDEX_SECTION_DOCUMENT || indexPath.section == kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.documents.count - 1) {
        return [self tableView:tableView cellDetailsTextForRowAtIndexPath:indexPath];
    } else if ( indexPath.section == kINDEX_SECTION_PROJECT_DESCRIPTION) {
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
    cell.offerLogo = self.offerModel;
    return cell;
}

- (CODetailsProjectCell*)tableView:(UITableView *)tableView cellDetailsProjectTBVForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsProjectCell identifier]];
    cell.offerInfo = self.offerModel;
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
    cell.offerInfoProgress = self.offerModelProgress;
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    return cell;
}

- (CODetailsTextCell*)tableView:(UITableView *)tableView cellDetailsTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsTextCell identifier]];
    if(indexPath.section == kINDEX_SECTION_OFFER_DESCRIPTION) {
        cell.offerDescription = self.offerModel;
    } else if (indexPath.section == kINDEX_SECTION_DOCUMENT) {
        cell.offerDocumentInfo = self.offerModel;
    } else if (indexPath.section == kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.documents.count - 1 && self.offerModel.documents && self.offerModel.documents.count > 0) {
        cell.offerAddress = self.offerModel;
    }
    return cell;
}

- (CODetailsWebViewCell*)tableView:(UITableView*)tableView cellDetailsWebViewRowWithIndexPath:(NSIndexPath*)indexPath {
    CODetailsWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsWebViewCell identifier]];
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    cell.offerProject = self.offerModel;
    return cell;
}

- (CODetailsSectionCell*)tableView:(UITableView *)tableView cellDetailsSectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsSectionCell identifier]];
    cell.indexSection = indexPath.section - (kINDEX_SECTION_DOCUMENT +1);
    cell.offerDocDetail  = self.offerModel;
    return cell;
}

- (CODetailsAccessoryCell*)tableView:(UITableView *)tableView cellDetailsAccessoryForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODetailsAccessoryCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODetailsAccessoryCell identifier]];
    cell.indexPath = [self _getIndexPathForAccessoryCell:indexPath];
    cell.offerDocDetail = self.offerModel;
    return cell;
}
#pragma mark - Privace
- (NSIndexPath *)_getIndexPathForAccessoryCell:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section - (kINDEX_SECTION_DOCUMENT +1);
    NSIndexPath *indexPathConverted = [NSIndexPath indexPathForRow:indexPath.row-kDEFAULT_COUNT_OF_ROW inSection:section];
    return indexPathConverted;
}
@end
