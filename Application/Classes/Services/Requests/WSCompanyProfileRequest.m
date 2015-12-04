//
//  WSCompanyProfileRequest.m
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSCompanyProfileRequest.h"

@implementation WSCompanyProfileRequest

- (void)postCompanyProfile {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_COMPANY_PROFILE]];
    [request setValue:CONTENT_TYPE forHTTPHeaderField:@"content_type"];
}

- (WSCompanyProfileRequest *)getCompanyProfile {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    [request setValue:[kUserDefaults objectForKey:KEY_ACCESS_TOKEN] forHTTPHeaderField:@"Authorization"];
    [request setURL:[NSURL URLWithString:WS_METHOD_COMPANY_PROFILE]];
    return request;
}
@end
