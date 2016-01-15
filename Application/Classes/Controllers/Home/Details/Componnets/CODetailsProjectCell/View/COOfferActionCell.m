//
//  CODetailsProjectBottomTVCell.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferActionCell.h"
#import "COPositive&NagitiveButton.h"


@interface COOfferActionCell ()<UIAlertViewDelegate>
{
    __weak IBOutlet COPositive_NagitiveButton *_interedtedBTN;
    __weak IBOutlet COPositive_NagitiveButton *_questionBTN;
    __weak IBOutlet UIView *_contentView;
}

@end

@implementation COOfferActionCell

#pragma mark - Action

- (void)viewDidLoad {
    [_interedtedBTN setTitle:m_string(@"BUTTON_I'M_INTERESTED") forState:UIControlStateNormal];
    [_questionBTN setTitle:m_string(@"BUTTON_I'VE_QUESTION") forState:UIControlStateNormal];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateButton) name:kNOTIFICATION_INTERESTED object:nil];
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateButtonQuestion) name:kNOTIFICATION_QUESTION object:nil];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:CGSizeMake(8.0, 8.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;
    _contentView.layer.masksToBounds = YES;
}

- (IBAction)__actionInterested:(id)sender {

    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:self didSelectAction:CODetailsProjectActionInterested];
    }
}

- (IBAction)__actionQuestions:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:self didSelectAction:CODetailsProjectActionQuestions];
    }
}

- (void)__actionUpdateButton {
    [_interedtedBTN setTitle:m_string(@"BUTTON_INTERESTED") forState:UIControlStateNormal];
}

- (void)__actionUpdateButtonQuestion {
    [_questionBTN setTitle:m_string(@"BUTTON_QUESTION") forState:UIControlStateNormal];
}


@end
