//
//  CODetailsWebViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsWebViewCell.h"

@interface CODetailsWebViewCell () <UIWebViewDelegate>
{
    BOOL _isFinish;
    
}

@end

@implementation CODetailsWebViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView.delegate = self;
    [_webView.scrollView setScrollEnabled:NO];
    [_webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [_webView.scrollView setShowsVerticalScrollIndicator:NO];
    _isFinish = NO;
}

#pragma mark - Set Get
- (void)setCOOfferItemObj:(COOfferItemObj *)cOOfferItemObj {
    _cOOfferItemObj = cOOfferItemObj;
    _titler.text = cOOfferItemObj.title;
    _textViewLoad.attributedText = cOOfferItemObj.htmlDetail;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (!_isFinish) {
            [_webView loadHTMLString:cOOfferItemObj.linkOrDetail baseURL:nil];
        }
    }];
}


#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isFinish = YES;
    CGRect mWebViewFrame = _webView.frame;
    mWebViewFrame.size.height = _webView.scrollView.contentSize.height + 140;
    _webView.frame = mWebViewFrame;
    _textViewLoad.frame = mWebViewFrame;
    self.contentView.bounds = _textViewLoad.bounds;
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    if ([self.delegate respondsToSelector:@selector(coDetailsWebViewCell:webViewEndLoading:)]) {
        [self.delegate coDetailsWebViewCell:self webViewEndLoading:YES];
    }
}

@end
