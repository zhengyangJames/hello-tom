//
//  WSURLSessionManager+ListContact.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+ListContact.h"
#import "COListContactObject.h"
#import "COLIstOffersObject.h"

@implementation WSURLSessionManager (ListContact)

- (void)wsGetListContactWithHandler:(WSURLSessionHandler)handler {
    [self sendURL:WS_METHOD_GET_LIST_CONTACT params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            NSMutableArray *arrayData = [[NSMutableArray alloc]init];
            for (NSDictionary *data in responseObject) {
                COListContactObject *objContac = [[COListContactObject alloc]initWithDictionary:data];
                [arrayData addObject:objContac];
            }
            if (handler) {
                handler(arrayData,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}


@end
