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
#import "WSLoginRequest.h"
#import "WSRegisterRequest.h"
#import "WSForgotPassWordRequest.h"
#import "WSChangePassWordRequest.h"

@implementation WSURLSessionManager (User)

- (void)wsLoginWithRequest:(WSLoginRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request requiredLogin:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsRegisterWithRequest:(WSRegisterRequest *)request handler:(WSURLSessionHandler)handler;{
    [self sendRequest:request requiredLogin:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsForgotPasswordWithRequest:(WSForgotPassWordRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request requiredLogin:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsChangePasswordWithRequest:(WSChangePassWordRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request requiredLogin:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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
