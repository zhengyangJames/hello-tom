//
//  WSPostDeviceTokenRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/12/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSPostDeviceTokenRequest.h"

@implementation WSPostDeviceTokenRequest

- (WSPostDeviceTokenRequest *)setBodyDeviceToken:(NSDictionary *)tokenDic {
    
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    NSString *strBody = [NSString stringWithFormat:@"device_token=%@&device_type=%@&application_name=%@&client_key=%@",@"wwwww",[tokenDic objectForKey:device_type_dic],[tokenDic objectForKey:application_name_dic],[tokenDic objectForKey:client_key_dic]];
    NSData *dataStr = [strBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:dataStr];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_POST_NOTIFICATION_TOKEN]];
    [request setValue:CONTENT_TYPE forHTTPHeaderField:@"content_type"];
    return request;
}

- (void)setNotificationList:(NSDictionary *)hederDic {

    [self setAllHTTPHeaderFields:hederDic];
    [self setHTTPMethod:METHOD_GET];
}

@end
