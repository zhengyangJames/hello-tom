//
//  CODetailsOffersObj.m
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsOffersObj.h"


@implementation CODetailsOffersObj

- (void)setDetailsOffersItemObj:(CODetailsOffersItemObj*)obj type:(NSString*)type {
    self.offerItemObjs = @[obj];
    self.type = type;
}

- (void)setDetailsOffersItemProfileObj:(CODetailsProfileObj*)obj type:(NSString *)type {
    self.offerItemObjs = @[obj];
    self.type = type;
}

- (void)setDetailsOffersItemDocument:(NSArray*)obj type:(NSString *)type {
    self.offerItemObjs = obj;
    self.type = type;
}

@end
