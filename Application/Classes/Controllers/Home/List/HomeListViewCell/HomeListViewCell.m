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
- (void)setHomeOffer:(id<COHomeOffer>)homeOffer {
    _homeOffer = homeOffer;
    NSURL *url = [NSURL URLWithString:_homeOffer.homeOfferCompanyPhoto];
    [_imageBig sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_placeholder"]];
    NSString *strImage = [_homeOffer.homeOfferCountry isEqualToString:@"Cambodia"] ? @"Globe" : _homeOffer.homeOfferCountry;
    [_imageLogo setImage:[UIImage imageNamed:strImage]];
    [_lblTitle setText:_homeOffer.homeOfferTitle];
    [_lblCountry setText:_homeOffer.homeOfferCountry];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
