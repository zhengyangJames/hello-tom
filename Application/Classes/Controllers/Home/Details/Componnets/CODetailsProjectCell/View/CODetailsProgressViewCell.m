//
//  CODetailsProgressViewTableViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/9/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProgressViewCell.h"
#import "NMDeviceHelper.h"

@interface CODetailsProgressViewCell ()
{
    __weak IBOutlet UILabel *_totalProgressbarLable;
    __weak IBOutlet UILabel *_titleProgressbarLable;
    __weak IBOutlet UILabel *_progressBarBottomLable;
    __weak IBOutlet UIProgressView *_progressBar;
}

@end

@implementation CODetailsProgressViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self isDeviceVersion:@"7.0"]) {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 10.5f);
        _progressBar.transform = transform;
    } else {
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        _progressBar.transform = transform;
    }
}

#pragma mark - Set Get
- (void)setObj:(COProgressbarObj *)obj {
    _obj = obj;
    if ([[obj valueForKey:@"goal"] isKindOfClass:[NSNumber class]]) {
        float value = ([obj.goal doubleValue]*10)/1000;
        [_progressBar setProgress:value animated:NO];
    }
    
    double valueTitle = [obj.current_funded_amount doubleValue];
    NSString *progressLabel = [NSString stringWithFormat:@"$%@",[[NSNumber numberWithDouble:valueTitle] stringValue]];
    _titleProgressbarLable.text = progressLabel;
    
    double value = ([obj.goal doubleValue]);
    NSString *stringValue = [NSString stringWithFormat:@"%@",[[NSNumber numberWithDouble:value] stringValue]];
    if (stringValue.length > 4) {
        NSRange range = NSMakeRange(0, 4);
        NSString *sub = [stringValue substringWithRange:range];
        NSString *progressBottomLbl = [NSString stringWithFormat:@"%@%% of goal",sub];
        _progressBarBottomLable.text = progressBottomLbl;
    } else {
        NSString *progressBottomLbl = [NSString stringWithFormat:@"%@%% of goal",[[NSNumber numberWithDouble:value] stringValue]];
        _progressBarBottomLable.text = progressBottomLbl;
    }
    if([obj.goal doubleValue] != 0) {
        NSRange range;
        NSInteger total;
        NSString *stringValue = [NSString stringWithFormat:@"%@",[[NSNumber numberWithDouble:value] stringValue]];
        if(stringValue.length  > 4) {
            range = NSMakeRange(0, 4);
            NSString *sub = [stringValue substringWithRange:range];
            total = (valueTitle * 100)/[sub doubleValue];
        } else if(stringValue.length == 3) {
            range = NSMakeRange(0, 3);
            NSString *sub = [stringValue substringWithRange:range];
            total = (valueTitle * 100)/[sub doubleValue];
        } else {
            total = (valueTitle * 100)/[stringValue doubleValue];
        }

        _totalProgressbarLable.text = [NSString stringWithFormat:@"of $%@",[[NSNumber numberWithDouble:total] stringValue]];
    }
}


#pragma mark - Private

- (BOOL)isDeviceVersion:(NSString *)version
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version  options:NSNumericSearch] == NSOrderedSame);
}

@end
