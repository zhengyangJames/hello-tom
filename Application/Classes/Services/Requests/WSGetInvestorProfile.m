//
//  WSGetInvestorProfile.m
//  CoAssets
//
//  Created by Tony Tuong on 10/13/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSGetInvestorProfile.h"

@implementation WSGetInvestorProfile
- (void)setRequestWithToken:(NSDictionary*)tokenData {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //NSString *headerString = [NSString stringWithFormat:@"%@ %@",[tokenData objectForKeyNotNull:kTOKEN_TYPE], [tokenData objectForKeyNotNull:kACCESS_TOKEN]];
    NSDictionary *headers = @{ @"Authorization": [kUserDefaults objectForKey:KEY_ACCESS_TOKEN] };
    [self setHTTPMethod:METHOD_GET];
    [self setAllHTTPHeaderFields:headers];
}
@end
