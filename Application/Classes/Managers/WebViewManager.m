//
//  WebViewManager.m
//  CoAssets
//
//  Created by Macintosh HD on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WebViewManager.h"

@interface WebViewManager () <UIWebViewDelegate>
{
    __weak UIWebView *_webView;
}
@end

@implementation WebViewManager

+ (id)shared {
    static WebViewManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)getHeightWebViewWithStringHtml:(NSString *)stringHtml
                      heightForWebView:(void (^)(CGFloat height))heightForWebView {
    self.heightForWebView = [heightForWebView copy];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
    web.scrollView.scrollEnabled = NO;
    web.hidden = YES;
    [[kAppDelegate window] addSubview:web];
    _webView = web;
    web.delegate = self;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,stringHtml];
    [web loadHTMLString:formartHTML baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGFloat webViewHeight = 0;
        CGRect frame = _webView.frame;
        frame.size.height = 1;
        _webView.frame = frame;
        CGSize fittingSize = [_webView sizeThatFits:CGSizeZero];
        frame.size = fittingSize;
        _webView.frame = frame;
        webViewHeight = fittingSize.height;
    if (self.heightForWebView) {
        self.heightForWebView(webViewHeight);
    }
    [webView removeFromSuperview];
}

@end
