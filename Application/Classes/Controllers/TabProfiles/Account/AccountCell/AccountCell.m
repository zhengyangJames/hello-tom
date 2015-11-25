//
//  AccountCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AccountCell.h"
#import "BaseLabel.h"

@interface AccountCell ()
{
    __weak IBOutlet BaseLabel *_lblValue;
    __weak IBOutlet BaseLabel *_lblDetail;
    
    __weak IBOutlet NSLayoutConstraint *_widthTitle;
}
@end

@implementation AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setAccountOnGoing:(id<COAccountOnGoing>)accountOnGoing {
    _accountOnGoing = accountOnGoing;
    _lblValue.text = [UIHelper formartDoubleValueWithAccountInvest:[_accountOnGoing accOngoingInvestment]];
    _lblDetail.text = [_accountOnGoing accOngoingTitle];
    [self _updateWidthOfLabelNameWithString:_lblDetail.text];
}

- (void)setAccountCompleted:(id<COAccountCompleted>)accountCompleted {
    _accountCompleted = accountCompleted;
    _lblValue.text = [UIHelper formartDoubleValueWithAccountInvest:[_accountCompleted accCompletedInvestment]];
    _lblDetail.text = [_accountCompleted accCompletedtitle];
    [self _updateWidthOfLabelNameWithString:_lblDetail.text];
}

- (void)setAccountFunded:(id<COAccountFunded>)accountFunded {
    _accountFunded = accountFunded;
    _lblValue.text = [UIHelper formartDoubleValueWithAccountInvest:[_accountFunded accFundedInvestment]];
    _lblDetail.text = [_accountFunded accFundedTitle];
    [self _updateWidthOfLabelNameWithString:_lblDetail.text];
}

- (void)setAccountPotential:(id<COAccountPotential>)accountPotential {
    _accountPotential = accountPotential;
    _lblValue.text = [UIHelper formartDoubleValueWithAccountInvest:[_accountPotential accPotentialPayouts]];
    _lblDetail.text = [_accountPotential accPotentialTitle];
    [self _updateWidthOfLabelNameWithString:_lblDetail.text];
}

- (void)setAccountRealised:(id<COAccountRealised>)accountRealised {
    _accountRealised = accountRealised;
    _lblValue.text = [UIHelper formartDoubleValueWithAccountInvest:[_accountRealised accRealisedPayouts]];
    _lblDetail.text = [_accountRealised accRealisedTitle];
    [self _updateWidthOfLabelNameWithString:_lblDetail.text];
}

- (void)_updateWidthOfLabelNameWithString:(NSString *)string {
    CGFloat width = [UIHelper widthOfString:string withFont:[UIFont systemFontOfSize:16]];
    if (width < 100) {
        width = 100;
    }
    _widthTitle.constant = width;
    [self setNeedsUpdateConstraints];
}

@end

