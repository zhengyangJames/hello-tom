//
//  COLineBottomView.m
//  CoAssest
//
//  Created by TUONG DANG on 6/12/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COLineBottomView.h"



@implementation COLineBottomView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSeparatorLinesWithColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self addSeparatorLinesWithColor];
}


- (void)addSeparatorLinesWithColor {
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(self.edgeInsetLeft, self.frame.size.height - SEPARATOR_HEIGHT, self.frame.size.width - self.edgeInsetLeft - self.edgeInsetRight, SEPARATOR_HEIGHT)];
    [separatorView setBackgroundColor:self.color];
    [self addSubview:separatorView];
    [self setNeedsLayout];
    
}

- (void)setEdgeInsetLeft:(CGFloat)edgeInsetLeft {
    _edgeInsetLeft = edgeInsetLeft;
}

- (void)setEdgeInsetRight:(CGFloat)edgeInsetRight {
    _edgeInsetRight = edgeInsetRight;
}

- (void)setColor:(UIColor *)color {
    _color = color;
}

@end
