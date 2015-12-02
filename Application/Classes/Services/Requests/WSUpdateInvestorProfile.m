//
//  WSUpdateInvestorProfile.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSUpdateInvestorProfile.h"
#import "COUserInverstorModel.h"
#import "COLoginManager.h"

@implementation WSUpdateInvestorProfile

- (void)setRequestWithTOken {
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [self setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    [self setURL:[NSURL URLWithString:WS_METHOD_GET_PROFILE_INVESTER]];
}

@end
