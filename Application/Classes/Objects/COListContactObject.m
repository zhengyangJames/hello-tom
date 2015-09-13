//
//  COListContactObject.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COListContactObject.h"

@implementation COListContactObject

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        self.address_1 = [dic objectForKeyNotNull:@"add_1"];
        self.address_2 = [dic objectForKeyNotNull:@"add_2"];
        self.name = [dic objectForKeyNotNull:@"name"];
        self.phone = [dic objectForKeyNotNull:@"phone_no"];
        self.country = [dic objectForKeyNotNull:@"country"];
        self.regNo = [dic objectForKeyNotNull:@"reg_no"];
        self.postCode = [dic objectForKeyNotNull:@"postal_code"];
        self.city = [dic objectForKeyNotNull:@"city"];
    }
    return self;
}



@end
