//
//  CODetailsOffersObject.m
//  CoAssets
//
//  Created by TUONG DANG on 7/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsOffersObject.h"

@implementation CODetailsOffersObject

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        self.imageBig = [dic objectForKeyNotNull:@"add_1"];
//        self.imageSmall = [dic objectForKeyNotNull:@"add_2"];
//        self.detailsShort = [dic objectForKeyNotNull:@"name"];
//        self.phone = [dic objectForKeyNotNull:@"phone_no"];
//        self.country = [dic objectForKeyNotNull:@"country"];
//        self.regNo = [dic objectForKeyNotNull:@"reg_no"];
//        self.postCode = [dic objectForKeyNotNull:@"postal_code"];
//        self.city = [dic objectForKeyNotNull:@"city"];
    }
    return self;
}


@end
