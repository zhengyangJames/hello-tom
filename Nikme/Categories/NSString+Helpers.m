//
//  NSDictionary+Helpers.m
//  NikmeApp
//
//  Created by Linh NGUYEN on 9/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)

- (NSString*)trim
{
    return [self stringByTrimmingCharactersInSet:
            [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isEmpty
{
    NSString * trimed = [self stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimed.length == 0?TRUE:FALSE;
}

- (NSString *)urlEncode
{
    //http://tools.ietf.org/html/rfc3986#section-2.1
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 CFSTR(":/?#[]@!$&'()*+,;="),
                                                                                 kCFStringEncodingUTF8));
}

- (NSString*)urlDecode
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(":/?#[]@!$&'()*+,;="),kCFStringEncodingUTF8));
}


- (NSString *)firstLetter
{
    NSString *trimed = [self trim];
    if(trimed.length == 0) {
        return @"#";
    } else {
        NSString *letter = [[trimed substringToIndex:1] uppercaseString];
        char c = [letter characterAtIndex:0];
        if(c >= 65 && c <= 90) {
            return letter;
        } else {
            return @"#";
        }
    }
}

- (NSString*)uppercaseStringFristLeter{
    [self lowercaseString];
    return [self capitalizedString];
}


@end
