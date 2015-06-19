//
//  ContactTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ContactTableViewCell.h"

@interface ContactTableViewCell ()
{
    __weak IBOutlet UILabel *lblCoAssets;
    __weak IBOutlet UILabel *lblReg;
    __weak IBOutlet UILabel *lblAdress;
    __weak IBOutlet UILabel *lblTell;
}
@end

@implementation ContactTableViewCell

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];;
    lblTell.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    lblAdress.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
}

- (void)setContactObj:(ContactObject *)contactObj {
    _contactObj = contactObj;
    lblCoAssets.text = _contactObj.lblCoAssets;
    lblReg.text = _contactObj.lblReg;
    lblAdress.text = _contactObj.lblAdress;
    if ([_contactObj.lblTell isEqual:nil]) {
        [lblTell setNeedsUpdateConstraints];
        [lblTell setNeedsDisplay];
    }else {
        lblTell.text = _contactObj.lblTell;
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


@end

