//
//  WSRegisterRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSRegisterRequest.h"

@implementation WSRegisterRequest

- (instancetype)initRegisterRequestWithData:(NSDictionary *)data {
    NSString *postString = [self paramsToString:data];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_POST_REGISTER body:parambody httpMethod:METHOD_POST];
    return self;
}

@end
