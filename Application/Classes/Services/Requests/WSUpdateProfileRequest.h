//
//  WSUpdateProfileRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

static NSString *kUpProfileUserName     = @"username";
static NSString *kUpProfileFirstName    = @"first_name";
static NSString *kUpProfileLastName     = @"last_name";
static NSString *kUpProfileEmail        = @"email";
static NSString *kUpProfileNumCountry   = @"country_prefix";
static NSString *kUpProfileCellPhone    = @"cellphone";
static NSString *kUpProfileAddress1     = @"address_1";
static NSString *kUpProfileCity         = @"city";
static NSString *kUpProfileCountry      = @"country";
static NSString *kUpProfileAddress2     = @"address_2";
static NSString *kUpProfileState        = @"region_state";
static NSString *kUpProfileKeyProfile   = @"profile";
static NSString *kUpProfilePostCode     = @"postal_code";

@interface WSUpdateProfileRequest : WSRequest

- (void)setValueWithModel:(id)model;
@end
