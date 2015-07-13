//
//  ContactTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ContactTableViewCell.h"


@interface ContactTableViewCell ()
{
    __weak IBOutlet UILabel *_lblCoAssets;
    __weak IBOutlet UILabel *_lblReg;
    __weak IBOutlet UILabel *_lblAdress;
    __weak IBOutlet UILabel *_lblAdress2;
    __weak IBOutlet UILabel *_lblTell;
    __weak IBOutlet UILabel *_lblPostCode;
    __weak IBOutlet UILabel *_lblCountry;
    __weak IBOutlet UILabel *_lblCity;
}
@end

@implementation ContactTableViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Request

}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];;
}

- (void)setContactObj:(COListContactObject *)contactObj {
    _contactObj = contactObj;
    if ([_contactObj.name isEmpty]||[_contactObj.regNo isEmpty]||[_contactObj.address_1 isEmpty]||[_contactObj.address_2 isEmpty]||[_contactObj.phone isEmpty]||[_contactObj.postCode isEmpty]||[_contactObj.country isEmpty]||[_contactObj.city isEmpty] ) {
        [_lblTell setNeedsUpdateConstraints];
        [_lblReg setNeedsUpdateConstraints];
        [_lblAdress setNeedsUpdateConstraints];
        [_lblAdress2 setNeedsUpdateConstraints];
        [_lblPostCode setNeedsUpdateConstraints];
        [_lblCountry setNeedsUpdateConstraints];
        [_lblCity setNeedsUpdateConstraints];
        [_lblTell setNeedsUpdateConstraints];
    }
    _lblCoAssets.text = _contactObj.name;
    _lblReg.text = _contactObj.regNo;
    _lblAdress.text = _contactObj.address_1;
    _lblAdress2.text = _contactObj.address_2;
    _lblTell.text = _contactObj.phone;
    _lblPostCode.text = _contactObj.postCode;
    _lblCountry.text = _contactObj.country;
    [self updateConstraintsIfNeeded];
}



@end

