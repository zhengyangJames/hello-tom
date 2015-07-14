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
    self.profileObject = self.profileObject;
}

#pragma mark Set - Get
- (void)setProfileObject:(COListProfileObject *)profileObject {
    _profileObject = profileObject;
    NSString *link = @"";
    NSString *address1 = _profileObject.address_1;
    if (address1 && ![address1 isEmpty]) {
        link = [link stringByAppendingString:address1];
    }
    NSString *address2 = _profileObject.address_2;
    if (address2 && ![address2 isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:address2];
    }
    NSString *postCode = _profileObject.region_state;
    if (postCode && ![postCode isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:postCode];
    }
    NSString *city = _profileObject.city;
    if (city && ![city isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:city];
    }
    NSString *country = _profileObject.country;
    if (country && ![country isEmpty]) {
        link = [[link stringByAppendingString:@"\n"] stringByAppendingString:country];
    }
    addressLbl.text = link;
    [addressLbl setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
