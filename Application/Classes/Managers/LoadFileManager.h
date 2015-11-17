//
//  LoadFileManager.h
//  CoAssest
//
//  Created by TUONG DANG on 6/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadFileManager : NSObject

+ (NSArray*)loadFileJsonWithName:(NSString*)fileName;

+ (NSArray*)loadFilePlistWithName:(NSString*)fileName;

+ (void)writeFilePlistWithName:(NSArray*)array fileName:(NSString*)fileName;

+ (NSArray*)loadFileFilterListWithName:(NSString*)fileName;

@property (nonatomic, strong) NSString *notificationID;
@end
