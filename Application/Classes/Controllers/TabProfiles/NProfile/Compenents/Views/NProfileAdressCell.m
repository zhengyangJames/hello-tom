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
}
@end

@implementation NProfileAdressCell

- (void)awakeFromNib {
    [super awakeFromNib];
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
    _txtDetail.text = link;
    [_txtDetail setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
