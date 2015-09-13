//
//  CODetailsProfileObj+Mapping.m
//  CoAssets
//
//  Created by TUONG DANG on 8/13/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsProfileObj+Mapping.h"

@implementation CODetailsProfileObj (Mapping)

- (CODetailsOffersObj*)mappingDetailsProfileObjects:(NSDictionary*)ObjDic {
    CODetailsOffersObj *obj = [[CODetailsOffersObj alloc]init];
    if (ObjDic) {
        self.investor_count = [ObjDic objectForKeyNotNull:@"investor_count"];
        self.status = [ObjDic objectForKeyNotNull:@"status"];
        self.annualized_return = [ObjDic valueForKeyNotNull:@"annualized_return"];
        self.min_investment = [ObjDic objectForKeyNotNull:@"min_investment"];
        self.day_left = [ObjDic objectForKeyNotNull:@"day_left"];
        self.time_horizon = [ObjDic objectForKeyNotNull:@"time_horizon"];
        [obj setDetailsOffersItemProfileObj:self type:@"Profile"];
    }
    return obj;
}


@end
