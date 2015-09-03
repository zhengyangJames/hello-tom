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

- (instancetype)initGetProfileRequestWithParamsToken:(id)paramToken {
    NSString *postString = [self paramsToString:paramToken];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_GET_LIST_PROFILE body:parambody httpMethod:METHOD_GET];
    if ([[COLoginManager shared] userModel]) {
        COUserProfileModel *userModel = [[COLoginManager shared] userModel];
        NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
        [self setValue:value forHTTPHeaderField:@"Authorization"];
    } else {
        if ([paramToken objectForKey:kTOKEN_TYPE] && [paramToken objectForKey:kACCESS_TOKEN]) {
            NSString *value = [NSString stringWithFormat:@"%@ %@",[paramToken  valueForKey:kTOKEN_TYPE],[paramToken valueForKey:kACCESS_TOKEN]];
            [[NSURLCache sharedURLCache] removeAllCachedResponses];
            [self setValue:value forHTTPHeaderField:@"Authorization"];
        }
    }
    return self;
}

@end
