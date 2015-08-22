//
//  UserProfileDetailModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface COUserProfileDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *profileCountryPrefix;
@property (nonatomic, strong) NSString *profileCellPhone;
@property (nonatomic, strong) NSNumber *profileId;
@property (nonatomic, strong) NSString *profileAddress1;
@property (nonatomic, strong) NSString *profileCity;
@property (nonatomic, strong) NSString *profileCountry;
@property (nonatomic, strong) NSString *profileAddress2;
@property (nonatomic, strong) NSString *profileRegionState;
@end
