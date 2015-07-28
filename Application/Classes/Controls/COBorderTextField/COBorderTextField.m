//
//  COBorderTextField.m
//  CoAssest
//
//  Created by TUONG DANG on 6/20/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COBorderTextField.h"




@implementation COBorderTextField

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderStyle = UITextBorderStyleNone;
    self.layer.borderWidth = .8;
    [self.layer setBorderColor:KLIGHT_GRAY_COLOR.CGColor];
}

- (id)init {
    self = [super init];
    if (self) {
        self.borderStyle = UITextBorderStyleNone;
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
