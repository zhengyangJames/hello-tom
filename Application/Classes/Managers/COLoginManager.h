//
//  COLoginManager.h
//  CoAssets
//
//  Created by TUONG DANG on 7/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ActionLoginManager)(id object,BOOL sucess);

@interface COLoginManager : NSObject
+ (id)shared;
- (void)callAPILogin:(NSDictionary*)param actionLoginManager:(ActionLoginManager)actionLoginManager;
- (void)callWSGetListProfile:(ActionLoginManager)actionLoginManager;
@end
