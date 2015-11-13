//
//  WSPostDeviceTokenRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/12/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

@interface WSPostDeviceTokenRequest : NSMutableURLRequest
- (WSPostDeviceTokenRequest *)setBodyDeviceToken:(NSDictionary *)tokenDic;
- (void)setNotificationList:(NSDictionary *)hederDic;
@end
