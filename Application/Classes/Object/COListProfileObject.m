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

- (NSDictionary*)getProfileObject {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kUSER] = self.username ;
    dic[KFRIST_NAME] = self.first_name ;
    dic[KLAST_NAME] = self.last_name ;
    dic[KEMAIL] = self.email ;
    dic[kNUM_CELL_PHONE] = self.cell_phone ;
    dic[kNUM_COUNTRY] = self.country_prefix ;
    dic[KADDRESS] = self.address_1 ;
    dic[KADDRESS2] = self.address_2;
    dic[KCITY] = self.city;
    dic[KCOUNTRY] = self.country;
    dic[KSATE] = self.region_state ;
    return dic;
}

- (void)setProfileObject:(NSDictionary*)dicObject {
    self.username = [dicObject objectForKeyNotNull:kUSER];
    self.first_name = [dicObject objectForKeyNotNull:KFRIST_NAME];
    self.last_name = [dicObject objectForKeyNotNull:KLAST_NAME];
    self.email = [dicObject objectForKeyNotNull:KEMAIL];
    self.cell_phone = [dicObject objectForKeyNotNull:kNUM_CELL_PHONE];
    self.country_prefix = [dicObject objectForKeyNotNull:kNUM_COUNTRY];
    self.address_1 = [dicObject objectForKeyNotNull:KADDRESS];
    self.address_2 = [dicObject objectForKeyNotNull:KADDRESS2];
    self.region_state = [dicObject objectForKeyNotNull:KSATE];
    self.city = [dicObject objectForKeyNotNull:KCITY];
    self.country = [dicObject objectForKeyNotNull:KCOUNTRY];
}

@end
