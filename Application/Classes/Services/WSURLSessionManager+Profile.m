//
//  WSURLSessionManager+Profile.m
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Profile.h"
#import "COListProfileObject.h"
#import "COUserProfileModel.h"
#import "WSURLSessionManager+User.h"
#import "COLoginManager.h"

@implementation WSURLSessionManager (Profile)

- (void)wsGetProfileWithUserToken:(NSDictionary*)paramToken handler:(WSURLSessionHandler)handler {
    NSString *value = [NSString stringWithFormat:@"%@ %@",[paramToken  valueForKey:kTOKEN_TYPE],[paramToken valueForKey:kACCESS_TOKEN]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_GET_LIST_PROFIEL body:nil httpMethod:METHOD_GET];
    [request setValue:value forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutaDic = [NSMutableDictionary dictionary];
            [mutaDic addEntriesFromDictionary:paramToken];
            [mutaDic addEntriesFromDictionary:responseObject];
            if (handler) {
                handler(mutaDic,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsUpdateProfileWithUserToken:(COUserProfileModel *)paramToken body:(NSDictionary *)body handler:(WSURLSessionHandler)handler {
    NSString *postString = [self paramsToString:body];
    NSData *paramBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *value = [NSString stringWithFormat:@"%@ %@",paramToken.stringOfTokenType,paramToken.stringOfAccessToken];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_GET_LIST_PROFIEL
                                                      body:paramBody
                                                httpMethod:METHOD_PUT];
    [request setValue:value forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            [[COLoginManager shared] callAPILogin:^(id object, BOOL sucess) {
                if (sucess && [object isKindOfClass:[NSDictionary class]]) {
                    if (handler) {
                        handler(object,response,nil);
                    }
                }
            }];
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}
- (NSMutableDictionary*)_createParamTokenWithModel:(COUserProfileModel *)model {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = model.stringOfAccessToken;
    dic[kTOKEN_TYPE] = model.stringOfTokenType;
    return dic;
}

- (NSMutableDictionary*)_creatUserInfo {
    NSMutableDictionary *param = [NSMutableDictionary new];
    param[kCLIENT_ID] = CLIENT_ID;
    param[kCLIENT_SECRECT] = CLIENT_SECRECT;
    param[kGRANT_TYPE] = GRANT_TYPE;
    if (![kUserDefaults objectForKey:kUSER]) {
        param[kUSER] = @"";
    } else {
        param[kUSER] = [kUserDefaults objectForKey:kUSER];
    }
    if (![kUserDefaults objectForKey:kPASSWORD]) {
        param[kPASSWORD] = @"";
    } else {
        param[kPASSWORD] = [kUserDefaults objectForKey:kPASSWORD];
    }
    return param;
}
@end
