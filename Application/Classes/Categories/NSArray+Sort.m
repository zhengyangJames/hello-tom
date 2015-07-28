//
//  NSArray+Sort.m
//  CoAssets
//
//  Created by TUONG DANG on 6/25/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NSArray+Sort.h"

@implementation NSArray (Sort)

- (NSArray *)sortByKey:(NSString *)key Ascending:(BOOL)ascending {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    NSArray *arr = [self sortedArrayUsingDescriptors:@[sort]];
    return arr;
}

@end
