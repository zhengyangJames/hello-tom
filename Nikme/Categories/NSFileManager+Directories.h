//
//  NSFileManager+Directories.h
//  NikmeApp
//
//  Created by Linh NGUYEN on 10/8/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Directories)

- (NSURL*)privateDirectory;
- (NSURL*)publicDirectory;
- (NSURL*)cacheDirectory;

@end
