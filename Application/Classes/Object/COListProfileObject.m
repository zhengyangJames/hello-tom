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
        self.region_state = [dicProfile objectForKeyNotNull:@"region_state"];
        self.city = [dicProfile objectForKeyNotNull:@"city"];
        self.country = [dicProfile objectForKeyNotNull:@"country"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.first_name forKey:@"first_name"];
    [encoder encodeObject:self.last_name forKey:@"last_name"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.cell_phone forKey:@"cellphone"];
    [encoder encodeObject:self.country_prefix forKey:@"country_prefix"];
    [encoder encodeObject:self.address_1 forKey:@"address_1"];
    [encoder encodeObject:self.region_state forKey:@"region_state"];
    [encoder encodeObject:self.city forKey:@"city"];
    [encoder encodeObject:self.country forKey:@"country"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.username       = [decoder decodeObjectForKey:@"username"];
        self.first_name     = [decoder decodeObjectForKey:@"first_name"];
        self.last_name      = [decoder decodeObjectForKey:@"last_name"];
        self.email          = [decoder decodeObjectForKey:@"email"];
        self.cell_phone     = [decoder decodeObjectForKey:@"cellphone"];
        self.country_prefix = [decoder decodeObjectForKey:@"country_prefix"];
        self.address_1      = [decoder decodeObjectForKey:@"address_1"];
        self.region_state   = [decoder decodeObjectForKey:@"region_state"];
        self.city           = [decoder decodeObjectForKey:@"city"];
        self.country        = [decoder decodeObjectForKey:@"country"];
    }
    return self;
}



@end
