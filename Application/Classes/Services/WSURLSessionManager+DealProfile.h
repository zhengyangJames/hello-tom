//
//  WSURLSessionManager+DealProfile.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"
#import "WSGetDealProfileRequest.h"

@interface WSURLSessionManager (DealProfile)

- (void)wsGetDealRequest:(NSDictionary *)dealList handler:(WSURLSessionHandler)handler;
@end
