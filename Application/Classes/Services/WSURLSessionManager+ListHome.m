//
//  WSURLSessionManager+ListHome.m
//  CoAssets
//
//  Created by TUONG DANG on 6/27/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+ListHome.h"
#import "COListOffersObject.h"
#import "COProgressbarObj.h"
#import "CODetailsOffersObj.h"
#import "CODetailsOffersItemObj.h"
#import "CODetailsOffersItemObj+Mapping.h"
#import "CODetailsProfileObj.h"
#import "CODetailsProfileObj+Mapping.h"
#import "COOfferModel.h"

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

- (void)wsGetListOfferWithHandler:(WSURLSessionHandler)handler {
    [self sendURL:WS_METHOD_GET_LIST_OFFERS params:nil body:nil method:METHOD_GET handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arrayData = (NSArray*)responseObject;
            NSMutableArray *array = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in arrayData) {
                NSError *error = nil;
                COOfferModel *offerModel = [MTLJSONAdapter modelOfClass:[COOfferModel class] fromJSONDictionary:obj error:&error];
                [array addObject:offerModel];
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
            NSArray *listOffer = [self getListOfferDetailWihtDictionary:responseObject];
            if (handler) {
                handler(listOffer, response, nil);
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
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",[kUserDefaults valueForKey:kTOKEN_TYPE],[kUserDefaults valueForKey:kACCESS_TOKEN]];
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
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",[kUserDefaults valueForKey:kTOKEN_TYPE],[kUserDefaults valueForKey:kACCESS_TOKEN]];
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
    NSString *valueToken = [NSString stringWithFormat:@"%@ %@",[kUserDefaults valueForKey:kTOKEN_TYPE],[kUserDefaults valueForKey:kACCESS_TOKEN]];
    NSString *URL = WS_METHOD_POST_PROGRESSBAR;
    NSString *postString = [self paramsToString:bodyOfferID];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self createAuthRequest:URL
                                                      body:parambody
                                                httpMethod:METHOD_POST];
    [request setValue:valueToken forHTTPHeaderField:@"Authorization"];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            COProgressbarObj *obj = [[COProgressbarObj alloc]initWithDictionnary:responseObject];
            if (handler) {
                handler(obj, response, nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

#pragma mark - Helper - Analyse Obj DetailsOffers
- (NSArray *)getListOfferDetailWihtDictionary:(NSDictionary *)dict {
    NSMutableArray *arrObj = [[NSMutableArray alloc] init];
    if (dict) {
        if ([dict objectForKeyNotNull:@"offer_title"]) {
            CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
            [arrObj addObject:[obj mappingDetailsOffersItemTitle:dict]];
        }
        
        if ([dict objectForKeyNotNull:@"id"]) {
            CODetailsProfileObj *profileObj = [[CODetailsProfileObj alloc]init];
            [arrObj addObject:[profileObj mappingDetailsProfileObjects:dict]];
        }
        
        if ([dict objectForKeyNotNull:@"short_description"]) {
            CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
            [arrObj addObject:[obj mappingDetailsOffersItemDescription:dict]];
        }
        
        if ([dict objectForKeyNotNull:@"project_description"]) {
            CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
            [arrObj addObject:[obj mappingDetailsOffersItemProjectDesc:dict]];
        }
        
        if ([dict objectForKeyNotNull:@"documents"]) {
            NSDictionary *dictDocument = [dict objectForKeyNotNull:@"documents"];
            if (dictDocument) {
                CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
                [arrObj addObject:[obj mappingDetailsOffersItemDocument]];
                
                for (NSString *key in [dictDocument allKeys]) {
                    NSArray *arr = [dictDocument objectForKeyNotNull:key];
                    CODetailsOffersObj *detailObj = [[CODetailsOffersObj alloc]init];
                    NSMutableArray *arrSub = [NSMutableArray new];
                    if (arr.count > 0) {
                        for (NSDictionary *dic in arr) {
                            CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc] init];
                            obj = [obj mappingDetailsOffersItemSubDocument:dic andKey:key];
                            if(!obj.linkOrDetail) {
                                [arrSub addObject:obj];
                                break;
                            }
                            [arrSub addObject:obj];
                        }
                    } else {
                        CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
                        [arrSub addObject:[obj mappingDetailsOffersItemSubDocument:nil andKey:nil]];
                    }
                    [detailObj setDetailsOffersItemDocument:arrSub type:key];
                    [arrObj addObject:detailObj];
                }
            }
        }
        
        if ([dict objectForKeyNotNull:@"project"]) {
            CODetailsOffersItemObj *obj = [[CODetailsOffersItemObj alloc]init];
            [arrObj addObject:[obj mappingDetailsOffersItemAddress:dict]];
        }
    }
    return arrObj;
}



@end
