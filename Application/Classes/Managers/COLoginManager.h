//
//  COLoginManager.h
//  CoAssets
//
//  Created by TUONG DANG on 7/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COUserProfileModel;

typedef void(^ActionLoginManager)(id object,BOOL sucess);

@interface COLoginManager : NSObject

+ (id)shared;

@property (nonatomic, strong) COUserProfileModel *userModel;

- (void)callAPILogin:(id)param actionLoginManager:(ActionLoginManager)actionLoginManager;
- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager;
@end
