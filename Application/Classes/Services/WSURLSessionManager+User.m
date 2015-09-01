//
//  WSURLSessionManager+User.m
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+User.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"
#import "WSCreateUserRequest.h"

@implementation WSURLSessionManager (User)

- (void)wsLoginWithUserInfo:(id)info handler:(WSURLSessionHandler)handler {
    WSCreateUserRequest *userRequest = info;
    NSMutableURLRequest *request = [userRequest requestWithUserInfo:nil paramToken:nil url:WS_METHOD_POST_LOGIN httpMethod:METHOD_POST valueToken:NO];
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

- (void)wsRegisterWithInfo:(NSDictionary*)info handler:(WSURLSessionHandler)handler {
    WSCreateUserRequest *userRequest = [[WSCreateUserRequest alloc] init];
    NSMutableURLRequest *request = [userRequest requestWithUserInfo:info paramToken:nil url:WS_METHOD_POST_REGISTER httpMethod:METHOD_POST valueToken:NO];
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
    WSCreateUserRequest *userRequest = [[WSCreateUserRequest alloc] init];
    NSMutableURLRequest *request = [userRequest requestWithUserInfo:param paramToken:nil url:WS_METHOD_POST_PORGOT_PASSWORD httpMethod:METHOD_POST valueToken:NO];
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

- (void)wsChangePasswordWithBody:(NSDictionary*)body handler:(WSURLSessionHandler)handler {
    WSCreateUserRequest *userRequest = [[WSCreateUserRequest alloc] init];
    NSMutableURLRequest *request = [userRequest requestWithUserInfo:body paramToken:nil url:WS_METHOD_POST_CHANGE_PASSWORD httpMethod:METHOD_POST valueToken:YES];
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
