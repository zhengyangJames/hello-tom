//
//  COPositive&NagitiveButton.m
//  CoAssest
//
//  Created by TUONG DANG on 6/12/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COPositive&NagitiveButton.h"

@implementation COPositive_NagitiveButton

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.nagitiveButton) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setTitleColor:KBUTTON_COLOR forState:UIControlStateNormal];
    }else {
        [self setBackgroundColor:KBUTTON_COLOR];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews {
    [self.layer setCornerRadius:CORNERRADIUS];
    if (self.nagitiveButton) {
        [self.layer setBorderWidth:BORDER];
        [self.layer setBorderColor:KBUTTON_COLOR.CGColor];
    }
    [super layoutSubviews];
}

- (void)setNagitiveButton:(BOOL)nagitiveButton {
    _nagitiveButton = nagitiveButton;
}

@end
