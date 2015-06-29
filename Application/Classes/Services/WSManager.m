//
//  WSManager.m
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/29/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import "WSManager.h"
#import "AFNetworking.h"

@interface WSManager()
{
    
}

@property (nonatomic, strong) NSOperationQueue *serviceQueue;

@end

@implementation WSManager

+ (WSManager *)shared
{
    static WSManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        _serviceQueue = [[NSOperationQueue alloc] init];
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
        s = [s stringByAppendingFormat:@"%@%@=%@",prefix,key,[params objectForKey:key]];
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

- (NSMutableURLRequest*)_createMultipartAuthRequest:(NSString*)url body:(NSData*)bodyData httpMethod:(NSString*)method {
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

- (NSMutableURLRequest*)_createAuthRequest:(NSString*)url body:(NSData*)bodyData httpMethod:(NSString*)method
{
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

- (void)sendRequest:(NSMutableURLRequest*)request handler:(WSManagerHandler)handler {
    DBG(@"NM-WS-REQUEST-URL: %@",request.URL.absoluteString);
    DBG(@"NM-WS-REQUEST-METHOD: %@",request.HTTPMethod);
    DBG(@"NM-WS-REQUEST-BODY: %@",[[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // check if error is exist
        if(operation.response.statusCode >= 300) {
            NSDictionary *headerDict = operation.response.allHeaderFields;
            NSString *errorCode = @"Unknown Error";
            NSString *errorMessage = @"Unknown Error";
            if([headerDict objectForKeyNotNull:@"Nm-Code"] && [headerDict objectForKeyNotNull:@"Nm-Message"]) {
                errorCode = [headerDict objectForKey:@"Nm-Code"];
                errorMessage = [headerDict objectForKey:@"Nm-Message"];
            }
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:0 userInfo:@{@"message":errorMessage, @"code":errorCode}];
            if(handler)
            {
                handler(operation,nil,error);
            }
            return;
        }
        // check if responseObject containts no data
        if(responseObject == nil || [responseObject length] == 0) {
            if(handler)
            {
                handler(operation,nil,nil);
            }
            return;
        }
        // try to convert responseObj to JSON
        NSError *jsonError = nil;
        id jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject
                                                      options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonError) {
            if(handler)
            {
                handler(operation,nil,jsonError);
            }
        } else if(jsonDict && !([jsonDict isKindOfClass:[NSDictionary class]] || [jsonDict isKindOfClass:[NSArray class]]))
        {
            NSInteger errorCode = 500;
            NSString *errorMessage = @"The response is invalid.";
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:errorCode userInfo:@{@"message":errorMessage}];
            if(handler)
            {
                handler(operation,nil,error);
            }
        }
        else
        {
            if(handler)
            {
                handler(operation,jsonDict,nil);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *headerDict = operation.response.allHeaderFields;
        NSString *errorCode = @"Unknown Error";
        NSString *errorMessage = @"Unknown Error";
        if([headerDict objectForKeyNotNull:@"Nm-Code"] && [headerDict objectForKeyNotNull:@"Nm-Message"]) {
            errorCode = [headerDict objectForKey:@"Nm-Code"];
            errorMessage = [headerDict objectForKey:@"Nm-Message"];
        }
        NSError *_error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:0 userInfo:@{@"message":errorMessage, @"code":errorCode}];
        if(handler)
        {
            handler(operation,nil,_error);
        }
        DBG(@"NM-WS-ERROR: %@",_error);
    }];
    [self.serviceQueue addOperation:op];
}

- (void)sendURL:(NSString*)url params:(NSDictionary*)params body:(NSData*)body method:(NSString*)method handler:(WSManagerHandler)handler
{
    NSString *finalURL = [self buildURL:url byParams:params];
    NSMutableURLRequest *request = [self _createAuthRequest:finalURL body:body httpMethod:method];
    [self sendRequest:request handler:handler];
}

- (void)uploadData:(NSData *)data withType:(NSString *)type toURL:(NSString *)url handler:(WSManagerHandler)handler {
    NSString *boundary =@"0xKhTmLbOuNdArY";
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"image.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", type] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:data]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *urlRequest = [self _createMultipartAuthRequest:url body:body httpMethod:METHOD_POST];
    [self sendRequest:urlRequest handler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (handler) {
            handler(operation, responseObject, error);
        }
    }];
}

@end
