//
//  COAwatarView.m
//  CoAssets
//
//  Created by Tony Tuong on 9/30/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COAwatarView.h"

@implementation COAwatarView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer setCornerRadius:self.bounds.size.width/2];
    [self.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.layer setBorderWidth:1];
    [self.layer setMasksToBounds:YES];
}



@end
