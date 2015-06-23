//
//  HomeListViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewCell.h"

@implementation HomeListViewCell
{
    __weak IBOutlet UIImageView *_imageBig;
    __weak IBOutlet UIImageView *_imageLogo;
    __weak IBOutlet UILabel *_lblDetail;
    __weak IBOutlet UILabel *_lblSate;
    __weak IBOutlet UIView *_viewImage;
}


- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];;
    _lblDetail.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    _lblSate.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
//    [_viewImage.layer setCornerRadius:4];

    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _viewImage.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _viewImage.layer.masksToBounds = NO;
//    [_viewImage.layer setCornerRadius:4];
    _viewImage.layer.shadowOffset = CGSizeMake(0, 0);
    _viewImage.layer.shadowRadius = 4;
    _viewImage.layer.shadowOpacity = 0.6;
}

- (void)setObject:(ListHomeObject *)object {
    _object = object;
    [_imageBig setImage:[UIImage imageNamed:_object.imageNameBig]];
    [_imageLogo setImage:[UIImage imageNamed:_object.imageNameLogo]];
    [_lblDetail setText:_object.lableDetail];
    [_lblSate setText:_object.lableSate];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


@end
