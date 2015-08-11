//
//  CODetailsWebViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsWebViewCell.h"
#import "COOfferItemObj.h"

@interface CODetailsWebViewCell ()
{
    BOOL _isFinish;
}

@end

@implementation CODetailsWebViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView.scrollView setScrollEnabled:NO];
    [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [_webView.scrollView setShowsVerticalScrollIndicator:NO];
    
    _isFinish = NO;
    
}

#pragma mark - Set Get
- (void)setCOOfferItemObj:(COOfferItemObj *)cOOfferItemObj {
    _cOOfferItemObj = cOOfferItemObj;
    _titler.text = cOOfferItemObj.title;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,cOOfferItemObj.linkOrDetail];
    DBG(@"%@",formartHTML);
    if (!_isFinish) {
        [_webView loadHTMLString:formartHTML baseURL:nil];
        _isFinish = !_isFinish;
    }
}

@end
