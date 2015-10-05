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
    [_imageCompany sd_setImageWithURL:[NSURL URLWithString:@"http://www.tapchidanong.org/product_images/h/616/chau-tu-na-3289%284%29__92564_zoom.jpg"]];
}

- (void)setCompanyImage:(id<COCompanyImage>)companyImage {
    _companyImage = companyImage;

}

@end
