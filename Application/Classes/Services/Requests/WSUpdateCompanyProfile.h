//
//  WSUpdateCompanyProfile.h
//  CoAssets
//
//  Created by Tony Tuong on 10/6/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

static NSString *kUpCPProfileOrgName     = @"org_name";
static NSString *kUpCPProfileOrgType     = @"org_type";


static NSString *kUpCPProfileImageHeight = @"height_image_profile";

//static NSString *kUpCPProfileCity         = @"cp_city";
//static NSString *kUpCPProfileCountry      = @"cp_country";
//static NSString *kUpCPProfileAddress1     = @"cp_address_1";
//static NSString *kUpCPProfileAddress2     = @"cp_address_2";
//static NSString *kUpCPProfileImage       = @"image_profile";

// by vincent
static NSString *kUpCPProfileCity         = @"city";
static NSString *kUpCPProfileCountry      = @"country";
static NSString *kUpCPProfileAddress1     = @"address_1";
static NSString *kUpCPProfileAddress2     = @"address_2";
static NSString *kUpCPProfileImage        = @"logo";
//


@interface WSUpdateCompanyProfile : WSRequest

@end
