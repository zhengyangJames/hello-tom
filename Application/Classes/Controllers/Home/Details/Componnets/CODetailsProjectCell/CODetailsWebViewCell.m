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
    if (cOOfferItemObj.htmlDetail) {
        [_webView setHidden:YES];
        _textViewLoad.attributedText = cOOfferItemObj.htmlDetail;
        [self setNeedsDisplay];
        [self layoutSubviews];
    } else {
        [_webView setHidden:NO];
        NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,cOOfferItemObj.linkOrDetail];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (!_isFinish) {
                [_webView loadHTMLString:formartHTML baseURL:nil];
            }
        }];
    }
}

#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isFinish = YES;
    CGFloat heightWebview = 0;
    CGRect mWebViewFrame = _webView.frame;
    mWebViewFrame.size.height = _webView.scrollView.contentSize.height;
    _webView.frame = mWebViewFrame;
    heightWebview = mWebViewFrame.size.height;
    self.contentView.bounds = _webView.bounds;
    [self setNeedsDisplay];
    [self layoutSubviews];
    if ([self.delegate respondsToSelector:@selector(coDetailsWebViewCell:heightWebview:)]) {
        [self.delegate coDetailsWebViewCell:self heightWebview:heightWebview];
    }
}

@end
