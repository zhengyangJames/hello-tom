//
//  AboutTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AboutTableViewCell.h"

@interface AboutTableViewCell ()
{
    
}

@end

@implementation AboutTableViewCell

- (void)viewDidLoad {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}


@end
