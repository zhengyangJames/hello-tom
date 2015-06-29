//
//  WSURLSessionManager+Profile.m
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Profile.h"
#import "COListProfileObject.h"

@implementation WSURLSessionManager (Profile)

- (void)wsGetProfileWithUserToken:(NSDictionary*)paramToken handler:(WSURLSessionHandler)handler {
    NSString *value = [NSString stringWithFormat:@"%@ %@",[paramToken  valueForKey:kTOKEN_TYPE],[paramToken valueForKey:kACCESS_TOKEN]];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_GET_LIST_PROFIEL body:nil httpMethod:METHOD_GET];
    [request setValue:value forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            COListProfileObject *objContac = [[COListProfileObject alloc]initWithDictionary:responseObject];
            if (handler) {
                handler(objContac,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsUpdateProfileWithUserToken:(NSDictionary *)paramToken body:(NSDictionary *)body handler:(WSURLSessionHandler)handler {
    NSString *postString = [self paramsToString:body];
    NSData *paramBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *value = [NSString stringWithFormat:@"%@ %@",[paramToken  valueForKey:kTOKEN_TYPE],[paramToken valueForKey:kACCESS_TOKEN]];
    NSMutableURLRequest *request = [self createAuthRequest:WS_METHOD_GET_LIST_PROFIEL
                                                      body:paramBody
                                                httpMethod:METHOD_GET];
    [request setValue:value forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

@end
