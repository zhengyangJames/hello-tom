//  NSString_stripHtml.m
//  Copyright 2011 Leigh McCulloch. Released under the MIT license.

#import "NSString_stripHtml.h"

@implementation NSString (stripHtml)

- (NSString *)stringByStrippingHTML {
    NSRange r;
    NSString *s = [self copy];
    while ((r = [s rangeOfString:@"<[^>]+>\\s*" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

@end
