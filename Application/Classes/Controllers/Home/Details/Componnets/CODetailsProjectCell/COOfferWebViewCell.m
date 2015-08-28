//
//  CODetailsWebViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferWebViewCell.h"

@interface COOfferWebViewCell ()
{
    __weak IBOutlet UIWebView   *webView;
    __weak IBOutlet UILabel     *title;
    BOOL _isFinish;
}

@end

@implementation COOfferWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [webView.scrollView setScrollEnabled:NO];
    [webView.scrollView setShowsHorizontalScrollIndicator:NO];
    [webView.scrollView setShowsVerticalScrollIndicator:NO];
    [webView            setOpaque:NO];
    [webView            setBackgroundColor:[UIColor clearColor]];
    _isFinish = NO;
    
}

#pragma mark - Set Get

- (void)setOfferProject:(id<COOfferProject>)offerProject {
    _offerProject = offerProject;
    title.text = _offerProject.offerProjectTitle;
    NSString *formartHTML = [NSString stringWithFormat:DEFINE_HTML_FRAME,_offerProject.offerProjectContent];
    if (!_isFinish) {
        [webView loadHTMLString:formartHTML baseURL:nil];
        _isFinish = !_isFinish;
    }
}

@end
