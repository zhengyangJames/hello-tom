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
    return [self.contactRegNo trim];
}

- (NSString *)stringOfContactCity {
    return [self.contactCity trim];
}

- (NSString *)stringOfContactPostalCode {
    return [self.contactPostalCode trim];
}

- (NSString *)stringOfContactCountry {
    return [self.contactCountry trim];
}

- (NSString *)stringOfContactAddress2 {
    return [self.contactAddress2 trim];
}

- (NSString *)stringOfContactPhoneNumber {
    return [self.contactPhoneNumber trim];
}

- (NSString *)stringOfContactAddress1 {
    return [self.contactAddress1 trim];
}

- (NSString *)stringOfContactName {
    return [self.contactName trim];
}
@end
