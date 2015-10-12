//
//  NProfileAdressCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileAdressCell.h"

@interface NProfileAdressCell ()
{
    __weak IBOutlet UITextView *_txtDetail;
    __weak IBOutlet UILabel *_txtName;
    __weak IBOutlet NSLayoutConstraint *_widthOfLabelNameContraint;
}
@end

@implementation NProfileAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark Set - Get

- (void)setUserAddress:(id<COUserAboutProfile>)userAddress {
    _userAddress = userAddress;
    
    NSString *link = @"";
    NSString *address1 = _userAddress.nameOfUserAddress1;
    if (address1 && ![address1 isEmpty]) {
        link = [link stringByAppendingString:address1];
    }
    NSString *address2 = _userAddress.nameOfUserAddress2;
    if (address2 && ![address2 isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:address2];
    }
    NSString *postCode = _userAddress.nameOfUserRegion;
    if (postCode && ![postCode isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:postCode];
    }
    NSString *city = _userAddress.nameOfUserCity;
    if (city && ![city isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:city];
    }
    NSString *country = _userAddress.nameOfUserCountry;
    if (country && ![country isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:country];
    }
    _txtDetail.text = link;
    _txtName.text = m_string(@"ADDRESSNAME");
    [_txtDetail setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setUserAddressCompany:(id<COCompanyAdress>)userAddressCompany {
    _userAddressCompany = userAddressCompany;
    NSString *link = @"";
    NSString *address1 = _userAddressCompany.companyAdressContent1;
    if (address1 && ![address1 isEmpty]) {
        link = [link stringByAppendingString:address1];
    }
    NSString *address2 = _userAddressCompany.companyAdressContent2;
    if (address2 && ![address2 isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:address2];
    }
    NSString *city = _userAddressCompany.companyCity;
    if (city && ![city isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:city];
    }
    NSString *country = _userAddressCompany.companyCountry;
    if (country && ![country isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:country];
    }
    _txtDetail.text = link;
    _txtName.text = m_string(@"ADDRESSNAME");
    [_txtDetail setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setUserAddressInvestor:(id<COInvestorCountries>)userAddressInvestor {
    _userAddressInvestor = userAddressInvestor;
    _txtDetail.text = [_userAddressInvestor COInvestorCountriesContent];
    _txtName.text = [_userAddressInvestor COInvestorCountriesTitle];
    [_txtDetail setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
