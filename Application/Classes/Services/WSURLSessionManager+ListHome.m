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

@implementation WSURLSessionManager (ListHome)

- (void)wsGetListOffersFilter:(NSString *)offerType handle:(WSURLSessionHandler)handler {
    NSString *url = [WS_METHOD_GET_LIST_OFFERS stringByAppendingString:offerType];
    [self sendURL:url params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsGetDetailsWithOffersID:(NSString *)offerID handler:(WSURLSessionHandler)handler {
    NSString *urlOffer = WS_METHOD_GET_LIST_OFFERS;
    NSString *url = [urlOffer stringByAppendingString:offerID];
    [self sendURL:url params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsPostQuestionWithOffersID:(NSString *)OffersID body:(NSDictionary *)body handler:(WSURLSessionHandler)handler {
    NSString *urlQuestion = WS_METHOD_POST_QUESTION;
    NSString *offerID = [NSString stringWithFormat:@"%@/",OffersID];
    NSString *url = [urlQuestion stringByAppendingString:offerID];
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    NSString *postString = [self paramsToString:body];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:url
                                                      body:parambody
                                                httpMethod:METHOD_POST];
    [request setValue:valueToken forHTTPHeaderField:@"Authorization"];
    
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

- (void)wsPostSubscribeWithOffersID:(NSString*)OffersID amount:(NSDictionary *)amount handler:(WSURLSessionHandler)handler {
    NSString *urlQuestion = WS_METHOD_POST_SUBSCRIBE;
    NSString *offerID = [NSString stringWithFormat:@"%@/",OffersID];
    NSString *url = [urlQuestion stringByAppendingString:offerID];
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    NSString *postString = [self paramsToString:amount];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:url
                                                      body:parambody
                                                httpMethod:METHOD_POST];
    [request setValue:valueToken forHTTPHeaderField:@"Authorization"];
    
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

- (void)wsGetProgressBarWithOfferID:(NSDictionary*)bodyOfferID handler:(WSURLSessionHandler)handler {
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",userModel.stringOfTokenType,userModel.stringOfAccessToken];
    NSString *URL = WS_METHOD_POST_PROGRESSBAR;
    NSString *postString = [self paramsToString:bodyOfferID];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:URL
                                                      body:parambody
                                                httpMethod:METHOD_POST];
    [request setValue:valueToken forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSError *error = nil;
            COProjectFundedAmountModel *amountModel = [MTLJSONAdapter modelOfClass:[COProjectFundedAmountModel class] fromJSONDictionary:responseObject error:&error];
            if (handler) {
                handler(amountModel, response, nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

#pragma mark - Helper - Analyse Obj DetailsOffers

@end
