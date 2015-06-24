//
//  WSManager+Home.m
//  CoAssets
//
//  Created by Macintosh HD on 6/24/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSManager+Home.h"

@implementation WSManager (Home)

- (void)getListOffersWithHandler:(WSManagerHandler)handler {
    [self sendURL:WS_METHOD_GET_LIST_OFFERS params:nil body:nil method:METHOD_GET handler:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (handler) {
            handler(operation, responseObject, error);
        }
    }];
}

@end
