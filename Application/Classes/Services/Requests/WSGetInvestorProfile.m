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
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [self setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    [self setHTTPMethod:METHOD_GET];
}
@end
