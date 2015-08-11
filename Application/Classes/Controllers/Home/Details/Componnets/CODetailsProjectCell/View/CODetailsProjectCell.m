//
//  CODetailsProjectCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectCell.h"
#import "COPositive&NagitiveButton.h"
#import "UIHelper.h"
#import "CODetailsProfileObj+Formater.h"

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
    _projectStatusLable.text = detailsProfile.stringOfStatus;
    
    _projectInteredtedLable.text = detailsProfile.stringOfInvestorCount;
    
    _projectInvestmentLable.text = detailsProfile.currencyStringFormatFromInvestment ;
    
    _projectHorizonLable.text = detailsProfile.stringOfTimeHorizon;

    _minYieldLable.text = detailsProfile.stringOfMinAnnualReturn;
    
    _dayAgoLable.text = detailsProfile.stringOfDayLeft;
}

#pragma mark - Action 



@end
