//
//  HomeListViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "COOfferModel.h"
#import "COProjectModel.h"

@implementation HomeListViewCell
{
    __weak IBOutlet UIImageView *_imageBig;
    __weak IBOutlet UIImageView *_imageLogo;
    __weak IBOutlet UILabel *_lblTitle;
    __weak IBOutlet UILabel *_lblCountry;
    __weak IBOutlet UIView *_viewImage;
    __weak IBOutlet UIView *_viewImageLogo;
}

- (void)viewDidLoad {
}

- (void)layoutSubviews {
    [super layoutSubviews];;
    _lblTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    _lblCountry.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    [_viewImageLogo.layer setCornerRadius:_viewImageLogo.bounds.size.width/2];
    [_viewImageLogo.layer setBorderWidth:0.8];
    [_viewImageLogo.layer setBorderColor:[UIColor grayColor].CGColor];
    [self setNeedsDisplay];
}

#pragma mark - Set Get

- (void)setOfferobject:(COOfferModel *)offerobject {
    _offerobject = offerobject;
    NSURL *url = [NSURL URLWithString:_offerobject.offerProject.projectPhoto];
    [_imageBig sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_placeholder"]];
    NSString *strImage = [_offerobject.offerProject.projectCountry isEqualToString:@"Cambodia"] ? @"Globe" : _offerobject.offerProject.projectCountry;
    [_imageLogo setImage:[UIImage imageNamed:strImage]];
    [_lblTitle setText:_offerobject.offerTitle];
    [_lblCountry setText:_offerobject.offerProject.projectCountry];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
