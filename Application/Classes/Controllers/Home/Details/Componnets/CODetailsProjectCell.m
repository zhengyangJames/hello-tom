//
//  CODetailsProjectCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProjectCell.h"

#define kCORNER_RADIUS_IMAGE 6


@interface CODetailsProjectCell ()
{
    __weak IBOutlet UILabel *_lbltype;
    __weak IBOutlet UILabel *_lblSite;
    __weak IBOutlet UILabel *_lblDeveloper;
    __weak IBOutlet UILabel *_lblStatus;
    __weak IBOutlet UILabel *_lblInterested;
    __weak IBOutlet UILabel *_lblInvesterment;
    __weak IBOutlet UIView *_backGroundView;
}

@end

@implementation CODetailsProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _backGroundView.layer.cornerRadius = kCORNER_RADIUS_IMAGE;
    [self setNeedsDisplay];
}

#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
}

#pragma mark - Action

- (IBAction)__actionInterested:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:sender didSelectAction:CODetailsProjectActionInterested];
    }
}

- (IBAction)__actionQuestions:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsProfileAction:didSelectAction:)]) {
        [self.delegate detailsProfileAction:sender didSelectAction:CODetailsProjectActionQuestions];
    }
}

@end
