//
//  NSDictionary+NotNULL.m
//  NikmeApp
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NSDictionary+NotNULL.h"

@implementation NSDictionary (NotNULL)

- (id)valueForKeyNotNull:(NSString *)key
{
    id object = [self valueForKey:key];
    if (object != nil && [object isEqual:[NSNull null]])
    {
        object = nil;
    }
    return object;
}

- (id)objectForKeyNotNull:(NSString *)key
{
    id object = [self objectForKey:key];
    if (object != nil && [object isEqual:[NSNull null]])
    {
        object = nil;
    }
    return object;
}

@end
