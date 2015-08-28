//
//  WSURLSessionManager+User.m
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+User.h"
#import "COUserProfileModel.h"

@implementation WSURLSessionManager (User)

- (void)wsLoginWithUserInfo:(NSDictionary *)param handler:(WSURLSessionHandler)handler {
    NSString *postString = [self paramsToString:param];
    NSData *body = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_POST_LOGIN body:body httpMethod:METHOD_POST];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsRegisterWithInfo:(NSDictionary *)param handler:(WSURLSessionHandler)handler {
    NSString *postString = [self paramsToString:param];
    NSData *body = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_POST_REFISTER body:body httpMethod:METHOD_POST];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsForgotPassword:(NSDictionary *)param handler:(WSURLSessionHandler)handler {
    NSString *postString = [self paramsToString:param];
    NSData *body = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_POST_PORGOT_PASSWORD
                                                      body:body
                                                httpMethod:METHOD_POST];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsChangePassword:(COUserProfileModel *)paramToken body:(NSDictionary*)body handler:(WSURLSessionHandler)handler {
    NSString *value = [NSString stringWithFormat:@"%@ %@",paramToken.stringOfTokenType,paramToken.stringOfAccessToken];
    NSString *postString = [self paramsToString:body];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_POST_CHANGE_PASSWORD
                                                      body:parambody
                                                httpMethod:METHOD_POST];
    [request setValue:value forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}
@end
