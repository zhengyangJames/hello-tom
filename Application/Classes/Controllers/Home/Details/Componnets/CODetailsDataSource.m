//
//  CODetailsDataSource.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsDataSource.h"
#import "COOfferData.h"
#import "COOfferModel.h"
#import "CODocumentModel.h"
#import "COProjectModel.h"
#import "COProjectFundedAmountModel.h"
#import "CODocumentItemCell.h"
#import "COOfferHeadingCell.h"
#import "COOfferInfoCell.h"
#import "COOfferDescriptionTextCell.h"
#import "CODocumentSectionCell.h"
#import "COOfferProgressCell.h"
#import "COOfferActionCell.h"
#import "COOfferWebViewCell.h"

@interface CODetailsDataSource ()<CODetailsAccessoryCellDelegate>

@property (weak, nonatomic)     id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate> controller;
@property (assign, nonatomic)   id<COOfferDocumentDetail> docDetail;
@end

@implementation CODetailsDataSource


- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate>)controller tableView:(UITableView *)tableView {
    self = [super init];
    if (self) {
        self.controller = controller;
        [tableView registerNib:[UINib nibWithNibName:[CODocumentItemCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODocumentItemCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[CODocumentSectionCell identifier] bundle:nil]
        forCellReuseIdentifier:[CODocumentSectionCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferHeadingCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferHeadingCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferDescriptionTextCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferDescriptionTextCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferInfoCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferInfoCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferProgressCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferProgressCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferActionCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferActionCell identifier]];
        
        [tableView registerNib:[UINib nibWithNibName:[COOfferWebViewCell identifier] bundle:nil]
        forCellReuseIdentifier:[COOfferWebViewCell identifier]];
    }
    return self;
}

#pragma mark - Set get


#pragma mark - Private



#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.offerModel.arrayDocuments) {
        return kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.arrayDocuments.count;
    }
    return kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == kINDEX_SECTION_OFFER_INFO) {
        if (self.offerModel.offerProject.projectFundedAmount.showProgressBar) {
            return kCOUNT_ROW_FULL_INFO;
        } else {
            return kCOUNT_ROW_NO_PROGRESS;
        }
    } else if ( section > kINDEX_SECTION_DOCUMENT) {
        if (self.offerModel.arrayDocuments && self.offerModel.arrayDocuments.count > 0) {
            if (section <= kINDEX_SECTION_DOCUMENT + self.offerModel.arrayDocuments.count) {
                CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:section - (kINDEX_SECTION_DOCUMENT+1)];
                if (document.arrayOfItems && document.arrayOfItems.count > 0) {
                    return document.arrayOfItems.count + kDEFAULT_COUNT_OF_ROW;
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
        return [self tableView:tableView cellOfferHeadingForRowAtIndexPath:indexPath];
    } else if (indexPath.section == kINDEX_SECTION_OFFER_INFO) {
        if (self.offerModel.offerProject.projectFundedAmount.showProgressBar) {
            if (indexPath.row == 0) {
                return [self tableView:tableView cellOfferInfoForRowAtIndexPath:indexPath];
            } else if (indexPath.row == 1) {
                return [self tableView:tableView cellOfferProgressRowAtIndexPath:indexPath];
            } else {
                return [self tableView:tableView cellOfferActionForRowAtIndexPath:indexPath];
            }
        } else {
            if (indexPath.row == 0) {
                return [self tableView:tableView cellOfferInfoForRowAtIndexPath:indexPath];
            } else {
                return [self tableView:tableView cellOfferActionForRowAtIndexPath:indexPath];
            }
        }
    }else if (indexPath.section == kINDEX_SECTION_OFFER_DESCRIPTION || indexPath.section == kINDEX_SECTION_DOCUMENT || indexPath.section == kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.arrayDocuments.count - 1) {
        return [self tableView:tableView cellOfferTextForRowAtIndexPath:indexPath];
    } else if ( indexPath.section == kINDEX_SECTION_PROJECT_DESCRIPTION) {
        return [self tableView:tableView cellOfferWebViewRowWithIndexPath:indexPath];
    } else {
        if (indexPath.row == 0) {
            return [self tableView:tableView cellDocumentSectionForRowAtIndexPath:indexPath];
        }
        return [self tableView:tableView cellDocumentItemForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - Cells

- (COOfferHeadingCell*)tableView:(UITableView *)tableView cellOfferHeadingForRowAtIndexPath:(NSIndexPath *)indexPath{
    COOfferHeadingCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferHeadingCell identifier]];
    cell.offerLogo = self.offerModel;
    return cell;
}

- (COOfferInfoCell*)tableView:(UITableView *)tableView cellOfferInfoForRowAtIndexPath:(NSIndexPath *)indexPath {
    COOfferInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferInfoCell identifier]];
    cell.offerInfo = self.offerModel;
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    return cell;
}

