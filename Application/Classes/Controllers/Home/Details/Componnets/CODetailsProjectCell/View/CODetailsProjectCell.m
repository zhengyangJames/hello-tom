//
//  CODetailsProjectCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectCell.h"
#import "COPositive&NagitiveButton.h"

@interface CODetailsProjectCell ()
{
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UILabel *_projectStatusLable;
    __weak IBOutlet UILabel *_projectInteredtedLable;
    __weak IBOutlet UILabel *_projectInvestmentLable;
    __weak IBOutlet UILabel *_projectHorizonLable;
    __weak IBOutlet UILabel *_dayAgoLable;
    __weak IBOutlet UILabel *_minYieldLable;
    __weak IBOutlet UILabel *_titleProgressbarLable;
    __weak IBOutlet UILabel *_progressBarBottomLable;
    __weak IBOutlet UIProgressView *_progressBar;
    __weak IBOutlet COPositive_NagitiveButton *_interedtedButton;
    __weak IBOutlet COPositive_NagitiveButton *_questionButton;
}

@end

@implementation CODetailsProjectCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [_contentView.layer setCornerRadius:8];
}

#pragma mark - Set Get
- (void)setDetailsProfile:(CODetailsProfileObj *)detailsProfile {
    _detailsProfile = detailsProfile;
    _projectStatusLable.text = _detailsProfile.status;
    
    NSString *investor = [NSString stringWithFormat:@"%@ INVESTORS",_detailsProfile.investor_count];
    _projectInteredtedLable.text = investor;
    
    NSString *investment = [NSString stringWithFormat:@"%@",_detailsProfile.min_investment];
    _projectInvestmentLable.text = investment ;
    
    NSString *time_horizon = [NSString stringWithFormat:@"%@ MONTHS",_detailsProfile.time_horizon];
    _projectHorizonLable.text = time_horizon;
    
    NSString *YIELD = [NSString stringWithFormat:@"%@ %% (%@%%)",_detailsProfile.time_horizon,_detailsProfile.time_horizon];
    _minYieldLable.text = YIELD;
     NSString *day_left = [NSString stringWithFormat:@"%@",_detailsProfile.day_left];
    _dayAgoLable.text = day_left;
   
//    if (![detailsProfile.investor_count isEmpty]) {
//        NSString *investor = [NSString stringWithFormat:@"%@ INVESTORS",_detailsProfile.investor_count];
//        _projectInteredtedLable.text = investor;
//    }
//    
//    if (![detailsProfile.min_investment isEmpty]) {
//        NSString *investment = [NSString stringWithFormat:@"%@",_detailsProfile.min_investment];
//        _projectInvestmentLable.text = investment ;
//    }
//    
//    if (![detailsProfile.time_horizon isEmpty]) {
//        NSString *time_horizon = [NSString stringWithFormat:@"%@ MONTHS",_detailsProfile.time_horizon];
//        _projectHorizonLable.text = time_horizon;
//    }
//    
//    if (![detailsProfile.time_horizon isEmpty]) {
//        NSString *YIELD = [NSString stringWithFormat:@"%@ %% (%@%%)",_detailsProfile.time_horizon,_detailsProfile.time_horizon];
//        _minYieldLable.text = YIELD;
//    }
//    
//    if (![detailsProfile.day_left isEmpty]) {
//        NSString *day_left = [NSString stringWithFormat:@"%@",_detailsProfile.day_left];
//        _dayAgoLable.text = day_left;
//    }
}

@end
