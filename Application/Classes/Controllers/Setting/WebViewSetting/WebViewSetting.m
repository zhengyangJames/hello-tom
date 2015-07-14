//
//  WebViewSetting.m
//  CoAssest
//
//  Created by TUONG DANG on 6/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WebViewSetting.h"
#import "UIWebView+AFNetworking.h"

@interface WebViewSetting () <UIWebViewDelegate>
{
    __weak IBOutlet UIWebView *_webView;
    UIRefreshControl *_refreshControl;
}

@end

@implementation WebViewSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)_setupLeftNavigationButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 48, 32)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(__actionBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ( [_webView isLoading] ) {
        [_webView stopLoading];
    }
    _webView.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = self.titler;
    [self _setupWebView];
}

- (void)_setupWebView {
    NSURL *url = [NSURL URLWithString:self.webLink];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView loadRequest:request];
}

- (void)setIsPresion:(BOOL)isPresion {
    _isPresion = isPresion;
    if (_isPresion) {
        [self _setupLeftNavigationButton];
    }
}

#pragma mark - Action

- (void)__actionBack:(id)sender {
    if (_isPresion) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark Set Get
- (void)setTitler:(NSString *)titler {
    _titler = titler;
}

#pragma mark - Webview Delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
