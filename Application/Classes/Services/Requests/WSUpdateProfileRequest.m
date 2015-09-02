//
//  WSUpdateProfileRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSUpdateProfileRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSUpdateProfileRequest

- (instancetype)initUpdateProfileRequestWithBodyParams:(id)bodyParams {
    NSString *postString = [self paramsToString:bodyParams];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_GET_LIST_PROFILE body:parambody httpMethod:METHOD_PUT];
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    [self setValue:value forHTTPHeaderField:@"Authorization"];
    return self;
}
@end
