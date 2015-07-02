//
//  AboutProfileObject.m
//  CoAssest
//
//  Created by TUONG DANG on 6/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COListProfileObject.h"

@implementation COListProfileObject

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        self.username = [dic objectForKeyNotNull:@"username"];
        self.first_name = [dic objectForKeyNotNull:@"first_name"];
        self.last_name = [dic objectForKeyNotNull:@"last_name"];
        self.email = [dic objectForKeyNotNull:@"email"];
        NSDictionary *dicProfile = [dic objectForKeyNotNull:@"profile"];
        self.cell_phone = [dicProfile objectForKeyNotNull:@"cellphone"];
        self.country_prefix = [dicProfile objectForKeyNotNull:@"country_prefix"];
        self.address_1 = [dicProfile objectForKeyNotNull:@"address_1"];
        self.address_2 = [dicProfile objectForKeyNotNull:@"address_2"];
        self.region_state = [dicProfile objectForKeyNotNull:@"region_state"];
        self.city = [dicProfile objectForKeyNotNull:@"city"];
        self.country = [dicProfile objectForKeyNotNull:@"country"];
    }
    return self;
}


@end
