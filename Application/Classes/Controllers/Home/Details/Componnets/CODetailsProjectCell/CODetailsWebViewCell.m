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
    _isFinish = NO;
}

#pragma mark - Set Get
- (void)setCOOfferItemObj:(COOfferItemObj *)cOOfferItemObj {
    _cOOfferItemObj = cOOfferItemObj;
    _titler.text = cOOfferItemObj.title;
    _textViewLoad.attributedText = cOOfferItemObj.htmlDetail;
    if (!_isFinish) {
        [_webView loadHTMLString:cOOfferItemObj.linkOrDetail baseURL:nil];
    }
}


#pragma mark - WebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _isFinish = YES;
    CGRect mWebViewFrame = _webView.frame;
    mWebViewFrame.size.height = _webView.scrollView.contentSize.height;
    _webView.frame = mWebViewFrame;
    self.heightForCell = mWebViewFrame.size.height;
    _textViewLoad.frame = mWebViewFrame;
    self.contentView.bounds = _textViewLoad.bounds;
    [self setNeedsDisplay];
    if ([self.delegate respondsToSelector:@selector(coDetailsWebViewCell:webViewEndLoading:)]) {
        [self.delegate coDetailsWebViewCell:self webViewEndLoading:YES];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:@"<html><center><font size=+3 color='black'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [_webView loadHTMLString:errorString baseURL:nil];
}

@end
