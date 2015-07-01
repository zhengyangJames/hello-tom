//
//  NSUserDefaultHelper.m
//  CoAssets
//
//  Created by TUONG DANG on 7/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NSUserDefaultHelper.h"


@implementation NSUserDefaultHelper

+ (void)saveUserDefaultWithProfileObject:(COListProfileObject *)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
    
}

+ (COListProfileObject *)loadUserDefaultWithProfileObjectAndKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    COListProfileObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

@end
