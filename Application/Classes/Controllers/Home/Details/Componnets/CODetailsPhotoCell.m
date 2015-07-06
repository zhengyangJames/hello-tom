//
//  CODetailsPhotoCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsPhotoCell.h"
#import "UIImageView+Networking.h"
#import "NSString_stripHtml.h"

#define kCORNER_RADIUS_IMAGE 6

@interface CODetailsPhotoCell ()
{
    __weak IBOutlet UIImageView *_image;
    __weak IBOutlet UITextView  *_detailsTextView;
}

@end

@implementation CODetailsPhotoCell

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
- (void)setObject:(NSDictionary *)object {
    _object = object;
    _detailsTextView.text = [[object valueForKeyNotNull:@"details"] stringByStrippingHTML];
    NSURL *url = [NSURL URLWithString:[object valueForKeyNotNull:@"images"]];
    [_image setImage:[UIImage imageNamed:@"ic_placeholder"]];
    [_image setImageURL:url];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
