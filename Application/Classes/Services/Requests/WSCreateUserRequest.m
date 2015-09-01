//
//  WSCreateUserRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSCreateUserRequest.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"

@implementation WSCreateUserRequest

- (NSMutableURLRequest *)requestWithUserInfo:(NSDictionary *)userInfo paramToken:(NSDictionary*)paramToken url:(NSString *)url httpMethod:(NSString *)method valueToken:(BOOL)isValue {
    NSString *postString;
    if (!paramToken) {
       postString = [self paramsToString:userInfo user:self.user password:self.password];
    }
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *bodyString = @"";
    if(parambody != nil) {
        bodyString = [[NSString alloc] initWithData:parambody encoding:NSUTF8StringEncoding];
    }
    NSMutableURLRequest *request = [self createAuthRequest:url body:parambody httpMethod:method];
    if (isValue) {
        if ([[COLoginManager shared] userModel]) {
            COUserProfileModel *userModel = [[COLoginManager shared] userModel];
            NSString *value = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
            [request setValue:value forHTTPHeaderField:@"Authorization"];
        } else {
            if ([paramToken objectForKey:kTOKEN_TYPE] && [paramToken objectForKey:kACCESS_TOKEN]) {
                NSString *value = [NSString stringWithFormat:@"%@ %@",[paramToken  valueForKey:kTOKEN_TYPE],[paramToken valueForKey:kACCESS_TOKEN]];
                [[NSURLCache sharedURLCache] removeAllCachedResponses];
                [request setValue:value forHTTPHeaderField:@"Authorization"];
            }
        }
    }
    return request;
}
@end
