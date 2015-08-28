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

- (void)wsLoginWithUserInfo:(NSDictionary *)param handler:(WSURLSessionHandler)handler;
- (void)wsRegisterWithInfo:(NSDictionary*)param handler:(WSURLSessionHandler)handler;
- (void)wsForgotPassword:(NSDictionary*)param handler:(WSURLSessionHandler)handler;
- (void)wsChangePassword:(COUserProfileModel *)paramToken body:(NSDictionary*)body handler:(WSURLSessionHandler)handler;

@end
