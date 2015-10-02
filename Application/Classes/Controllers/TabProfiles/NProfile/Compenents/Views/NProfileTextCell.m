//
//  NProfileTextCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileTextCell.h"

@interface NProfileTextCell ()
{
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblDetail;
    __weak IBOutlet NSLayoutConstraint *_widthOfLabelNameContraint;
}
@end

@implementation NProfileTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUserFirstName:(id<COUserFirstName>)userFirstName {
    _userFirstName  = userFirstName;
    _lblName .text  = _userFirstName.firstNameTitle;
    _lblDetail.text = userFirstName.firstNameContent;
}

- (void)setUserLastName:(id<COUserLastName>)userLastName {
    _userLastName   = userLastName;
    _lblName .text  = _userLastName.lastNameTitle;
    _lblDetail.text = _userLastName.lastNameContent;
}

- (void)setUserEmail:(id<COUserEmail>)userEmail {
    _userEmail      = userEmail;
    _lblName .text  = _userEmail.emailTitle;
    _lblDetail.text = _userEmail.emailContent;
}

- (void)setUserPhone:(id<COUserPhone>)userPhone {
    _userPhone      = userPhone;
    _lblName .text  = _userPhone.phoneTitle;
    _lblDetail.text = _userPhone.phoneContentWithPrefix;
}

- (void)setCompantName:(id<COCompanyName>)compantName {
    _compantName = compantName;
    _lblName.text = _compantName.companyNameTitle;
    _lblDetail.text = _compantName.companyNameContent;
}

- (void)setCompanyAdress:(id<COCompanyAdress>)companyAdress {
    _companyAdress = companyAdress;
    _lblName.text = _companyAdress.companyAdressTitle;
    _lblDetail.text = _companyAdress.companyAdressContent;
}

- (void)setInvestorType:(id<COInvestorType>)investorType {
    _investorType = investorType;
    _lblName.text = investorType.COInvestorTypeTitle;
    _lblDetail.text = investorType.COInvestorTypeContent;
}

- (void)setInvestorPreference:(id<COInvestorPreference>)investorPreference {
    _investorPreference = investorPreference;
    _lblName.text = investorPreference.COInvestorPreferenceTitle;
    _lblDetail.text = investorPreference.COInvestorPreferenceContent;
}

- (void)setInvestorAmount:(id<COInvestorAmount>)investorAmount {
    _investorAmount = investorAmount;
    _lblName.text = investorAmount.COInvestorAmountTitle;
    _lblDetail.text = investorAmount.COInvestorAmountContent;
}

- (void)setInvestorTarget:(id<COInvestorTarget>)investorTarget {
    _investorTarget = investorTarget;
    _lblName.text = investorTarget.COInvestorTargetTitle;
    _lblDetail.text = investorTarget.COInvestorTargetContent;
}

- (void)setInvestorDuration:(id<COInvestorDuration>)investorDuration {
    _investorDuration = investorDuration;
    _lblName.text = investorDuration.COInvestorDurationTitle;
    _lblDetail.text = investorDuration.COInvestorDurationContent;
}

- (void)setInvestorCountries:(id<COInvestorCountries>)investorCountries {
    _investorCountries = investorCountries;
    _lblName.text = investorCountries.COInvestorCountriesTitle;
    _lblDetail.text = investorCountries.COInvestorCountriesContent;
}


@end
