//
//  WSURLSessionManager+User.m
//  CoAssets
//
//  Created by TUONG DANG on 6/28/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+User.h"

@implementation WSURLSessionManager (User)

- (void)wsLoginWithUser:(NSDictionary*)param handler:(WSURLSessionHandler)handler {
    NSString *url = [NSString stringWithFormat:WS_METHOD_POST_LOGIN,CLIENT_ID,CLIENT_SECRECT,param[kUSER],param[kPASSWORD]];
    
    [self sendURL:url params:nil body:nil method:METHOD_POST handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
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
