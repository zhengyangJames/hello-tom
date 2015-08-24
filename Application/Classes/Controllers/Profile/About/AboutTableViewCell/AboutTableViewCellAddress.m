//
//  AboutTableViewCellAddress.m
//  CoAssets
//
//  Created by TUONG DANG on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AboutTableViewCellAddress.h"

@interface AboutTableViewCellAddress ()
{
    __weak IBOutlet UITextView *addressLbl;
}

@end

@implementation AboutTableViewCellAddress

- (void)viewDidLoad {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark Set - Get

-(void)setUserAddress:(id<COUserAboutProfile>)userAddress {
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
    addressLbl.text = link;
    [addressLbl setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
