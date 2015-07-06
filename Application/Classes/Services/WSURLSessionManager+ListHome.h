//
//  WSURLSessionManager+ListHome.h
//  CoAssets
//
//  Created by TUONG DANG on 6/27/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (ListHome)

- (void)wsGetListOffersFilter:(NSString*)offerType handle:(WSURLSessionHandler)handler;
- (void)wsGetListOfferWithHandler:(WSURLSessionHandler)handler;
- (void)wsGetDetailsWithOffersID:(NSString*)offerID handler:(WSURLSessionHandler)handler;
- (void)wsPostSubscribeWithOffersID:(NSString*)OffersID amount:(NSDictionary*)amount handler:(WSURLSessionHandler)handler;
- (void)wsPostQuestionWithOffersID:(NSString*)OffersID handler:(WSURLSessionHandler)handler;

@end
