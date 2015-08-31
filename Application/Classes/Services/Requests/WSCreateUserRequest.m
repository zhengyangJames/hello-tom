//
//  WSCreateUserRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSCreateUserRequest.h"

@implementation WSCreateUserRequest

#pragma mark - getter

- (NSString *)clientID {
    return [NSString stringWithFormat:@"%@=%@",kCLIENT_ID,[CLIENT_ID urlEncode]];
}

- (NSString *)clientSecrect {
    return [NSString stringWithFormat:@"%@=%@",kCLIENT_SECRECT,[CLIENT_SECRECT urlEncode]];
}

- (NSString *)grantType {
    return [NSString stringWithFormat:@"%@=%@",kGRANT_TYPE,[GRANT_TYPE urlEncode]];
}

- (NSString *)userName {
    if (_userName) {
        return [NSString stringWithFormat:@"%@=%@",kUSER,[_userName urlEncode]];
    }
    return kUSER;
}

- (NSString *)passWord {
    if (_passWord) {
        return [NSString stringWithFormat:@"%@=%@",kPASSWORD,[_passWord urlEncode]];
    }
    return kPASSWORD;
}

#pragma mark - setter 

- (void)setUserName:(NSString *)userName {
    _userName = userName;
}

- (void)setPassWord:(NSString *)passWord {
    _passWord = passWord;
}
@synthesize userName = _userName;
@synthesize passWord = _passWord;
@end
