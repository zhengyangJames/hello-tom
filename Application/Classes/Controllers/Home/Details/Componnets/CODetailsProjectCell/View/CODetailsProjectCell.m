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
}

@end

@implementation CODetailsProjectCell


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(8.0, 8.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.contentView.bounds;
    maskLayer.path = maskPath.CGPath;
    _contentView.layer.mask = maskLayer;
    _contentView.layer.masksToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get
- (void)setDetailsProfile:(CODetailsProfileObj *)detailsProfile {
    _detailsProfile = detailsProfile;
    _projectStatusLable.text = _detailsProfile.status;
    
    if (detailsProfile.investor_count) {
        NSString *investor = [NSString stringWithFormat:@"%@ INVESTORS",_detailsProfile.investor_count];
        _projectInteredtedLable.text = investor;
    } else {
        _projectInteredtedLable.text = @"N/A";
    }
    
    if (detailsProfile.min_investment) {
        NSString *investment = [NSString stringWithFormat:@"%@",_detailsProfile.min_investment];
        _projectInvestmentLable.text = investment ;
    } else {
        _projectInvestmentLable.text = @"N/A" ;
    }
    
    if (detailsProfile.time_horizon) {
        NSString *time_horizon = [NSString stringWithFormat:@"%@ MONTHS",_detailsProfile.time_horizon];
        _projectHorizonLable.text = time_horizon;
    } else {
        _projectHorizonLable.text = @"N/A";
    }
    
    if (detailsProfile.min_annual_return) {
        NSString *YIELD = [NSString stringWithFormat:@"%@ %% (%@%%)",_detailsProfile.min_annual_return,_detailsProfile.min_annual_return];
        _minYieldLable.text = YIELD;
    } else {
        _minYieldLable.text = @"N/A";
    }
    
    if (detailsProfile.day_left) {
        NSString *day_left = [NSString stringWithFormat:@"%@",_detailsProfile.day_left];
        _dayAgoLable.text = day_left;
    } else {
        _dayAgoLable.text = @"N/A";
    }
}

#pragma mark - Action 



@end
