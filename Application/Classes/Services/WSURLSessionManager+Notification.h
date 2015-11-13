//
//  WSURLSessionManager+Notification.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/11/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"
#import "WSPostDeviceTokenRequest.h"

@interface WSURLSessionManager (Notification)

- (void)wsPostDeviceTokenRequest:(NSDictionary *)pagaBody handler:(WSURLSessionHandler)handler;
- (void)wsGetNotificationListRequest:(NSDictionary *)listDic handler:(WSURLSessionHandler)handler;
@end
