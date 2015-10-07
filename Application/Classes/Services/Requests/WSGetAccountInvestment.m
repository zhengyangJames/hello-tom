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
    NSString *headerString = [NSString stringWithFormat:@"%@ %@",[tokenDic objectForKeyNotNull:kTOKEN_TYPE], [tokenDic objectForKeyNotNull:kACCESS_TOKEN]];
    NSDictionary *headers = @{ @"Authorization": headerString };
    [self setHTTPMethod:METHOD_GET];
    [self setAllHTTPHeaderFields:headers];
}

@end
