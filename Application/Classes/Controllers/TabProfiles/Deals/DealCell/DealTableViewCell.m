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

@implementation DealTableViewCell {
    __weak IBOutlet UILabel *_lbProjectName;
    __weak IBOutlet UILabel *_lbInvestmentAmountData;
    __weak IBOutlet UILabel *_lbPotentialReturnsData;
    __weak IBOutlet UILabel *_lbNextPayoutDateData;
}


- (void)awakeFromNib {
    // Initialization code
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

@end
