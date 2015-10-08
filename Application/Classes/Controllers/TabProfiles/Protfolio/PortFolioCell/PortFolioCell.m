//
//  PortFolioCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "PortFolioCell.h"

@interface PortFolioCell ()
{
    __weak IBOutlet UIImageView *_imgThumbnail;
    __weak IBOutlet UILabel *_lbNameDetail;
    __weak IBOutlet UILabel *_lbNumOfValue;
}
@end

@implementation PortFolioCell

- (void)awakeFromNib {
    
}

#pragma mark - Set Get
- (void)setObject:(NSString *)object {
    _object = object;
    _lbNameDetail.numberOfLines = 0;
    _lbNameDetail.text = object;
    _lbNumOfValue.text = @"0.00";
    [_lbNameDetail setNeedsUpdateConstraints];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [_imgThumbnail setImage:[UIImage imageNamed:_imageName]];
}


@end
