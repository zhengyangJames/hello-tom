//
//  COPopupQuestionView.m
//  CoAssets
//
//  Created by TUONG DANG on 7/8/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COPopupQuestionView.h"

@interface COPopupQuestionView ()
{
    __weak IBOutlet UITextView *_questionTextView;
    
}
@property (nonatomic, weak) IBOutlet UIView *contentView;

@end

@implementation COPopupQuestionView

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *v = [[NSBundle mainBundle] loadNibNamed:[COPopupQuestionView identifier] owner:self options:nil];
        self = [v objectAtIndex:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView.layer setCornerRadius:5];
    [self setNeedsDisplay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.alpha = 0.0;
    [self.contentView setTransform:CGAffineTransformMakeScale(1.3,1.3)];
    [UIView animateWithDuration:0.15
                          delay:0.15
                        options:kAnimationOptionCurveIOS7
                     animations:^{
                         self.contentView.alpha = 1.0;
                         [self.contentView setTransform:CGAffineTransformMakeScale(1.0,1.0)];
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (IBAction)_actionCancel:(id)sender {
    [UIView animateWithDuration:0.15
                          delay:0
                        options:kAnimationOptionCurveIOS7
                     animations:^{
                         self.alpha = 0.0;
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

+ (void)showPopup{
    COPopupQuestionView *popup = [COPopupQuestionView autoLayoutView];
    popup.translatesAutoresizingMaskIntoConstraints = NO;
    [[kAppDelegate window] addSubview:popup];
    [popup pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
}

@end
