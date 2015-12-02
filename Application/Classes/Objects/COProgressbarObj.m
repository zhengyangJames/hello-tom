//
//  COProgressbarObj.m
//  CoAssets
//
//  Created by TUONG DANG on 7/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProgressbarObj.h"

@implementation COProgressbarObj

- (instancetype)initWithDictionnary:(NSDictionary*)dic {
    self.current_funded_amount = [dic valueForKey:@"current_funded_amount"];
    self.goal = [dic valueForKey:@"goal"];
    return self;
}

@end
