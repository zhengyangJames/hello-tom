//
//  WSURLSessionManager.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WSURLSessionHandler)(id responseObject, NSURLResponse *response, NSError *error);
typedef void (^BlockSession)(id responseObject, NSURLResponse *response, NSError *error);
@interface WSURLSessionManager : NSObject

+ (WSURLSessionManager*)shared;
- (void)sendURL:(NSString*)url params:(NSDictionary*)params body:(NSData*)body
         method:(NSString*)method handler:(WSURLSessionHandler)handler;
- (void)sendRequest:(NSMutableURLRequest *)request requiredLogin:(BOOL)requiredLogin clearCache:(BOOL)clearCache handler:(WSURLSessionHandler)handler;
- (NSString*)paramsToString:(NSDictionary*)params;
- (NSMutableURLRequest*)createAuthRequest:(NSString*)url
                                      body:(NSData*)bodyData
                                httpMethod:(NSString*)method;
@end
