//
//  WSURLSessionManager+User.h
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@class COUserProfileModel;

@interface WSURLSessionManager (User)

- (void)wsLoginWithRequest:(id)request handler:(WSURLSessionHandler)handler;
- (void)wsRegisterWithRequest:(id)request handler:(WSURLSessionHandler)handler;
- (void)wsForgotPasswordWithRequest:(id)request handler:(WSURLSessionHandler)handler;
- (void)wsChangePasswordWithRequest:(id)request handler:(WSURLSessionHandler)handler;

@end
