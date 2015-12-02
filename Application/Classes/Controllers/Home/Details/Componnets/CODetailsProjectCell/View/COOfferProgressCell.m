//
//  CODetailsProgressViewTableViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferProgressCell.h"
#import "NMDeviceHelper.h"
#import "UIHelper.h"

@interface COOfferProgressCell ()
{
    __weak IBOutlet UILabel         *_totalProgressbarLable;
    __weak IBOutlet UILabel         *_titleProgressbarLable;
    __weak IBOutlet UILabel         *_progressBarBottomLable;
    __weak IBOutlet UIProgressView  *_progressBar;
}

@end

@implementation COOfferProgressCell

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self isDeviceVersion:@"7.0"]) {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 10.5f);
        _progressBar.transform      = transform;
    } else {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        _progressBar.transform      = transform;
    }
}

#pragma mark - Set Get
- (void)setProjectInfoProgress:(id<COProjectFundedAmount>)projectInfoProgress {
    _projectInfoProgress            = projectInfoProgress;
    NSNumber *valueGoal             = _projectInfoProgress.goalOrigin;
    float value = ([valueGoal doubleValue]*10)/1000;
    [_progressBar setProgress:value animated:NO];
    _titleProgressbarLable.text     = _projectInfoProgress.currentFundedAmountToString;
    _progressBarBottomLable.text    = _projectInfoProgress.offerInfoGoalToString;
    _totalProgressbarLable.text     = [@"of " stringByAppendingString:_projectInfoProgress.totalProgress];
}


#pragma mark - Private

- (BOOL)isDeviceVersion:(NSString *)version
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version  options:NSNumericSearch] == NSOrderedSame);
}

@end
