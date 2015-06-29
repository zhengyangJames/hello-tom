//
//  CODummyDataManager.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileObject.h"

@interface CODummyDataManager : NSObject

+ (instancetype)shared;
- (ProfileObject*)AboutProfileObj;

@end
