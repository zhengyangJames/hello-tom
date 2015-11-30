//
//  WSURLSessionManager+ListContact.m
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+ListContact.h"
#import "COContactsModel.h"
#import "WSGetListContactsRequest.h"

@implementation WSURLSessionManager (ListContact)

- (void)wsGetListContactWithRequest:(WSGetListContactsRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request requiredLogin:NO clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            NSMutableArray *arrayData = [[NSMutableArray alloc]init];
            for (NSDictionary *data in responseObject) {
                NSError *error;
                COContactsModel *contactModel = [MTLJSONAdapter modelOfClass:[COContactsModel class] fromJSONDictionary:data error:&error];
                [arrayData addObject:contactModel];
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
