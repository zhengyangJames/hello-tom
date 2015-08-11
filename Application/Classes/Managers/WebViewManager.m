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
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 16, [UIScreen mainScreen].bounds.size.height)];
        web.scrollView.scrollEnabled = NO;
        //web.contentMode = UIViewContentModeScaleAspectFill;
        web.hidden = YES;
        web.delegate = self;
        [[kAppDelegate window] addSubview:web];
        _webView = web;
    }
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,stringHtml];
    [_webView loadHTMLString:formartHTML baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect frame = _webView.frame;
    frame.size.height = 1;
    _webView.frame = frame;
    if (self.heightForWebView) {
        self.heightForWebView(webView.scrollView.contentSize.height + 30, webView);
    }
}

@end
