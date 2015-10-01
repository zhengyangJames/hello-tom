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

@end
