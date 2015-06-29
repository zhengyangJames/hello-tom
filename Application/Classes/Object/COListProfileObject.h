//
//  AboutProfileObject.h
//  CoAssest
//
//  Created by TUONG DANG on 6/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COListProfileObject : NSObject

@property (strong, nonatomic) NSString *country_prefix;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *first_name;
@property (strong, nonatomic) NSString *last_name;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *cell_phone;
@property (strong, nonatomic) NSString *address_1;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *region_state;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *account_type;
@property (strong, nonatomic) NSString *account_expiry;
- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end
