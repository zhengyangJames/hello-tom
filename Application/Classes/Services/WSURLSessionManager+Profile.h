//
//  WSURLSessionManager+Profile.h
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (Profile)
- (void)wsGetProfileWithUserToken:(NSDictionary*)paramToken handler:(WSURLSessionHandler)handler;
- (void)wsUpdateProfileWithUserToken:(NSDictionary*)paramToken body:(NSDictionary*)body handler:(WSURLSessionHandler)handler;
@end
