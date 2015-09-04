//
//  WSURLSessionManager+ListContact.h
//  CoAssets
//
//  Created by TUONG DANG on 6/26/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@class WSGetListContactsRequest;

@interface WSURLSessionManager (ListContact)
- (void)wsGetListContactWithRequest:(WSGetListContactsRequest *)request handler:(WSURLSessionHandler)handler;
@end
