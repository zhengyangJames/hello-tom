//
//  WSManager.h
//  myTomorrows
//
//  Created by Linh NGUYEN on 12/29/14.
//  Copyright (c) 2014 BakBurner Digital, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^WSManagerHandler)(AFHTTPRequestOperation *operation, id responseObject, NSError *error);

@interface WSManager : NSObject

+ (WSManager *)shared;

- (NSString*)paramsToString:(NSDictionary*)params;
- (NSString*)buildURL:(NSString*)url byParams:(NSDictionary*)params;

- (void)sendURL:(NSString*)url params:(NSDictionary*)params body:(NSData*)body
         method:(NSString*)method handler:(WSManagerHandler)handler;
- (void)sendRequest:(NSMutableURLRequest*)request handler:(WSManagerHandler)handler;
- (void)uploadData:(NSData *)data withType:(NSString *)type toURL:(NSString *)url handler:(WSManagerHandler)handler;

@end