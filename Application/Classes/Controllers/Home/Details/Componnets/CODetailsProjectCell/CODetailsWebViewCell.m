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
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,cOOfferItemObj.linkOrDetail];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (!_isFinish) {
            [_webView loadHTMLString:formartHTML baseURL:nil];
        }
    }];
    
}

#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isFinish = YES;
    
//    CGFloat webViewHeight = 0;
//    CGRect frame = webView.frame;
//    frame.size.height = 1;
//    webView.frame = frame;
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    webView.frame = frame;
//    webViewHeight = fittingSize.height;
    
    CGFloat heightWebview = 0;
    CGRect mWebViewFrame = webView.frame;
    mWebViewFrame.size.height = webView.scrollView.contentSize.height;
    webView.frame = mWebViewFrame;
    heightWebview = mWebViewFrame.size.height;
    
    _textViewLoad.bounds = webView.bounds;
    self.contentView.bounds = webView.bounds;
    [self setNeedsDisplay];
    [self layoutSubviews];
    if ([self.delegate respondsToSelector:@selector(coDetailsWebViewCell:heightWebview:)]) {
        [self.delegate coDetailsWebViewCell:self heightWebview:heightWebview];
    }
}

@end
