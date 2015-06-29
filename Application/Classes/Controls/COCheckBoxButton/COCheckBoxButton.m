//
//  ABCheckBoxButton.m
//  ApptBooking
//
//  Created by Nikmesoft  M009 on 5/11/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import "COCheckBoxButton.h"

@implementation COCheckBoxButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initilizeButton];
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.numberOfLines = 2;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self initilizeButton];
}

- (void)initilizeButton {
    if (_isCheck) {
        [self _check];
    } else {
        [self _unCheck];
    }
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(checkBoxButton:didChangeCheckingStatus:)]) {
        self.isCheck = !self.isCheck;
        [self.delegate checkBoxButton:self didChangeCheckingStatus:self.isCheck];
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super imageRectForContentRect:contentRect];
    frame.origin.x = 0;
    frame.size.height = 22;
    frame.size.width = 22;
    return frame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    frame.origin.x = CGRectGetWidth([self imageRectForContentRect:contentRect]) + 5;
    frame.origin.y = 0;
    frame.size.height = CGRectGetHeight(contentRect);
    frame.size.width = CGRectGetWidth(contentRect) - frame.origin.x;
    return frame;
}

#pragma mark - Private
- (void)_check {
    if (self.imageCheckBoxSelected) {
        [self setImage:_imageCheckBoxSelected forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"ic_Check"] forState:UIControlStateNormal];
    }
    
    if (self.titleColorWhenSelected) {
        [self setTitleColor:self.titleColorWhenSelected forState:UIControlStateNormal];
    }
}

- (void)_unCheck {
    if (self.imageCheckBoxUnSelected) {
        [self setImage:_imageCheckBoxUnSelected forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"ic_uncheck"] forState:UIControlStateNormal];
    }
    if (self.titleColorWhenSelected) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

#pragma mark - Set Get

- (void)setImageCheckBoxUnSelected:(UIImage *)imageCheckBoxUnSelected {
    _imageCheckBoxUnSelected = imageCheckBoxUnSelected;
    [self setNeedsDisplay];
}

- (void)setImageCheckBoxSelected:(UIImage *)imageCheckBoxSelected {
    _imageCheckBoxSelected = imageCheckBoxSelected;
    [self setNeedsDisplay];
}

- (void)setTitleColorWhenSelected:(UIColor *)titleColorWhenSelected {
    _titleColorWhenSelected = titleColorWhenSelected;
    [self setNeedsDisplay];
}

- (void)setIsCheck:(BOOL)isCheck {
    _isCheck = isCheck;
    [self setNeedsDisplay];
}

- (BOOL)isCheck {
    return _isCheck;
}

@synthesize isCheck = _isCheck;

@end
