//
//  HomeListViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "UIImage+Scaling.h"
#import "UIImageView+Networking.h"
#import "UIImage+animatedGIF.h"

@implementation HomeListViewCell
{
    __weak IBOutlet UIImageView *_imageBig;
    __weak IBOutlet UIImageView *_imageLogo;
    __weak IBOutlet UILabel *_lblDetail;
    __weak IBOutlet UILabel *_lblSate;
    __weak IBOutlet UIView *_viewImage;
    __weak IBOutlet UIView *_viewImageLogo;
}


- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)viewDidLoad {
    [_imageBig setImage:[UIImage imageNamed:@"ic_placeholder"]];
}

- (void)layoutSubviews {
    [super layoutSubviews];;
    _lblDetail.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    _lblSate.preferredMaxLayoutWidth = CGRectGetWidth(self.frame);
    [_viewImageLogo.layer setCornerRadius:_viewImageLogo.bounds.size.width/2];
    [_viewImageLogo.layer setBorderWidth:0.8];
    [_viewImageLogo.layer setBorderColor:[UIColor grayColor].CGColor];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    _viewImage.layer.shadowColor = [UIColor darkGrayColor].CGColor;
//    _viewImage.layer.masksToBounds = NO;
//    _viewImage.layer.shadowOffset = CGSizeMake(0, 0);
//    _viewImage.layer.shadowRadius = 4;
//    _viewImage.layer.shadowOpacity = 0.6;
}

#pragma mark - Private
- (UIImage*)_loadGifImageLoading {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Preloader_8" withExtension:@"gif"];
    UIImage *imageGif = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    return imageGif;
}

#pragma mark - Set Get

- (void)setObject:(COLIstOffersObject *)object {
    _object = object;
    NSURL *url = [NSURL URLWithString:_object.offerPhoto];
    [_imageBig setImage:[UIImage imageNamed:@"ic_placeholder"]];
    [_imageBig setImageURL:url];
    NSString *strImage = [_object.offerCountry isEqualToString:@"Cambodia"] ? @"Globe" : _object.offerCountry;
    [_imageLogo setImage:[UIImage imageNamed:strImage]];
    [_lblDetail setText:_object.offerTitle];
    [_lblSate setText:_object.offerCountry];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
