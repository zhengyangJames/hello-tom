//
//  WSURLSessionManager+User.h
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@class COUserProfileModel;
@class WSLoginRequest;
@class WSRegisterRequest;
@class WSForgotPassWordRequest;
@class WSChangePassWordRequest;

@interface WSURLSessionManager (User)

- (void)wsLoginWithRequest:(WSLoginRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsRegisterWithRequest:(WSRegisterRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsForgotPasswordWithRequest:(WSForgotPassWordRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsChangePasswordWithRequest:(WSChangePassWordRequest *)request handler:(WSURLSessionHandler)handler;

@end
