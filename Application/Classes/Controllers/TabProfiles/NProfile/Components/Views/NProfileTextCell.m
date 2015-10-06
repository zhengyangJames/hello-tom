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
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setUserLastName:(id<COUserLastName>)userLastName {
    _userLastName   = userLastName;
    _lblName .text  = _userLastName.lastNameTitle;
    _lblDetail.text = _userLastName.lastNameContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setUserEmail:(id<COUserEmail>)userEmail {
    _userEmail      = userEmail;
    _lblName .text  = _userEmail.emailTitle;
    _lblDetail.text = _userEmail.emailContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setUserPhone:(id<COUserPhone>)userPhone {
    _userPhone      = userPhone;
    _lblName .text  = _userPhone.phoneTitle;
    _lblDetail.text = _userPhone.phoneContentWithPrefix;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setCompanytName:(id<COCompanyName>)companytName {
    _companytName = companytName;
    if ([_companytName.companyNameContent isEqualToString:m_string(@"NoCompanyAssociated")]) {
        _lblName.text = nil;
        _lblDetail.text = _companytName.companyNameContent;
        [_lblDetail setTextAlignment:NSTextAlignmentCenter];
        _widthOfLabelNameContraint.constant = 0;
        [self setNeedsUpdateConstraints];
    } else {
        _lblName.text = _companytName.companyNameTitle;
        _lblDetail.text = _companytName.companyNameContent;
        [self _updateWidthOfLabelNameWithString:_lblName.text];
    }
}

- (void)setInvestorType:(id<COInvestorType>)investorType {
    _investorType = investorType;
    _lblName.text = investorType.COInvestorTypeTitle;
    _lblDetail.text = investorType.COInvestorTypeContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setInvestorPreference:(id<COInvestorPreference>)investorPreference {
    _investorPreference = investorPreference;
    _lblName.text = investorPreference.COInvestorPreferenceTitle;
    _lblDetail.text = investorPreference.COInvestorPreferenceContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setInvestorAmount:(id<COInvestorAmount>)investorAmount {
    _investorAmount = investorAmount;
    _lblName.text = investorAmount.COInvestorAmountTitle;
    _lblDetail.text = investorAmount.COInvestorAmountContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setInvestorTarget:(id<COInvestorTarget>)investorTarget {
    _investorTarget = investorTarget;
    _lblName.text = investorTarget.COInvestorTargetTitle;
    _lblDetail.text = investorTarget.COInvestorTargetContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setInvestorDuration:(id<COInvestorDuration>)investorDuration {
    _investorDuration = investorDuration;
    _lblName.text = investorDuration.COInvestorDurationTitle;
    _lblDetail.text = investorDuration.COInvestorDurationContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setInvestorCountries:(id<COInvestorCountries>)investorCountries {
    _investorCountries = investorCountries;
    _lblName.text = investorCountries.COInvestorCountriesTitle;
    _lblDetail.text = investorCountries.COInvestorCountriesContent;
    
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)setUserName:(id<COUserName>)userName {
    _userName = userName;
    _lblName.text = userName.userNameTitle;
    _lblDetail.text = userName.userNameContent;
    [self _updateWidthOfLabelNameWithString:_lblName.text];
}

- (void)_updateWidthOfLabelNameWithString:(NSString *)string {
    CGFloat width = [UIHelper widthOfString:string withFont:[UIFont systemFontOfSize:16]];
    if (width < 87) {
        width = 87;
    }
    [_lblDetail setTextAlignment:NSTextAlignmentRight];
    _widthOfLabelNameContraint.constant = width;
    [self setNeedsUpdateConstraints];
}

@end
