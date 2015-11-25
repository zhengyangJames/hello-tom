//
//  WSGetAccountInvestment.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSGetAccountInvestment.h"

@implementation WSGetAccountInvestment

- (void)setHeaderWithToken:(NSDictionary *)tokenDic {
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [self setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    [self setHTTPMethod:METHOD_GET];
}

@end
