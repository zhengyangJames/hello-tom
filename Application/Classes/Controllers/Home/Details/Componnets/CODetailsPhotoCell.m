//
//  CODetailsPhotoCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsPhotoCell.h"

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.layer.cornerRadius = kCORNER_RADIUS_IMAGE;
    [self setNeedsDisplay];
}

#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
}

@end
