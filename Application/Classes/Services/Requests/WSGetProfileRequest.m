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
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSString *headerString = [NSString stringWithFormat:@"%@ %@",[tokenData objectForKeyNotNull:kTOKEN_TYPE], [tokenData objectForKeyNotNull:kACCESS_TOKEN]];
    NSDictionary *headers = @{ @"Authorization": headerString };
    [self setHTTPMethod:METHOD_GET];
    [self setAllHTTPHeaderFields:headers];

}


@end
