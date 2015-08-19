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
#import "COOfferModel.h"

@interface CODetailsProjectCell ()
{
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UILabel *_lblOfferStatus;
    __weak IBOutlet UILabel *_lblOfferInvestor;
    __weak IBOutlet UILabel *_lblOfferMinInvestment;
    __weak IBOutlet UILabel *_lblOfferTimeHorizon;
    __weak IBOutlet UILabel *_lblOfferYield;
    __weak IBOutlet UILabel *_lblOfferDayLeft;
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

- (void)setOfferInfo:(id<COOfferInfo>)offerInfo {
    _offerInfo = offerInfo;
    _lblOfferStatus.text = _offerInfo.offerInfoStatus;
    _lblOfferInvestor.text = _offerInfo.offerInfoInvestor;
    _lblOfferMinInvestment.text = _offerInfo.offerInfoMinInvesment;
    _lblOfferTimeHorizon.text = _offerInfo.offerInfoTimeHorizon;
    _lblOfferYield.text= _offerInfo.offerInfoYield;
    _lblOfferDayLeft.text= _offerInfo.offerInfoDayLeft;
}

#pragma mark - Action 



@end
