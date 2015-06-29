//
//  WSURLSessionManager+User.h
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (User)

- (void)wsLoginWithUser:(NSDictionary*)param handler:(WSURLSessionHandler)handler;
- (void)wsRegisterWithInfo:(NSDictionary*)param handler:(WSURLSessionHandler)handler;

@end