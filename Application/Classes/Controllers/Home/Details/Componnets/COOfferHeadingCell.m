//
//  CODetailsPhotoCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferHeadingCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString_stripHtml.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define kCORNER_RADIUS_IMAGE 6

@interface COOfferHeadingCell ()
{
    __weak IBOutlet UIImageView *_image;
    __weak IBOutlet UITextView  *_detailsTextView;
}

@end

@implementation COOfferHeadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _image.layer.cornerRadius = kCORNER_RADIUS_IMAGE;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _image.layer.cornerRadius = kCORNER_RADIUS_IMAGE;
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

#pragma mark - Set Get

- (void)setOfferLogo:(id<COOfferLogo>)offerLogo {
    _offerLogo = offerLogo;
    _detailsTextView.text = _offerLogo.offerLogoTitle;
    if (_offerLogo.offerLogoImage && ![_offerLogo.offerLogoImage rangeOfString:@"public_media/company.png"].length != 0) {
        NSURL *url = [NSURL URLWithString:_offerLogo.offerLogoImage];
        [_image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"company_edit.jpg"]];
    } else {
        _image.image = [UIImage imageNamed:@"company_edit.jpg"];
    }
}

@end
