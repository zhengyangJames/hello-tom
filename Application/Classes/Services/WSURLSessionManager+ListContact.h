//
//  WSURLSessionManager+ListContact.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (ListContact)
- (void)wsGetListContactWithHandler:(WSURLSessionHandler)handler;
//- (void)wsGetListOfferWithHandler:(WSURLSessionHandler)handler;

@end
