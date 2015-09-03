//
//  WSRegisterRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSRegisterRequest.h"

@implementation WSRegisterRequest

- (id)initRegisterRequest {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kUSER] = self.registerUserName?self.registerUserName:@"";
    dic[kPASSWORD] = self.registerPassWord?self.registerPassWord:@"";
    dic[KFRIST_NAME] = self.registerFirstName?self.registerFirstName:@"";
    dic[KLAST_NAME] = self.registerLastName?self.registerLastName:@"";
    dic[KEMAIL] = self.registerEmail?self.registerEmail:@"";
    dic[kNUM_COUNTRY] = self.registerNumCountry?self.registerNumCountry:@"";
    dic[kNUM_CELL_PHONE] = self.registerCellPhone?self.registerCellPhone:@"";
    NSString *postString = [self paramsToString:dic];
    NSData *parambody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    self = [self createAuthRequest:WS_METHOD_POST_REGISTER body:parambody httpMethod:METHOD_POST];
    return self;
}
@end
