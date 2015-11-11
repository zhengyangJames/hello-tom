//
//  WSURLSessionManager+Profile.h
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"
#import "WSUpdateInvestorProfile.h"

@class COUserProfileModel;
@class WSUpdateProfileRequest;

@interface WSURLSessionManager (Profile)

- (void)wsGetProfileWithUserToken:(NSDictionary *)paramToken handler:(WSURLSessionHandler)handler;
- (void)wsUpdateProfileWithRequest:(WSUpdateProfileRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsGetAccountInvestment:(NSDictionary *)paramToken handler:(WSURLSessionHandler)handler;
- (void)wsGetInvestorProfile:(NSDictionary *)paramToken handler:(WSURLSessionHandler)handler;
- (void)wsUpdateInvestorProfile:(WSUpdateInvestorProfile*)request handler:(WSURLSessionHandler)handler;
@end
