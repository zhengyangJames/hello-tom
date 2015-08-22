//
//  AboutTableViewCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AboutTableViewCell.h"

@interface AboutTableViewCell ()
{
    __weak IBOutlet UILabel *_lblname;
    __weak IBOutlet UILabel *_lblDetail;
}

@end

@implementation AboutTableViewCell

- (void)viewDidLoad {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setUserFirstName:(id<COUserFirstName>)userFirstName {
    _userFirstName = userFirstName;
    _lblname .text = _userFirstName.firstNameTitle;
    _lblDetail.text = userFirstName.firstNameContent;
}

- (void)setUserLastName:(id<COUserLastName>)userLastName {
    _userLastName = userLastName;
    _lblname .text = _userLastName.lastNameTitle;
    _lblDetail.text = _userLastName.lastNameContent;
}

- (void)setUserEmail:(id<COUserEmail>)userEmail {
    _userEmail = userEmail;
    _lblname .text = _userEmail.emailTitle;
    _lblDetail.text = _userEmail.emailContent;
}

- (void)setUserPhone:(id<COUserPhone>)userPhone {
    _userPhone = userPhone;
    _lblname .text = _userPhone.phoneTitle;
    _lblDetail.text = _userPhone.phoneContentWithPrefix;
}
@end
