//
//  NSFileManager+Directories.m
//  NikmeApp
//
//  Created by Linh NGUYEN on 10/8/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NSFileManager+Directories.h"

@implementation NSFileManager (Directories)

- (NSURL*)privateDirectory {
    return [[self URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL*)publicDirectory {
    return [[self URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL*)cacheDirectory {
    return [[self URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
