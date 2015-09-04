//
//  WSGetProFileRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSGetProFileRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSGetProfileRequest

-(void)setValueWithTokenData:(NSDictionary *)tokenData {
    NSString *postString = [self paramsToString:tokenData];
     NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [self setHTTPBody:parambody];
    if ([tokenData objectForKey:kTOKEN_TYPE] && [tokenData objectForKey:kACCESS_TOKEN]) {
        NSString *value = [NSString stringWithFormat:@"%@ %@",[tokenData  valueForKey:kTOKEN_TYPE],[tokenData valueForKey:kACCESS_TOKEN]];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self setValue:value forHTTPHeaderField:@"Authorization"];
    }
}
@end
