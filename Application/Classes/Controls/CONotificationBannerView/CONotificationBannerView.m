//
//  CONotificationBannerView.m
//  CoAssets
//
//  Created by Tony Tuong on 10/20/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CONotificationBannerView.h"

@interface CONotificationBannerView ()
{
    UIImageView *_imageLogoApp;
    UILabel *_titleApp;
    UILabel *_messageApp;
    UIButton *_buttonTap;
    BOOL keyShowView;
}

@end

@implementation CONotificationBannerView

- (void)viewDidLoad {
    CGFloat with = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 70;
    self.frame = CGRectMake(0, 0, with, height);
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    [self setupUI];
}

#pragma mark - SetUp UI

- (void)setupUI {
    [self addImageLogoApp];
    [self addTitleApp];
    [self addmessageApp];
    [self addButtonTap];
}

- (void)addImageLogoApp {
    _imageLogoApp = [UIImageView autoLayoutView];
    _imageLogoApp.translatesAutoresizingMaskIntoConstraints = NO;
    [_imageLogoApp setImage:[UIImage imageNamed:@"AppIcon40x40"]];
    [_imageLogoApp.layer setCornerRadius:8];
    [_imageLogoApp setClipsToBounds:YES];
    [self addSubview:_imageLogoApp];
    [_imageLogoApp constrainToWidth:40];
    [_imageLogoApp constrainToHeight:40];
    [_imageLogoApp pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofItem:self withConstant:22];
    [_imageLogoApp pinAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeLeading ofItem:self withConstant:8];
}

- (void)addTitleApp {
    _titleApp = [UILabel autoLayoutView];
    _titleApp.translatesAutoresizingMaskIntoConstraints = NO;
    _titleApp.text = m_string(@"COASSETS_TITLE");
    _titleApp.font = [UIFont systemFontOfSize:14];
    _titleApp.textColor = [UIColor whiteColor];
    [self addSubview:_titleApp];
    [_titleApp constrainToHeight:18];
    [_titleApp pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofItem:self withConstant:22];
    [_titleApp pinAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeTrailing ofItem:_imageLogoApp withConstant:8];
    [_titleApp pinAttribute:NSLayoutAttributeTrailing toAttribute:NSLayoutAttributeTrailing ofItem:self withConstant:8];
}

- (void)addmessageApp {
    _messageApp = [UILabel autoLayoutView];
    _messageApp.translatesAutoresizingMaskIntoConstraints = NO;
    _messageApp.font = [UIFont systemFontOfSize:14];
    _messageApp.textColor = [UIColor whiteColor];
    [self addSubview:_messageApp];
    [_messageApp constrainToHeight:22];
    [_messageApp pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofItem:self withConstant:40];
    [_messageApp pinAttribute:NSLayoutAttributeLeading toAttribute:NSLayoutAttributeTrailing ofItem:_imageLogoApp withConstant:8];
    [_messageApp pinToSuperviewEdges:JRTViewPinRightEdge inset:8];
}

- (void)addButtonTap {
    _buttonTap = [UIButton autoLayoutView];
    _buttonTap.translatesAutoresizingMaskIntoConstraints = NO;
    _buttonTap.backgroundColor = [UIColor clearColor];
    [_buttonTap addTarget:self action:@selector(__actionTapButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonTap];
    [_buttonTap pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
}

- (void)__actionTapButton {
    if ([self.delegate respondsToSelector:@selector(notificationBannerViewDissmis:)]) {
        [self.delegate notificationBannerViewDissmis:self];
    }
    [self dismiss];
}

#pragma mark - Set Get
- (void)setTextMessage:(NSString *)textMessage {
    _textMessage = textMessage;
    _messageApp.text = textMessage;
}

#pragma mark - public

- (void)show {
    [[kAppDelegate window] addSubview:self];
    [self setTransform:CGAffineTransformMakeTranslation(0, -self.bounds.size.height)];
    [UIView animateWithDuration:0.3 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0, 0)];
    } completion:^(BOOL finished) {
        [self delayPerform];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        [self setTransform:CGAffineTransformMakeTranslation(0, -self.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)delayPerform {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:3.0];
    }];
    
}

@end
