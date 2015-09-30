//
//  BaseLabel.m
//  CoAssets
//
//  Created by Tony Tuong on 9/30/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

- (void)awakeFromNib {
    self.textColor = [UIColor blackColor];
    self.font = [UIFont fontWithName:@"Raleway-Regular" size:17];
}


@end
