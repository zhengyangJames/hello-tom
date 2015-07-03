//
//  WSURLSessionManager+ListHome.m
//  CoAssets
//
//  Created by TUONG DANG on 6/27/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+ListHome.h"
#import "COLIstOffersObject.h"
#import "CODetailsOffersObject.h"

@implementation WSURLSessionManager (ListHome)

- (void)wsGetListOffersFilter:(NSString *)offerType handle:(WSURLSessionHandler)handler {
    NSString *url = [WS_METHOD_GET_LIST_OFFERS stringByAppendingString:offerType];
    [self sendURL:url params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arrayData = (NSArray*)responseObject;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in arrayData) {
                COLIstOffersObject *objList = [[COLIstOffersObject alloc]initWithDictionary:obj];
                [array addObject:objList];
            }
            if (handler) {
                handler(array, response, nil);
            }
        } else {
            if (handler) {
                handler(response,nil,error);
            }
        }
    }];
}

- (void)wsGetListOfferWithHandler:(WSURLSessionHandler)handler {
    [self sendURL:WS_METHOD_GET_LIST_OFFERS params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arrayData = (NSArray*)responseObject;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in arrayData) {
                COLIstOffersObject *objList = [[COLIstOffersObject alloc]initWithDictionary:obj];
                [array addObject:objList];
            }
            if (handler) {
                handler(array,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsGetDetailsWithOffersID:(NSString *)offerID handler:(WSURLSessionHandler)handler {
    NSString *urlOffer = WS_METHOD_GET_LIST_OFFERS;
    NSString *url = [urlOffer stringByAppendingString:offerID];
    [self sendURL:url params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            CODetailsOffersObject *objList = [[CODetailsOffersObject alloc]initWithDictionary:responseObject];
            if (handler) {
                handler(objList, response, nil);
            }
        } else {
            if (handler) {
                handler(response,nil,error);
            }
        }
    }];
}


@end
