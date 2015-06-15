//
//  ABCheckBoxButton.h
//  ApptBooking
//
//  Created by Nikmesoft  M009 on 5/11/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class COCheckBoxButton;

static CGFloat defaultrightMarginWidthTitle = 10.0;

@protocol COCheckBoxButtonDelegate <NSObject>

@optional

- (void)checkBoxButton:(COCheckBoxButton *)checkBox didChangeCheckingStatus:(BOOL)isChecking;

@end

@interface COCheckBoxButton : UIButton

@property (nonatomic, assign) BOOL isCheck;

@property (nonatomic, weak) id<COCheckBoxButtonDelegate> delegate;
@property (nonatomic, strong) UIImage *imageCheckBoxUnSelected;
@property (nonatomic, strong) UIImage *imageCheckBoxSelected;
@property (nonatomic, strong) UIColor *titleColorWhenSelected;

@end
