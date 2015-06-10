//
//  BaseView.m
//  NikmeApps
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithNibName:(NSString*)nibNameOrNil {
    self = [super init];
    NSString *nibName = NSStringFromClass([self class]);
    if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"])
    {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        for (id v in arrayOfViews) {
            if([v isKindOfClass:[self class]])
            {
                self = v;
            }
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self viewDidLoad];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewDidLoad];
}

- (void)viewDidLoad {
    
}

#pragma mark - Show/Hide Method
- (void)showInView:(UIView*)parentView animation:(UIViewAnimationOptions)animation
          duration:(NSTimeInterval)duration {
    [UIView transitionWithView:parentView duration:duration options:animation animations:^{
        [parentView addSubview:self];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissWithAnimation:(UIViewAnimationOptions)animation duration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration delay:0.0 options:animation
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview]; }];
}


@end
