//
//  COBorderTextView.m
//  CoAssets
//
//  Created by Tony Tuong on 10/8/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COBorderTextView.h"

@implementation COBorderTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth = .8;
    [self.layer setBorderColor:KLIGHT_GRAY_COLOR.CGColor];
}

- (id)init {
    self = [super init];
    if (self) {
        self.layer.borderWidth = .8;
        [self.layer setBorderColor:KLIGHT_GRAY_COLOR.CGColor];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = bounds;
    rect.origin.x += 8;
    rect.size.width -= 8;
    return rect;
}

// text position

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = bounds;
    rect.origin.x += 8;
    rect.size.width -= 8;
    return rect;
}

@end
