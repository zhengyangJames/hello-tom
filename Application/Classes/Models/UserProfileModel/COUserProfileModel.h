//
//  UserProfileModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COUserData.h"

@class COUserTokensModel;
@class COUserProfileDetailModel;

@interface COUserProfileModel : MTLModel<MTLJSONSerializing,COUserFirstName,COUserLastName,COUserEmail,COUserPhone,COUserAboutProfile>

@property (nonatomic, strong) NSString      *userAccount;
@property (nonatomic, strong) COUserTokensModel  *userTokens;
@property (nonatomic, strong) NSNumber      *userId;
@property (nonatomic, strong) NSString      *userLastName;
@property (nonatomic, strong) NSString      *userName;
@property (nonatomic, strong) NSString      *userEmail;
@property (nonatomic, strong) COUserProfileDetailModel *userProfile;
@property (nonatomic, strong) NSString      *userFirstName;
@end