- (COOfferActionCell*)tableView:(UITableView *)tableView cellOfferActionForRowAtIndexPath:(NSIndexPath *)indexPath {
    COOfferActionCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferActionCell identifier]];
    cell.delegate = self.controller;
    return cell;
}

- (COOfferProgressCell*)tableView:(UITableView *)tableView cellOfferProgressRowAtIndexPath:(NSIndexPath *)indexPath {
    COOfferProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferProgressCell identifier]];
    cell.projectInfoProgress = self.offerModel.offerProject.projectFundedAmount;
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    return cell;
}

- (COOfferDescriptionTextCell*)tableView:(UITableView *)tableView cellOfferTextForRowAtIndexPath:(NSIndexPath *)indexPath {
    COOfferDescriptionTextCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferDescriptionTextCell identifier]];
    if(indexPath.section == kINDEX_SECTION_OFFER_DESCRIPTION) {
        cell.offerDescription = self.offerModel;
    } else if (indexPath.section == kINDEX_SECTION_DOCUMENT) {
        cell.offerDocumentInfo = self.offerModel;
    } else if (indexPath.section == kDEFAULT_COUNT_OF_SECTION_OFFER_MODEL + self.offerModel.arrayDocuments.count - 1 && self.offerModel.arrayDocuments && self.offerModel.arrayDocuments.count > 0) {
        cell.offerAddress = self.offerModel.offerProject;
    }
    return cell;
}

- (COOfferWebViewCell*)tableView:(UITableView*)tableView cellOfferWebViewRowWithIndexPath:(NSIndexPath*)indexPath {
    COOfferWebViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[COOfferWebViewCell identifier]];
    cell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    cell.offerProject = self.offerModel;
    return cell;
}

- (CODocumentSectionCell*)tableView:(UITableView *)tableView cellDocumentSectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODocumentSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODocumentSectionCell identifier]];
    if (self.offerModel.arrayDocuments && self.offerModel.arrayDocuments.count > 0) {
        CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:indexPath.section - (kINDEX_SECTION_DOCUMENT +1)];
        cell.docDetail = document;
    }
    return cell;
}

- (CODocumentItemCell*)tableView:(UITableView *)tableView cellDocumentItemForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODocumentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODocumentItemCell identifier]];
    if (self.offerModel.documents && self.offerModel.arrayDocuments.count > 0) {
        CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:indexPath.section - (kINDEX_SECTION_DOCUMENT +1)];
        if (document && document.arrayOfItems.count > 0) {
            cell.docDetailItem = [document.arrayOfItems objectAtIndex:indexPath.row - kDEFAULT_COUNT_OF_ROW];
        } else {
            cell.docDetailItem = nil;
        }
    }
    cell.delegate =self;
    return cell;
}
#pragma mark - Privace
- (void)showWebsiteWithTitle:(NSString *)title andUrl:(NSString *)url{
    if ([self.delegate respondsToSelector:@selector(showWebSiteAtDetailVCWithTitle:andURl:)]) {
        [self.delegate showWebSiteAtDetailVCWithTitle:title andURl:url];
    }
}
@end
