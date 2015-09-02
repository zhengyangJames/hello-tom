//
//  WSChangePassWordRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSChangePassWordRequest.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@implementation WSChangePassWordRequest

- (instancetype)initChangePassWordRequestWithNewPassWord:(NSString *)password {
    NSMutableDictionary *bodyInfo = [[NSMutableDictionary alloc] init];
    if (password) {
        [bodyInfo setObject:password forKey:@"new_password"];
    }
    NSString *postString = [self paramsToString:bodyInfo];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_POST_CHANGE_PASSWORD body:parambody httpMethod:METHOD_POST];
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    [self setValue:value forHTTPHeaderField:@"Authorization"];
    return self;
}
@end