//
//  NMSecurityHelper.m
//  ToeicTestPro
//
//  Created by Linh NGUYEN on 10/6/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "NMSecurityHelper.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>

@implementation NMSecurityHelper

+ (NSString*)hashMAC256:(NSString*)data key:(NSString*)key
{
    const char *privateKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *requestData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, // algorithm
           privateKey, strlen(privateKey), // privateKey
           requestData, strlen(requestData), // requestData
           cHMAC); // length
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    
    return [self base64String:output];
}

+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
