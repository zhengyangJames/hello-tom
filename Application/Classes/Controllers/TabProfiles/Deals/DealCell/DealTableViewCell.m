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
    
    _lbProjectName.text = deal.dealOngoingProjectName;
    _lbInvestmentAmountData.text = [deal.dealOngoingInvestAmount stringValue];
    _lbPotentialReturnsData.text = [deal.dealOngoingPotentialReturnAmount stringValue];
    _lbNextPayoutDateData.text = deal.dealOngoingNextPayoutDate;
}

@end
