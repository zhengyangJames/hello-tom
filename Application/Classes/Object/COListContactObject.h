//
//  COListContactObject.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface COListContactObject : NSObject

@property (strong, nonatomic) NSString *address_1;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address_2;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *postCode;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *regNo;

- (instancetype)initWithDictionary:(NSDictionary*)dic;

@end
