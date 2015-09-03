//
//  WSRegisterRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSRegisterRequest : WSRequest

- (id)initRegisterRequest;

@property (nonatomic, strong) NSString *registerUserName;
@property (nonatomic, strong) NSString *registerPassWord;
@property (nonatomic, strong) NSString *registerFirstName;
@property (nonatomic, strong) NSString *registerLastName;
@property (nonatomic, strong) NSString *registerEmail;
@property (nonatomic, strong) NSString *registerNumCountry;
@property (nonatomic, strong) NSString *registerCellPhone;

@end
