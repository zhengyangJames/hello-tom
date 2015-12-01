//
//  WSGetDealProfileRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSGetDealProfileRequest.h"
#import "COLoginManager.h"

@implementation WSGetDealProfileRequest

- (NSString *)_accessToken {
    
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *headerString = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    return headerString;
}

- (WSGetDealProfileRequest *)getDealList:(NSDictionary *)dealDic {
    WSGetDealProfileRequest *request = [[WSGetDealProfileRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    [request addValue:CONTENT_TYPE_GET forHTTPHeaderField:@"content-type"];
    [request setValue:[self _accessToken] forHTTPHeaderField:@"Authorization"];
    NSString *paramenter = [NSString stringWithFormat:@"%@?device_token=%@&device_type=%@&application_name=%@",WS_METHOD_GET_DEAL_LIST,[dealDic objectForKey:device_token_dic],[dealDic objectForKey:device_type_dic],[dealDic objectForKey:application_name_dic]];
    [request setURL:[NSURL URLWithString:paramenter]];
    
    return request;
}

@end
