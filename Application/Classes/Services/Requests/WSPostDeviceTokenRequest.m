//
//  WSPostDeviceTokenRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/12/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSPostDeviceTokenRequest.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"

@implementation WSPostDeviceTokenRequest

- (NSString *)_accessToken {
    
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *headerString = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    return headerString;
}

- (WSPostDeviceTokenRequest *)setBodyDeviceToken:(NSDictionary *)tokenDic {
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    NSString *strBody = [NSString stringWithFormat:@"device_token=%@&device_type=%@&application_name=%@&client_key=%@",[tokenDic objectForKey:device_token_dic],[tokenDic objectForKey:device_type_dic],[tokenDic objectForKey:application_name_dic],[tokenDic objectForKey:client_key_dic]];
    NSData *dataStr = [strBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:dataStr];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_POST_NOTIFICATION_TOKEN]];
    [request setValue:CONTENT_TYPE forHTTPHeaderField:@"content_type"];
    return request;
}

- (WSPostDeviceTokenRequest *)getNotificationList:(NSDictionary *)paraDic {
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    [request addValue:CONTENT_TYPE_GET forHTTPHeaderField:@"content-type"];
    [request setValue:@"Bearer jjMSqa8Q9f66HWvEJmIBYkxbzIao4Z" forHTTPHeaderField:@"Authorization"];
    NSString *paramenter = [NSString stringWithFormat:@"%@?device_token=%@&device_type=%@&application_name=%@",WS_METHOD_GET_NOTIFICATION_TOKEN_LIST,[paraDic objectForKey:device_token_dic],[paraDic objectForKey:device_type_dic],[paraDic objectForKey:application_name_dic]];
    [request setURL:[NSURL URLWithString:paramenter]];
    
    return request;
}

- (WSPostDeviceTokenRequest *)readNotificationList:(NSDictionary *)bodyDict {
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    
    [request setHTTPMethod:METHOD_POST];
    [request setURL: [NSURL URLWithString:@"https://www.coassets.com/api/read-notification/"]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request addValue:[self _accessToken] forHTTPHeaderField:@"Authorization"];
    NSString *strBody = [NSString stringWithFormat:@"device_token=%@&device_type=%@&application_name=%@&client_key=%@&notification_status=%@&notification_id=%@",[bodyDict objectForKey:device_token_dic],[bodyDict objectForKey:device_type_dic],[bodyDict objectForKey:application_name_dic],[bodyDict objectForKey:client_key_dic], [bodyDict objectForKey:NOTIFICATION_STATUS_DICT],[bodyDict objectForKey:NOTIFICATION_ID_DICT]];
    NSData *dataStr = [strBody dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:dataStr];

    return request;
}

@end
