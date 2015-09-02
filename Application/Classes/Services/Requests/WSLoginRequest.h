//
//  WSCreateUserRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSLoginRequest : WSRequest

- (instancetype)initLoginRequestWithUserName:(NSString *)userName passWord:(NSString *)password;
@end
