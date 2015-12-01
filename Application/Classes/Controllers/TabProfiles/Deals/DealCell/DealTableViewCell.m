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

@implementation DealTableViewCell {
    __weak IBOutlet UILabel *_lbProjectName;
    __weak IBOutlet UILabel *_lbInvestmentAmountData;
    __weak IBOutlet UILabel *_lbPotentialReturnsData;
    __weak IBOutlet UILabel *_lbNextPayoutDateData;
    __weak NSString *strMakePayment;
    __weak IBOutlet UIButton *_btnSigContract;
    __weak IBOutlet UIButton *_btnSigMake;
}


- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellAccessoryNone;
    [_btnSigContract.layer setCornerRadius:CORNERRADIUS];
    [_btnSigMake.layer setCornerRadius:CORNERRADIUS];
}

- (IBAction)__actionSignContract:(id)sender {
    if (self.strSig != nil) {
         [self _showAlertView:NSLocalizedString(@"COASSETS_TITLE", nil) message:self.strSig delegate:nil tag:1];
    }
}

- (IBAction)__actionMakePayment:(id)sender {
    if (self.strPayMent != nil) {
        [self _showAlertView:NSLocalizedString(@"COASSETS_TITLE", nil) message:self.strPayMent delegate:nil tag:1];
    }
}

- (void)setModel:(CODealProfileModel *)model {
    _model = model;
    CODealOngoingModel *deal = (CODealOngoingModel *)model;
    NSString *sgd = deal.dealOngoingCurrency;
    NSString *persent = [NSString stringWithFormat:@"(%@) %@",[deal.dealOngoingPotentialReturnPercent stringValue], sgd];
    _lbProjectName.text = deal.dealOngoingProjectName;
    _lbInvestmentAmountData.text = [NSString stringWithFormat:@"%@ %@",sgd, [deal.dealOngoingInvestAmount stringValue]];
    _lbPotentialReturnsData.text = [NSString stringWithFormat:@"%@ %@",persent, [deal.dealOngoingPotentialReturnAmount stringValue]];
    _lbNextPayoutDateData.text = [NSString stringWithFormat:@"%@ %@",deal.dealOngoingNextPayoutDate, persent];
}

- (void)_showAlertView:(NSString *)title message:(NSString *)message delegate:(UIViewController *)delegate tag:(NSInteger )tag {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
