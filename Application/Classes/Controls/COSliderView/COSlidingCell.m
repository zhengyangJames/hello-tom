//
//  ABSlidingCell.m
//  ApptBooking
//
//  Created by Nikmesoft  M009 on 5/11/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import "COSlidingCell.h"

@interface COSlidingCell ()
{
    __weak IBOutlet UIImageView *_imageView;
}
@end

@implementation COSlidingCell

- (void)setImageName:(NSString *)imageName
{
    self.backgroundColor = [UIColor redColor];
    _imageName = imageName;
    _imageView.autoresizingMask =
    ( UIViewAutoresizingFlexibleBottomMargin
     | UIViewAutoresizingFlexibleHeight
     | UIViewAutoresizingFlexibleLeftMargin
     | UIViewAutoresizingFlexibleRightMargin
     | UIViewAutoresizingFlexibleTopMargin
     | UIViewAutoresizingFlexibleWidth );
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
