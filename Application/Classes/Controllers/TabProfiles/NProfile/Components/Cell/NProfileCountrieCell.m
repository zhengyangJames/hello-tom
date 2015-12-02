//
//  NProfileCountrieCell.m
//  CoAssets
//
//  Created by Tony Tuong on 10/12/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "NProfileCountrieCell.h"

@interface NProfileCountrieCell ()
{
    __weak IBOutlet UITextView *_txtDetail;
    __weak IBOutlet UILabel *_txtName;
}

@end

@implementation NProfileCountrieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUserAddressInvestor:(id<COInvestorCountries>)userAddressInvestor {
    _userAddressInvestor = userAddressInvestor;
    _txtDetail.text = [_userAddressInvestor COInvestorCountriesContent];
    _txtName.text = [_userAddressInvestor COInvestorCountriesTitle];
    [_txtDetail setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
@end
