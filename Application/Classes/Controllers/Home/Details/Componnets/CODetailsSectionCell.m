//
//  CODetailsSectionCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/19/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsSectionCell.h"

@interface CODetailsSectionCell ()
{
    __weak IBOutlet UILabel *_lblSection;
}

@end

@implementation CODetailsSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}

#pragma mark - Set Get
- (void)setTitleSection:(NSString *)titleSection {
    _titleSection = titleSection;
    _lblSection.text = _titleSection;
}


@end
