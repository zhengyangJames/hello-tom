//
//  WSUpdateInvestorProfile.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

static NSString *kUpIVProfileInvestor       = @"iv_investor";
static NSString *kUpIVProfileProject     = @"iv_project";
static NSString *kUpIVProfileCurrency     = @"iv_currency";
static NSString *kUpIVProfileInvestment     = @"iv_investment";
static NSString *kUpIVProfileTarget         = @"iv_target";
static NSString *kUpIVProfileCountries      = @"iv_countries";
static NSString *kUpIVProfileDescriptions     = @"iv_descriptions";
static NSString *kUpIVProfileWebsite     = @"iv_website";
static NSString *kUpIVProfileDuration    = @"iv_duration";

@interface WSUpdateInvestorProfile : WSRequest

@end
