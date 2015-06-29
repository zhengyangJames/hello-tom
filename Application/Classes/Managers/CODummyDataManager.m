//
//  CODummyDataManager.m
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODummyDataManager.h"
#import "ContactObject.h"


@implementation CODummyDataManager

+ (instancetype)shared {
    static CODummyDataManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}



- (ProfileObject*)AboutProfileObj {
    ProfileObject *obj = [[ProfileObject alloc]init];
    obj.salutation = @"Mr";
    obj.firstname = @"Daniel";
    obj.lastnameurname = @"NGUYEN";
    obj.email = @"email@example.com";
    obj.phone = @"010101011";
    obj.address = @"1st street 2rd NewYork";
    obj.image = @"6.jpg";
    obj.orgname = @"Nikmesoft Ltd";
     
    return obj;
}


@end
