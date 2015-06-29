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
        s = [s stringByAppendingFormat:@"%@%@=%@",prefix,key,[[params objectForKey:key] urlEncode]];
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

- (NSMutableURLRequest*)_createAuthRequest:(NSString*)url
                                      body:(NSData*)bodyData
                                httpMethod:(NSString*)method {
    
    NSString *bodyString = @"";
    if(bodyData != nil) {
        bodyString = [[NSString alloc] initWithData:bodyData encoding:NSUTF8StringEncoding];
    }
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
    NSMutableURLRequest *request = [self _createAuthRequest:finalURL body:body httpMethod:method];
    [self sendRequest:request handler:handler];
    
}

- (void)sendRequest:(NSMutableURLRequest *)request handler:(WSURLSessionHandler)handler {
    DBG(@"NM-WS-REQUEST-URL: %@",request.URL.absoluteString);
    DBG(@"NM-WS-REQUEST-METHOD: %@",request.HTTPMethod);
    DBG(@"NM-WS-REQUEST-BODY: %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    // Initialize Session Configuration
    NSURLSessionConfiguration *urlSessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    // Initialize Session Manager
    AFHTTPSessionManager *sm = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:urlSessionConfig];
    // Configure Manager
    [sm setResponseSerializer:[AFJSONResponseSerializer serializer]];
    // Send Request
    [[sm dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        DBG(@"%tu",httpResponse.statusCode);
        //check if error is exist
        if(httpResponse.statusCode >= 500) {
            NSDictionary *headerDict = httpResponse.allHeaderFields;
            NSString *errorCode = @"Unknown Error";
            NSString *errorMessage = @"Unknown Error";
            if([headerDict objectForKeyNotNull:@"Nm-Code"] && [headerDict objectForKeyNotNull:@"Nm-Message"]) {
                errorCode = [headerDict objectForKey:@"Nm-Code"];
                errorMessage = [headerDict objectForKey:@"Nm-Message"];
            }
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:0 userInfo:@{@"message":errorMessage, @"code":errorCode}];
            if(handler)
            {
                handler(nil,response,error);
            }
            return;
        }
        if (responseObject && !([responseObject isKindOfClass:[NSDictionary class]] || [responseObject isKindOfClass:[NSArray class]])) {
            NSInteger errorCode = 500;
            NSString *errorMessage = @"The response is invalid.";
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:errorCode userInfo:@{@"message":errorMessage}];
            if(handler)
            {
                handler(nil,response,error);
            }
        }
        else
        {
            if(handler)
            {
                handler(responseObject,response,nil);
            }
        }
    }] resume];
}


@end
