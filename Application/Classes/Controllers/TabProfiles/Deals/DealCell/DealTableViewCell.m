//
//  DealTableViewCell.m
//  CoAssets
//
//  Created by Macintosh HD on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "DealTableViewCell.h"
#import "CODealProfileModel.h"
#import "CODealOngoingModel.h"
#import "COPositive&NagitiveButton.h"
#import "COOngoingStatusModel.h"

@implementation DealTableViewCell {
    __weak IBOutlet UILabel *_lbProjectName;
    __weak IBOutlet UILabel *_lbInvestmentAmountData;
    __weak IBOutlet UILabel *_lbPotentialReturnsData;
    __weak IBOutlet UILabel *_lbNextPayoutDateData;
    __weak NSString *strMakePayment;
    __weak IBOutlet UIButton *_btnSigContract;
    __weak IBOutlet UIButton *_btnSigMake;
    
    __weak IBOutlet UILabel *_lblSigContract;
    __weak IBOutlet UILabel *_lblSigMake;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellAccessoryNone;
    _btnSigMake.layer.borderWidth = 2;
    _btnSigMake.layer.borderColor = [UIColor redColor].CGColor;
}

- (IBAction)__actionSignContract:(id)sender {
    if (self.deal != nil) {
         [self _showAlertView:m_string(@"COASSETS_TITLE") message:self.deal.dealOngoingContractInstruction delegate:nil tag:1];
    }
}

- (IBAction)__actionMakePayment:(id)sender {
    if (self.deal != nil) {
        [self _showAlertView:m_string(@"COASSETS_TITLE") message:self.deal.dealOngoingPaymentInstruction delegate:nil tag:1];
    }
}

- (void)setDeal:(CODealOngoingModel *)deal {
    _deal = deal;
    NSString *sgd = deal.dealOngoingCurrency;
    NSString *percent = @"%";
    NSString *persent = [NSString stringWithFormat:@"(%@%@) %@",[deal.dealOngoingPotentialReturnPercent stringValue],percent, sgd];
    _lbProjectName.text = deal.dealOngoingProjectName;
    _lbInvestmentAmountData.text = [NSString stringWithFormat:@"%@ %@",sgd, [UIHelper formartFoatValueWithDeal:deal.dealOngoingInvestAmount MinimumFractionDigits:2]];
    
    _lbPotentialReturnsData.text = [NSString stringWithFormat:@"%@ %@",persent, [UIHelper formartFoatValueWithDeal:deal.dealOngoingPotentialReturnAmount MinimumFractionDigits:0]];
    
    _lbNextPayoutDateData.text = [NSString stringWithFormat:@"%@\n(%@ %@)",deal.dealOngoingNextPayoutDate,sgd, [UIHelper formartFoatValueWithDeal:deal.dealOngoingNextPayoutAmount MinimumFractionDigits:2]];
    
    if (deal.dealOngoingStatus.dealOngoingStatusIsSigned) {
        _btnSigContract.hidden = YES;
        _lblSigContract.hidden = NO;
    } else {
        _btnSigContract.hidden = NO;
        _lblSigContract.hidden = YES;
    }
    
    if (deal.dealOngoingStatus.dealOngoingStatusIsPaid) {
        _btnSigMake.hidden = YES;
        _lblSigMake.hidden = NO;
    } else {
        _btnSigMake.hidden = NO;
        _lblSigMake.hidden = YES;
    }
}

- (void)_showAlertView:(NSString *)title message:(NSString *)message delegate:(UIViewController *)delegate tag:(NSInteger )tag {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
