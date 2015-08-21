//
//  CODetailsDataSource.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CODocumentItemCell.h"
#import "COOfferHeadingCell.h"
#import "COOfferInfoCell.h"
#import "COOfferDescriptionTextCell.h"
#import "CODocumentSectionCell.h"
#import "COOfferProgressCell.h"
#import "COOfferActionCell.h"
#import "COProgressbarObj.h"
#import "COOfferWebViewCell.h"

@protocol CODetailsAccessoryCellDelegate;
@protocol CODetailsProjectBottomTVCellDelegate;
@protocol CODetailsWebViewCellDelegate;
@protocol DetailsDataSourceViewDelegate;
@class COOfferModel;

@interface CODetailsDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) COOfferModel *offerModel;
@property (assign, nonatomic) CGFloat heightWebview;

- (instancetype)initWithController:(id<CODetailsAccessoryCellDelegate,CODetailsProjectBottomTVCellDelegate>)controller
                         tableView:(UITableView*)tableView ;

- (COOfferHeadingCell*)tableView:(UITableView *)tableView cellOfferHeadingForRowAtIndexPath:(NSIndexPath *)indexPath;
- (COOfferDescriptionTextCell*)tableView:(UITableView *)tableView cellOfferTextForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CODocumentItemCell*)tableView:(UITableView *)tableView cellDocumentItemForRowAtIndexPath:(NSIndexPath *)indexPath ;
- (COOfferWebViewCell*)tableView:(UITableView*)tableView cellOfferWebViewRowWithIndexPath:(NSIndexPath*)indexPath;
@property (nonatomic, strong) id<DetailsDataSourceViewDelegate>delegate;
@end

@protocol DetailsDataSourceViewDelegate <NSObject>

- (void)showWebSiteAtDetailVCWithTitle:(NSString *)title andURl:(NSString *)url;

@end
