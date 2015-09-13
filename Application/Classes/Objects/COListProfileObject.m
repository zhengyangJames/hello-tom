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
      //  self.username = [dic objectForKeyNotNull:kUSER];
        self.first_name = [dic objectForKeyNotNull:KFRIST_NAME];
        self.last_name = [dic objectForKeyNotNull:KLAST_NAME];
        self.email = [dic objectForKeyNotNull:KEMAIL];
        self.cell_phone = [dic objectForKeyNotNull:kNUM_CELL_PHONE];
        self.country_prefix = [dic objectForKeyNotNull:kNUM_COUNTRY];
        self.address_1 = [dic objectForKeyNotNull:KADDRESS];
        self.address_2 = [dic objectForKeyNotNull:KADDRESS2];
        self.region_state = [dic objectForKeyNotNull:KSATE];
        self.city = [dic objectForKeyNotNull:KCITY];
        self.country = [dic objectForKeyNotNull:KCOUNTRY];
    }
    return self;
}

- (NSDictionary*)getProfileObject {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (self.username) {
    //    dic[kUSER] = self.username ;
    }
    if (self.first_name ) {
        dic[KFRIST_NAME] = self.first_name ;
    }
    if (self.last_name) {
        dic[KLAST_NAME] = self.last_name ;
    }
    if (self.email) {
        dic[KEMAIL] = self.email ;
    }
    if (self.cell_phone) {
        dic[kNUM_CELL_PHONE] = self.cell_phone ;
    }
    if (self.country_prefix) {
        dic[kNUM_COUNTRY] = self.country_prefix ;
    }
    if (self.address_1) {
        dic[KADDRESS] = self.address_1 ;
    }
    if (self.address_2) {
        dic[KADDRESS2] = self.address_2;
    }
    if (self.city) {
        dic[KCITY] = self.city;
    }
    if (self.country) {
        dic[KCOUNTRY] = self.country;
    }
    if (self.region_state) {
        dic[KSATE] = self.region_state ;
    }
    return dic;
}

- (void)setProfileObject:(NSDictionary*)dicObject {
  //  if ([dicObject objectForKeyNotNull:kUSER]) {
  //      self.username = [dicObject objectForKeyNotNull:kUSER];
    //}
    if ([dicObject objectForKeyNotNull:KFRIST_NAME]) {
        self.first_name = [dicObject objectForKeyNotNull:KFRIST_NAME];
    }
    if ([dicObject objectForKeyNotNull:KLAST_NAME]) {
        self.last_name = [dicObject objectForKeyNotNull:KLAST_NAME];
    }
    if ([dicObject objectForKeyNotNull:KEMAIL]) {
        self.email = [dicObject objectForKeyNotNull:KEMAIL];
    }
    if ([dicObject objectForKeyNotNull:kNUM_CELL_PHONE]) {
        self.cell_phone = [dicObject objectForKeyNotNull:kNUM_CELL_PHONE];
    }
    if ([dicObject objectForKeyNotNull:kNUM_COUNTRY]) {
        self.country_prefix = [dicObject objectForKeyNotNull:kNUM_COUNTRY];
    }
    if ([dicObject objectForKeyNotNull:KADDRESS]) {
        self.address_1 = [dicObject objectForKeyNotNull:KADDRESS];
    }
    if ([dicObject objectForKeyNotNull:KADDRESS2]) {
        self.address_2 = [dicObject objectForKeyNotNull:KADDRESS2];
    }
    if ([dicObject objectForKeyNotNull:KSATE]) {
        self.region_state = [dicObject objectForKeyNotNull:KSATE];
    }
    if ([dicObject objectForKeyNotNull:KCITY]) {
        self.city = [dicObject objectForKeyNotNull:KCITY];
    }
    if ([dicObject objectForKeyNotNull:KCOUNTRY]) {
        self.country = [dicObject objectForKeyNotNull:KCOUNTRY];
    }
}

@end
