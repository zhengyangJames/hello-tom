//
//  WSUpdateInvestorProfile.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

static NSString *kUpIVProfileInvestor       = @"investor_type";
static NSString *kUpIVProfileInvestor_List       = @"investor_type_list";
static NSString *kUpIVProfileProject        = @"project_type";
static NSString *kUpIVProfileProject_List        = @"project_type_list";
static NSString *kUpIVProfileCurrency       = @"currency_preference";
static NSString *kUpIVProfileCurrency_List       = @"currency_list";
static NSString *kUpIVProfileInvestment     = @"investment_budget";
static NSString *kUpIVProfileTarget         = @"target_annualize_return";
static NSString *kUpIVProfileDuration       = @"duration_preference_in_month";
static NSString *kUpIVProfileCountries      = @"country";
static NSString *kUpIVProfileDescriptions   = @"description";
static NSString *kUpIVProfileWebsite        = @"website";

static NSString *kUpIVProfileCurrencyUpdate       = @"currency";
static NSString *kUpIVProfileInvestorUpdate       = @"investor_type";
static NSString *kUpIVProfileProjectUpdate        = @"project_type";
static NSString *kUpIVProfileInvestmentUpdate     = @"budget";
static NSString *kUpIVProfileTargetUpdate         = @"annualize_return";
static NSString *kUpIVProfileDurationUpdate       = @"time_horizon";
static NSString *kUpIVProfileCountriesUpdate      = @"country";
static NSString *kUpIVProfileDescriptionsUpdate   = @"description";
static NSString *kUpIVProfileWebsiteUpdate        = @"iv_website";

@interface WSUpdateInvestorProfile : WSRequest
- (void)setRequestWithTOken;
@end
