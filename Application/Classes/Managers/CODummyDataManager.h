//
//  CODummyDataManager.h
//  CoAssest
//
//  Created by TUONG DANG on 6/15/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CODummyDataManager : NSObject

+ (instancetype)shared;
- (NSArray*)arrayListHomeObj;
- (NSArray*)arrayContactObj;
- (NSArray*)arrayAboutProfileObj;

@end
