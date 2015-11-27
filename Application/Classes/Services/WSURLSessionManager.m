//
//  WSURLSessionManager.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"
#import "AFNetworking.h"

@interface WSURLSessionManager ()
{
    BOOL _isCheckUnknownError;
}
@property (nonatomic, strong) NSOperationQueue *serviceQueue;
@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation WSURLSessionManager

+ (WSURLSessionManager*)shared {
    static WSURLSessionManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _urlSession = [NSURLSession sharedSession];
    }
    return self;
}

#pragma mark - REQUESTS

- (NSString*)paramsToString:(NSDictionary*)params
{
    NSString *s = @"";
    if(!params) return s;
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
        NSString *object = [params objectForKey:key];
        if ([object isEqualToString:@""]) {
            object = @" ";
        }
        s = [s stringByAppendingFormat:@"%@%@=%@",prefix,key,[object urlEncode]];
        prefix = @"&";
    }
    return s;
}

- (NSString*)buildURL:(NSString*)url byParams:(NSDictionary*)params
{
    if(!url) return url;
    if(!params) return url;
    NSString *value = @"";
    
    NSString *prefix = @"?";
    if([url rangeOfString:@"?"].length > 0)
    {
        prefix = @"&";
    }
    for (NSString *key in [params allKeys]) {
        if([params objectForKey:key]) {
            value = [[NSString stringWithFormat:@"%@", [params objectForKey:key]] urlEncode];
        }
        url = [url stringByAppendingFormat:@"%@%@=%@",prefix,key,value];
        prefix = @"&";
    }
    return url;
}

- (NSMutableURLRequest*)_createMultipartAuthRequest:(NSString*)url
                                               body:(NSData*)bodyData
                                         httpMethod:(NSString*)method {
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WS_TIME_OUT];
    [request setHTTPMethod:[method uppercaseString]];
    [request setHTTPBody:bodyData];
    [request setTimeoutInterval:WS_TIME_OUT];
    NSString *boundary =@"0xKhTmLbOuNdArY";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    return request;
}

- (NSMutableURLRequest*)createAuthRequest:(NSString*)url
                                      body:(NSData*)bodyData
                                httpMethod:(NSString*)method {
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:WS_TIME_OUT];
    [request setHTTPMethod:[method uppercaseString]];
    [request setHTTPBody:bodyData];
    [request setTimeoutInterval:WS_TIME_OUT];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    return request;
}

- (void)sendURL:(NSString *)url
         params:(NSDictionary *)params
           body:(NSData *)body
         method:(NSString *)method
        handler:(WSURLSessionHandler)handler {
    
    NSString *finalURL = [self buildURL:url byParams:params];
    NSMutableURLRequest *request = [self createAuthRequest:finalURL body:body httpMethod:method];
    [self sendRequest:request requiredLogin:YES handler:handler];
    
}


- (void)sendRequest:(NSMutableURLRequest *)request requiredLogin:(BOOL)requiredLogin handler:(WSURLSessionHandler)handler {
    if (requiredLogin) {
        [[ErrorManager shared] requitedLogin:^(BOOL completed) {
            if (completed) {
                NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
                [request setValue:acc forHTTPHeaderField:@"Authorization"];
                [self sendRequest:request handler:handler];
            }
        }];
    } else {
        [self sendRequest:request handler:handler];
    }
}

- (void)sendRequest:(NSMutableURLRequest *)request handler:(WSURLSessionHandler)handler {
    DBG(@"NM-WS-REQUEST-URL: %@",request.URL.absoluteString);
    DBG(@"NM-WS-REQUEST-METHOD: %@",request.HTTPMethod);
    DBG(@"NM-WS-REQUEST-BODY: %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    [self callSessionRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        NSString *errorUnknown = [error.userInfo objectForKey:@"message"];
        if ([errorUnknown isEqualToString:@"Unknown Error."] && !_isCheckUnknownError) {
            [self callSessionRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
                if (handler) {
                    handler (responseObject,response,error);
                }
            }];
            _isCheckUnknownError = YES;
        } else {
            if (handler) {
                handler (responseObject,response,error);
            }
        }
    }];
}

- (void)callSessionRequest:(NSMutableURLRequest *)request handler:(BlockSession)handler {
    NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *sm = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:urlSessionConfig];
    [sm setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[sm dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        //check if error is exist
        NSInteger statusCodeWS = httpResponse.statusCode;
        DBG(@"Status_CodeWS %tu",statusCodeWS);
        if (statusCodeWS >= 300) {
            NSString *errorMessage = error.localizedDescription;
            if (responseObject) {
                NSString *strError = [responseObject objectForKeyNotNull:@"detail"];
                if (strError && [strError isEqualToString:ERROR_AUTH_NOT_PROVIDED]) {
                    errorMessage = ERROR_AUTH_NOT_PROVIDED;
                }
                strError = [responseObject objectForKeyNotNull:@"message"];
                if (strError) {
                    errorMessage = strError;
                }
                strError = [responseObject objectForKeyNotNull:@"error"];
                if (strError) {
                    errorMessage = strError;
                }
            }
            
            NSInteger errorCode = statusCodeWS;
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN
                                                 code:errorCode
                                             userInfo:@{@"message":errorMessage}];
            if(handler) {
                handler(responseObject,response,error);
            }
            return ;
        }
        if (responseObject && !([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]])) {
            NSInteger errorCode = 500;
            NSString *errorMessage = @"The Response is invalid.";
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN
                                                 code:errorCode
                                             userInfo:@{@"message":errorMessage}];
            if(handler) {
                handler(responseObject,response,error);
            }
        } else {
            if (error) {
                NSString *errorCode = [NSString stringWithFormat:@"%tu",error.code];
                NSString *errorMessage = error.localizedDescription;
                NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN
                                                     code:0
                                                 userInfo:@{@"message":errorMessage, @"code":errorCode}];
                if(handler) {
                    handler(responseObject,response,error);
                }
            } else {
                if(handler) {
                    handler(responseObject,response,nil);
                }
            }
        }
    }] resume];
}

@end
