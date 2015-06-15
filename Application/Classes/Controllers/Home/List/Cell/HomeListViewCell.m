//
//  HomeListViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewCell.h"

@implementation HomeListViewCell
{
    __weak IBOutlet UIImageView *_imageBig;
    __weak IBOutlet UIImageView *_imageLogo;
    __weak IBOutlet UILabel *_lblDetail;
    __weak IBOutlet UILabel *_lblSate;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setObject:(ListHomeObject *)object {
    _object = object;
    [_imageBig setImage:[UIImage imageNamed:_object.imageNameBig]];
    [_imageLogo setImage:[UIImage imageNamed:_object.imageNameLogo]];
    [_lblDetail setText:_object.lableDetail];
    [_lblSate setText:_object.lableSate];
}


@end
