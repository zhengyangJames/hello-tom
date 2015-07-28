//
//  DeviceHelper.m
//  NikmeApp
//
//  Created by Linh NGUYEN on 10/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NMDeviceHelper.h"
#import "UIDevice-Hardware.h"

@implementation NMDeviceHelper

+ (NSString *)getAppInformation
{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [appInfo objectForKey:@"CFBundleVersion"];
    NSString *locale = [[NSLocale currentLocale] localeIdentifier];
    NSString *device = [[UIDevice currentDevice] modelName];
    NSString *osVersion = [[UIDevice currentDevice] systemVersion];
    NSString *appName = [appInfo objectForKey:@"CFBundleDisplayName"];
    NSString *message = [NSString stringWithFormat:@"\n\n\nLocale: %@.\nDevice Model: %@.\nOS version: %@.\nApp Name : %@.\nApp version: %@.", locale, device, osVersion,appName, appVersion];
    return message;
}

+ (NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return [NSString stringWithFormat:@"%@ (%@)",majorVersion, minorVersion];
}

+ (NSString *)getShortVersionString
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return majorVersion;
}

+ (BOOL)isDeviceVersion:(NSString *)version
{
    return ([[[UIDevice currentDevice] systemVersion] compare:version  options:NSNumericSearch] == NSOrderedSame);
}

@end
