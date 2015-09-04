//
//  WSURLSessionManager+ListHome.h
//  CoAssets
//
//  Created by TUONG DANG on 6/27/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@class WSGetListOfferRequest;
@class WSGetOfferInfoWithRequest;
@class WSProjectFundInfoRequest;
@class WSPostSubscribeRequest;
@class WSPostQuestionRequest;

@interface WSURLSessionManager (ListHome)

- (void)wsGetListOffersWithRequest:(WSGetListOfferRequest *)request handle:(WSURLSessionHandler)handler;
- (void)wsGetOfferInforWithRequest:(WSGetOfferInfoWithRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsPostSubscribeWithRequest:(WSPostSubscribeRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsPostQuestionWithRequest:(WSPostQuestionRequest *)request handler:(WSURLSessionHandler)handler;
- (void)wsGetProjectFundInfoWithRequest:(WSProjectFundInfoRequest *)request handler:(WSURLSessionHandler)handler;
@end
