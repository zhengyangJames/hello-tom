//
//  WSURLSessionManager+ListHome.m
//  CoAssets
//
//  Created by TUONG DANG on 6/27/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+ListHome.h"
#import "COOfferModel.h"
#import "COProjectFundedAmountModel.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"
#import "WSPostQuestionRequest.h"
#import "WSPostSubscribeRequest.h"
#import "WSProjectFundInfoRequest.h"
#import "WSGetOfferInfoWithRequest.h"
#import "WSGetListOfferRequest.h"

@implementation WSURLSessionManager (ListHome)

- (void)wsGetListOffersWithRequest:(WSGetListOfferRequest *)request handle:(WSURLSessionHandler)handler {
   [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arrayData = (NSArray*)responseObject;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in arrayData) {
                COOfferModel *offerModel = [MTLJSONAdapter modelOfClass:[COOfferModel class] fromJSONDictionary:obj error:&error];
                [array addObject:offerModel];
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

- (void)wsGetOfferInforWithRequest:(WSGetOfferInfoWithRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            COOfferModel *offer = [MTLJSONAdapter modelOfClass:[COOfferModel class] fromJSONDictionary:responseObject error:&error];
            if (handler) {
                handler(offer, response, nil);
            }
        } else {
            if (handler) {
                handler(response,nil,error);
            }
        }
    }];
}

- (void)wsPostQuestionWithRequest:(WSPostQuestionRequest*) request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject, response, nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsPostSubscribeWithRequest:(WSPostSubscribeRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject, response, nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsGetProjectFundInfoWithRequest:(WSProjectFundInfoRequest *)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            COProjectFundedAmountModel *amountModel = [MTLJSONAdapter modelOfClass:[COProjectFundedAmountModel class] fromJSONDictionary:responseObject error:&error];
            if (handler) {
                handler(amountModel, response, nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

#pragma mark - Helper - Analyse Obj DetailsOffers

@end
