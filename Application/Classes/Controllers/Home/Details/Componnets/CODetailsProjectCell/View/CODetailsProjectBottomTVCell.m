//
//  CODetailsProjectBottomTVCell.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectBottomTVCell.h"
#import "COPositive&NagitiveButton.h"
#import "WSURLSessionManager+ListHome.h"


@interface CODetailsProjectBottomTVCell ()<UIAlertViewDelegate>
{
    __weak IBOutlet COPositive_NagitiveButton *_interedtedBTN;
    __weak IBOutlet COPositive_NagitiveButton *_questionBTN;
    __weak IBOutlet UIView *_contentView;
}

@end

@implementation CODetailsProjectBottomTVCell

#pragma mark - Action

- (void)viewDidLoad {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateButton) name:kNOTIFICATION_INTERESTED object:nil];
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateButtonQuestion) name:kNOTIFICATION_QUESTION object:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_contentView.layer setCornerRadius:8];
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
    [_interedtedBTN setTitle:@"I want to invest again!" forState:UIControlStateNormal];
}

- (void)__actionUpdateButtonQuestion {
    [_questionBTN setTitle:@"Request sent." forState:UIControlStateNormal];
}


@end
