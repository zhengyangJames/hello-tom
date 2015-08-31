//
//  WSCreateUserRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSCreateUserRequest : NSObject

@property (nonatomic, strong) NSString *clientID;
@property (nonatomic, strong) NSString *clientSecrect;
@property (nonatomic, strong) NSString *grantType;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *passWord;
@end
