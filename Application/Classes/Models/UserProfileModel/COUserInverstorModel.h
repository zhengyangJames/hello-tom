//
//  COUserInverstorModel.h
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "MTLModel.h"
#import "COUserData.h"
@interface COUserInverstorModel : MTLModel<MTLJSONSerializing,COInvestorType, COInvestorAmount, COInvestorCountries, COInvestorDuration, COInvestorPreference, COInvestorTarget, COCureency, CODescriptions, COWebsite>

@property (strong, nonatomic) NSString *investor;
//@property (strong, nonatomic) NSDictionary *investor_list;
@property (strong, nonatomic) NSString *project;
//@property (strong, nonatomic) NSDictionary *project_list;
@property (strong, nonatomic) NSString *currency;
//@property (strong, nonatomic) NSDictionary *currency_list;
@property (strong, nonatomic) NSNumber *investment;
@property (strong, nonatomic) NSNumber *duration;
@property (strong, nonatomic) NSNumber *target;
@property (strong, nonatomic) NSString *countries;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSString *website;

@end
