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
    __weak UILabel *_lblTitle;
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
    [backButton setTitle:NSLocalizedString(@"BACK_TITLE", nil) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(__actionBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)_setupRightBarButton {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(__actionLoadSF:)];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ( [_webView isLoading] ) {
        [_webView stopLoading];
    }
    _webView.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self _setupTitle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _setupTitle:self.titler];
}

- (void)setWebLink:(NSString *)webLink {
    
    NSURL *url = [NSURL URLWithString:webLink];
    if (url) {
        NSString *scheme = url.scheme;
        if (!scheme) {
            NSString *https = @"https://";
             webLink = [https stringByAppendingString:webLink];
        }
    }
    _webLink = webLink;
}

#pragma mark - Setup
- (void)_setupUI {
    //self.title = self.titler;
    [_webView.scrollView setScrollEnabled:YES];
    [_webView.scrollView setUserInteractionEnabled:YES];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self loadWebView];
    [self _setupRightBarButton];
}

- (void)_setupTitle:(NSString *)title {
    if (title) {
        CGRect rect = CGRectMake(30, 10, CGRectGetWidth([UIScreen mainScreen].bounds) - 60, 24);
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:rect];
        lblTitle.text = title;
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [lblTitle setFont:[UIFont fontWithName:@"Raleway-Regular" size:22]];
        lblTitle.textColor = self.navigationController.navigationBar.tintColor;
        [self.navigationController.navigationBar addSubview:lblTitle];
        _lblTitle = lblTitle;
    } else {
        if (_lblTitle) {
            [_lblTitle removeFromSuperview];
        }
    }
}

- (void)loadWebView {
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

- (void)__actionLoadSF:(id)sender {
    NSURL *url = [NSURL URLWithString:self.webLink];
    [[UIApplication sharedApplication] openURL:url];
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
