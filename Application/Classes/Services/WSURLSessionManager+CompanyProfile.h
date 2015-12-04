//
//  WSURLSessionManager+CompanyProfile.h
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (CompanyProfile)
- (void)wsPostDeviceTokenRequestHandler:(WSURLSessionHandler)handler;
- (void)wsGetDealRequestHandler:(WSURLSessionHandler)handler;
@end
