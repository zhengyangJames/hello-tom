//
//  WSForgotPassWordRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSForgotPassWordRequest.h"

@implementation WSForgotPassWordRequest

- (instancetype)initForgotPassWordRequestWithEmail:(NSString *)email {
    NSMutableDictionary *bodyInfo = [[NSMutableDictionary alloc] init];
    if (email) {
        [bodyInfo setObject:email forKey:@"email"];
    }
    NSString *postString = [self paramsToString:bodyInfo];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_POST_PORGOT_PASSWORD body:parambody httpMethod:METHOD_POST];
    return self;
}
@end
