//
//  OfferDetailsDocumentController.m
//  CoAssets
//
//  Created by TruongVO07 on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "OfferDetailsDocumentController.h"
#import "COOfferModel.h"
#import "CODocumentModel.h"
#import "CODocumentItemCell.h"
#import "CODocumentSectionCell.h"
#import "WebViewSetting.h"


@interface OfferDetailsDocumentController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UITextView *_tvDOcument;
}
@end

@implementation OfferDetailsDocumentController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:[CODocumentItemCell identifier] bundle:nil]
    forCellReuseIdentifier:[CODocumentItemCell identifier]];
    
    [_tableView registerNib:[UINib nibWithNibName:[CODocumentSectionCell identifier] bundle:nil]
    forCellReuseIdentifier:[CODocumentSectionCell identifier]];
    self.offerModel = self.offerModel;
}

- (void)setOfferModel:(COOfferModel *)offerModel {
    _offerModel = offerModel;
    self.title = [offerModel offerDocumentTitle];
    _tvDOcument.text = [offerModel offerDocumentContent];
    [_tableView reloadData];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.offerModel.arrayDocuments) {
        return self.offerModel.arrayDocuments.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.offerModel.arrayDocuments && self.offerModel.arrayDocuments.count > 0) {
        CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:section];
        if (document.arrayOfItems && document.arrayOfItems.count > 0) {
            return document.arrayOfItems.count + 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self tableView:tableView cellDocumentSectionForRowAtIndexPath:indexPath];
    } else {
        return [self tableView:tableView cellDocumentItemForRowAtIndexPath:indexPath];
    }
}

#pragma mark - Cells
- (CODocumentSectionCell*)tableView:(UITableView *)tableView cellDocumentSectionForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODocumentSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODocumentSectionCell identifier]];
    if (self.offerModel.arrayDocuments && self.offerModel.arrayDocuments.count > 0) {
        CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:indexPath.section];
        cell.docDetail = document;
    }
    return cell;
}

- (CODocumentItemCell*)tableView:(UITableView *)tableView cellDocumentItemForRowAtIndexPath:(NSIndexPath *)indexPath {
    CODocumentItemCell *cell = [tableView dequeueReusableCellWithIdentifier:[CODocumentItemCell identifier]];
    CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:indexPath.section];
    if (document.arrayOfItems && document.arrayOfItems.count > 0) {
        cell.docDetailItem = [document.arrayOfItems objectAtIndex:indexPath.row - 1];
    } else {
        cell.docDetailItem = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return;
    }
    CODocumentModel *document = [self.offerModel.arrayDocuments objectAtIndex:indexPath.section];
     id<CODocumentItem> docDetailItem = [document.arrayOfItems objectAtIndex:indexPath.row - 1];
    WebViewSetting *vc = [[WebViewSetting alloc]init];
    vc.titler = [docDetailItem itemTitle];
    vc.webLink = [docDetailItem itemUrl];
    vc.isPresion = NO;
    [self.navigationController pushViewController:vc animated:YES];
}

@end