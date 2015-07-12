//
//  AboutTableViewCell_Address.m
//  CoAssets
//
//  Created by TUONG DANG on 7/3/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AboutTableViewCell_Address.h"

@interface AboutTableViewCell_Address ()
{
    __weak IBOutlet UILabel *address;
}

@end

@implementation AboutTableViewCell_Address

- (void)viewDidLoad {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.profileObject = self.profileObject;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

- (void)updateConstraints {
    [super updateConstraints];
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
    address.text = link;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}
@end
