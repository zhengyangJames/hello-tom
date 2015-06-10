//
//  BaseView.h
//  NikmeApps
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

@interface BaseView : UIView

- (instancetype)initWithNibName:(NSString*)nibNameOrNil;

- (void)viewDidLoad;

- (void)showInView:(UIView*)parentView animation:(UIViewAnimationOptions)animation
          duration:(NSTimeInterval)duration;
- (void)dismissWithAnimation:(UIViewAnimationOptions)animation duration:(NSTimeInterval)duration;

@end
