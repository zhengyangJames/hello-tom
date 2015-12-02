//
//  WSRegisterRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

static NSString *kregisterUserName      = @"username";
static NSString *kregisterPassWord      = @"password";
static NSString *kregisterFirstName     = @"first_name";
static NSString *kregisterLastName      = @"last_name";
static NSString *kregisterEmail         = @"email";
static NSString *kregisterNumCountry    = @"country_prefix";
static NSString *kregisterCellPhone     = @"cellphone";

@interface WSRegisterRequest : WSRequest

@end
