//
//  WebViewManager.m
//  CoAssets
//
//  Created by Macintosh HD on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WebViewManager.h"

@interface WebViewManager () <UIWebViewDelegate>

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
    
    UIWebView *web = [[UIWebView alloc] init];
    web.scrollView.scrollEnabled = NO;
    web.translatesAutoresizingMaskIntoConstraints = NO;
    web.hidden = YES;
    [[kAppDelegate window] addSubview:web];
    [web pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    web.delegate = self;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME_WEBVIEW,stringHtml];
    [web loadHTMLString:formartHTML baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGFloat webViewHeight = 0;
//    CGRect frame = webView.frame;
//    frame.size.height = 1;
//    webView.frame = frame;
//    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
//    frame.size = fittingSize;
//    webView.frame = frame;
//    webViewHeight = fittingSize.height;
    
    CGRect mWebViewFrame = webView.frame;
    mWebViewFrame.size.height = webView.scrollView.contentSize.height;
    webView.frame = mWebViewFrame;
    webViewHeight = webView.frame.size.height + 230;
    if (self.heightForWebView) {
        self.heightForWebView(webViewHeight);
    }
    [webView removeFromSuperview];
}

@end
