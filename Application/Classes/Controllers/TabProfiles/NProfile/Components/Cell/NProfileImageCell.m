//
//  NProfileImageCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NProfileImageCell ()
{
    __weak IBOutlet UIImageView *_imageCompany;
}

@end


@implementation NProfileImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setCompanyImage:(id<COCompanyImage>)companyImage {
    _companyImage = companyImage;
    [_imageCompany setContentMode:UIViewContentModeScaleAspectFill];
    _imageCompany.translatesAutoresizingMaskIntoConstraints = NO;
    NSURL *url = [NSURL URLWithString:_companyImage.companyImageURL];
    [_imageCompany sd_setImageWithURL:url];
}

@end