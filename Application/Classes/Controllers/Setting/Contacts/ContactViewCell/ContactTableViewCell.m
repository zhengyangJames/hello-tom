//
//  ContactTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ContactTableViewCell.h"
#import "COContactsModel.h"

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

- (void)setContactModel:(COContactsModel *)contactModel {
    _contactModel = contactModel;
    if ([_contactModel.stringOfContactName isEmpty]||[_contactModel.stringOfContactRegNo isEmpty]||[_contactModel.stringOfContactAddress1 isEmpty]||[_contactModel.stringOfContactAddress2 isEmpty]||[_contactModel.stringOfContactPhoneNumber isEmpty]||[_contactModel.stringOfContactPostalCode isEmpty]||[_contactModel.stringOfContactCountry isEmpty]||[_contactModel.stringOfContactCity isEmpty] ) {
        [_lblTell       setNeedsUpdateConstraints];
        [_lblReg        setNeedsUpdateConstraints];
        [_lblAdress     setNeedsUpdateConstraints];
        [_lblAdress2    setNeedsUpdateConstraints];
        [_lblPostCode   setNeedsUpdateConstraints];
        [_lblCountry    setNeedsUpdateConstraints];
        [_lblCity       setNeedsUpdateConstraints];
        [_lblTell       setNeedsUpdateConstraints];
    }
    _lblCoAssets.text   =   _contactModel.stringOfContactName;
    _lblCity.text       =   _contactModel.stringOfContactCity;
    _lblReg.text        =   _contactModel.stringOfContactRegNo;
    _lblAdress.text     =   _contactModel.stringOfContactAddress1;
    _lblAdress2.text    =   _contactModel.stringOfContactAddress2;
    _lblTell.text       =   _contactModel.stringOfContactPhoneNumber;
    _lblPostCode.text   =   _contactModel.stringOfContactPostalCode;
    _lblCountry.text    =   _contactModel.stringOfContactCountry;
    [self updateConstraintsIfNeeded];
}
@end

