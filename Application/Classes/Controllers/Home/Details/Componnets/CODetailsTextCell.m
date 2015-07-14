//
//  CODetailsTextCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsTextCell.h"
#import "COOfferItemObj.h"

@interface CODetailsTextCell () <UIWebViewDelegate>
{
    __weak IBOutlet UITextView  *_detailsTextView;
    __weak IBOutlet UIWebView *_webView;
    __weak IBOutlet UILabel     *_headerLabel;
}

@end

@implementation CODetailsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _webView.scrollView.scrollEnabled = NO;
    
}

#pragma mark - Set Get
- (void)setCoOfferItem:(COOfferItemObj *)coOfferItem {
    _coOfferItem = coOfferItem;
    _headerLabel.text = coOfferItem.title;
    [_detailsTextView setText:coOfferItem.linkOrDetail];
    NSString *htmlSource = [NSString stringWithFormat:DEFINE_HTML_FRAME,coOfferItem.linkOrDetail];
    [_webView loadHTMLString:htmlSource baseURL:nil];
//    if ([self _showTextViewWithItem:coOfferItem]) {
//         _detailsTextView.text = coOfferItem.linkOrDetail;
//    } else {
//        [_detailsTextView setText:coOfferItem.linkOrDetail];
//        NSString *htmlSource = [NSString stringWithFormat:DEFINE_HTML_FRAME,coOfferItem.linkOrDetail];
//        [_webView loadHTMLString:htmlSource baseURL:nil];
//    }
}

- (BOOL)_showTextViewWithItem:(COOfferItemObj *)coOfferItem {
    if (coOfferItem.linkOrDetail && ![coOfferItem.linkOrDetail isEmpty] && coOfferItem.htmlDetail) {
        _webView.hidden = NO;
        _detailsTextView.hidden = YES;
        return NO;
    } else {
        _webView.hidden = YES;
        _detailsTextView.hidden = NO;
        return YES;
    }
}

@end
