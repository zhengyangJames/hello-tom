//
//  ContactsModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COContactsModel.h"

@implementation COContactsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"contactRegNo"         :   @"reg_no",
        @"contactCity"          :   @"city",
        @"contactPostalCode"    :   @"postal_code",
        @"contactCountry"       :   @"country",
        @"contactAddress2"      :   @"add_2",
        @"contactPhoneNumber"   :   @"phone_no",
        @"contactAddress1"      :   @"add_1",
        @"contactName"          :   @"name"
    };
}
#pragma mark - get
- (NSString *)stringOfContactRegNo {
    return self.contactRegNo;
}

- (NSString *)stringOfContactCity {
    return self.contactCity;
}

- (NSString *)stringOfContactPostalCode {
    return self.contactPostalCode;
}

- (NSString *)stringOfContactCountry {
    return self.contactCountry;
}

- (NSString *)stringOfContactAddress2 {
    return self.contactAddress2;
}

- (NSString *)stringOfContactPhoneNumber {
    return self.contactPhoneNumber;
}

- (NSString *)stringOfContactAddress1 {
    return self.contactAddress1;
}

- (NSString *)stringOfContactName {
    return self.contactName;
}
@end
