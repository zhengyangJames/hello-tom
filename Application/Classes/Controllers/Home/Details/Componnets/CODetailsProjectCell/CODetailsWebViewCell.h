//
//  CODetailsWebViewCell.h
//  CoAssets
//
//  Created by TUONG DANG on 7/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTableViewCell.h"

@class COOfferItemObj;

@interface CODetailsWebViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titler;
@property (nonatomic, strong) COOfferItemObj *cOOfferItemObj;

@end