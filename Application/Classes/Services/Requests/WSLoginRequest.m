//
//  WSCreateUserRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSLoginRequest.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"

@implementation WSLoginRequest

- (instancetype)initLoginRequestWithUserName:(NSString *)userName passWord:(NSString *)password {
    NSString *postString = [self stringToLoginWithUserName:userName password:password];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_POST_LOGIN body:parambody httpMethod:METHOD_POST];
    return self;
}

@end
