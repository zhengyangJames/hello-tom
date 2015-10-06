//
//  WSUpdateCompanyProfile.h
//  CoAssets
//
//  Created by Tony Tuong on 10/6/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

static NSString *kUpCPProfileImage       = @"image_profile";
static NSString *kUpCPProfileOrgName     = @"org_name";
static NSString *kUpCPProfileOrgType     = @"org_type";
static NSString *kUpCPProfileAddress1     = @"cp_address_1";
static NSString *kUpCPProfileCity         = @"cp_city";
static NSString *kUpCPProfileCountry      = @"cp_country";
static NSString *kUpCPProfileAddress2     = @"cp_address_2";

@interface WSUpdateCompanyProfile : WSRequest

@end
