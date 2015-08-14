//
//  COLIstOffersObject.m
//  CoAssets
//
//  Created by TUONG DANG on 6/24/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COListOffersObject.h"

@implementation COListOffersObject

- (instancetype)initWithDictionary:(NSDictionary*)dic {
    self = [super init];
    if (self) {
        self.offerTitle = [dic objectForKeyNotNull:@"offer_title"];
        self.offerType = [dic objectForKeyNotNull:@"offer_type"];
        self.offerID = [dic objectForKeyNotNull:@"id"];
        NSDictionary *objProject = [dic objectForKeyNotNull:@"project"];
        self.offerPhoto = [objProject objectForKeyNotNull:@"photo"];
        self.offerCountry = [objProject objectForKeyNotNull:@"country"];
        self.offerProjectID = [objProject objectForKeyNotNull:@"id"];
    }
    return self;
}


@end
