//
//  NMDeviceHelper.h
//  NikmeApp
//
//  Created by Linh NGUYEN on 10/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMDeviceHelper : NSObject

+ (NSString*)getAppVersion;
+ (NSString*)getShortVersionString;
+ (NSString*)getAppInformation;
+ (BOOL)isDeviceVersion:(NSString *)version;
@end
