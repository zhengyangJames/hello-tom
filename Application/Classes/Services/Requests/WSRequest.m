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

@interface WSRequest() {
    NSString *bodyString;
}

@end

@implementation WSRequest

- (id)init {
    self = [super init];
    if (self) {        bodyString = @"";
        bodyString = [bodyString stringByAppendingFormat:@"%@=%@",kCLIENT_ID,[CLIENT_ID urlEncode]];
        bodyString = [bodyString stringByAppendingFormat:@"&%@=%@",kCLIENT_SECRECT,[CLIENT_SECRECT urlEncode]];
        bodyString = [bodyString stringByAppendingFormat:@"&%@=%@",kGRANT_TYPE,[GRANT_TYPE urlEncode]];
        NSData *parambody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        [self setHTTPBody:parambody];
        [self setCachePolicy:NSURLRequestUseProtocolCachePolicy];
        [self setTimeoutInterval:WS_TIME_OUT];
        [self setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}
#pragma mark - func set
- (void)setBodyParam:(NSString *)param forKey:(NSString *)key {
    bodyString = [bodyString stringByAppendingFormat:@"&%@=%@",key,[param urlEncode]];
    NSData *parambody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [self setHTTPBody:parambody];
}

- (void)setURLWithString:(NSString *)url {
    [self setURL:[NSURL URLWithString:url]];
}

- (void)setMethodWithString:(NSString *)method {
    [self setHTTPMethod:[method uppercaseString]];
}

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
    
    // create request
    WSRequest *request = [[WSRequest alloc] initWithURL:[NSURL URLWithString:url]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WS_TIME_OUT];
    [request setHTTPMethod:[method uppercaseString]];
    [request setHTTPBody:bodyData];
    return request;
}
@end
