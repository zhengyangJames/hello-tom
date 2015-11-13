//
//  WSURLSessionManager+Notification.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/11/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Notification.h"

@implementation WSURLSessionManager (Notification)


- (void)wsPostDeviceTokenRequest:(NSDictionary *)pagaBody handler:(WSURLSessionHandler)handler {
    
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    request = [request setBodyDeviceToken:pagaBody];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
            }
        } else {
            if (handler) {
            }
        }
    }];
}



- (void)wsGetNotificationListRequest:(NSDictionary *)listDic handler:(WSURLSessionHandler)handler {
    
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    
    [request setValue:CONTENT_TYPE_GET forHTTPHeaderField:@"content-type"];
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", WS_ACCESS_TOKEN];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    NSString *paramenter = [NSString stringWithFormat:@"%@?%@&%@&%@",WS_METHOD_GET_NOTIFICATION_TOKEN_LIST,device_token,device_type,application_name];
    [request setURL:[NSURL URLWithString:paramenter]];

    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
            }
        } else {
            if (handler) {
            }
        }
    }];
    
}

@end
