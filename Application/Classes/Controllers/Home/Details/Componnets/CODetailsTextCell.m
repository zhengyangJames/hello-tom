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
    __weak IBOutlet UILabel     *_headerLabel;
}

@end

@implementation CODetailsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

#pragma mark - Set Get
- (void)setCoOfferItem:(COOfferItemObj *)coOfferItem {
    _coOfferItem = coOfferItem;
    _headerLabel.text = coOfferItem.title;
    if (coOfferItem.htmlDetail) {
        [_detailsTextView setAttributedText:coOfferItem.htmlDetail];
    } else {
        [_detailsTextView setText:coOfferItem.stringDetail];
    }
}

@end
