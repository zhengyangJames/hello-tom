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
                      heightForWebView:(void (^)(CGFloat height, UIWebView * webView))heightForWebView {
    self.heightForWebView = [heightForWebView copy];
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 32, [UIScreen mainScreen].bounds.size.height)];
        web.scrollView.scrollEnabled = NO;
        web.paginationBreakingMode = UIWebPaginationBreakingModePage;
        web.paginationMode = UIWebPaginationModeTopToBottom;
        web.contentMode = UIViewContentModeScaleAspectFill;
        web.clipsToBounds = YES;
        web.hidden = YES;
        web.delegate = self;
        [[kAppDelegate window] addSubview:web];
        _webView = web;
    }
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,stringHtml];
    [_webView loadHTMLString:formartHTML baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    CGFloat webViewHeight = 0;
        CGRect frame = webView.frame;
        frame.size.height = 1;
        webView.frame = frame;
        CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
        frame.size = fittingSize;
        webView.frame = frame;
        webViewHeight = fittingSize.height + 30;
    if (self.heightForWebView) {
        self.heightForWebView(webViewHeight, webView);
    }
}

@end
