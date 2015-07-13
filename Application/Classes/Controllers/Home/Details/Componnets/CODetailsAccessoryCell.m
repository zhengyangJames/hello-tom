//
//  CODetailsAccessoryCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsAccessoryCell.h"
#import "COOfferItemObj.h"

@implementation CODetailsAccessoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}


#pragma mark - Set Get

- (void)setCoOOfferItemObj:(COOfferItemObj *)coOOfferItemObj {
    _coOOfferItemObj = coOOfferItemObj;
    self.detailsLabel.text = coOOfferItemObj.title;
}

#pragma mark - Action
- (IBAction)__actionTapCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsAccessoryCell:didSelectCell:)]) {
        [self.delegate detailsAccessoryCell:self didSelectCell:nil];
    }
}


@end
