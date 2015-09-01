//
//  WSCreateUserRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSCreateUserRequest : WSRequest

@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *password;

- (NSMutableURLRequest *)requestWithUserInfo:(NSDictionary *)userInfo paramToken:(NSDictionary*)paramToken url:(NSString *)url httpMethod:(NSString *)method valueToken:(BOOL)isValue;
@end
