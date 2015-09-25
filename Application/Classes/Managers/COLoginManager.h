//
//  COLoginManager.h
//  CoAssets
//
//  Created by TUONG DANG on 7/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COUserProfileModel;
@class WSLoginRequest;

typedef void(^ActionLoginManager)(id object, NSError *error);

@interface COLoginManager : NSObject

+ (id)shared;

@property (nonatomic, strong) COUserProfileModel *userModel;

- (void)callAPILoginWithRequest:(WSLoginRequest*)loginRequest actionLoginManager:(ActionLoginManager)actionLoginManager;
- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager;
@end
