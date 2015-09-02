//
//  WSRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

#define kUSER                                       @"username"
#define kPASSWORD                                   @"password"
#define kCLIENT_ID                                  @"client_id"
#define kCLIENT_SECRECT                             @"client_secret"
#define kGRANT_TYPE                                 @"grant_type"

#define CLIENT_ID                                   @"4c6a28b0137ff54909b3"
#define CLIENT_SECRECT                              @"e88e20a9f9d642ed1e7e04ab0b72798b41455377"
#define GRANT_TYPE                                  @"password"

@implementation WSRequest

- (NSString*)stringToLoginWithUserName:(NSString *)userName password:(NSString *)password {
    NSString *s = @"";
    s = [s stringByAppendingFormat:@"%@=%@",kCLIENT_ID,[CLIENT_ID urlEncode]];
    s = [s stringByAppendingFormat:@"&%@=%@",kCLIENT_SECRECT,[CLIENT_SECRECT urlEncode]];
    s = [s stringByAppendingFormat:@"&%@=%@",kGRANT_TYPE,[GRANT_TYPE urlEncode]];
    s = [s stringByAppendingFormat:@"&%@=%@",kUSER,[userName urlEncode]];
    s = [s stringByAppendingFormat:@"&%@=%@",kPASSWORD,[password urlEncode]];
    return s;
}

- (NSString*)paramsToString:(NSDictionary*)params{
    NSString *s = @"";
    NSString *prefix = @"";
    for (NSString *key in [params allKeys]) {
        if ([key isEqualToString:kPROFILE]) {
            NSDictionary *profile = [params objectForKey:kPROFILE];
            for(NSString *key in [profile allKeys]) {
                NSString *object = [profile objectForKey:key];
                if ([object isEqualToString:@""]) {
                    object = @" ";
                }
                s = [s stringByAppendingFormat:@"%@%@=%@",prefix,key,[object urlEncode]];
                prefix = @"&";
            }
            break;
        }
        id object = [params objectForKey:key];
        if ([object isKindOfClass:[NSString class]]) {
            if ([object isEqualToString:@""]) {
                object = @" ";
            }
            s = [s stringByAppendingFormat:@"%@%@=%@",prefix,key,[object urlEncode]];
            prefix = @"&";
        }

    }
    return s;
}

- (id)createAuthRequest:(NSString*)url
                                     body:(NSData*)bodyData
                               httpMethod:(NSString*)method {
    
    NSString *bodyString = @"";
    if(bodyData != nil) {
        bodyString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    }
    // create request
    WSRequest *request = [[WSRequest alloc] initWithURL:[NSURL URLWithString:url]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WS_TIME_OUT];
    [request setHTTPMethod:[method uppercaseString]];
    [request setHTTPBody:bodyData];
    [request setTimeoutInterval:WS_TIME_OUT];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}
@end
