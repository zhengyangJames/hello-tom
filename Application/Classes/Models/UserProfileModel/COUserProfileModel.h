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
@class COUserAccountModel;

@interface COUserProfileModel : MTLModel<MTLJSONSerializing,COUserFirstName,COUserLastName,COUserEmail,COUserPhone,COUserAboutProfile,COUserName>
@property (nonatomic, strong) NSNumber                  *userId;
@property (nonatomic, strong) NSString                  *userTokenType;
@property (nonatomic, strong) COUserProfileDetailModel  *userProfile;
@property (nonatomic, strong) NSNumber                  *userExpriesIn;
@property (nonatomic, strong) NSString                  *userRefreshToken;
@property (nonatomic, strong) NSString                  *userScope;
@property (nonatomic, strong) NSString                  *userFirstName;
@property (nonatomic, strong) NSString                  *userName;
@property (nonatomic, strong) COUserTokensModel         *userTokens;
@property (nonatomic, strong) COUserAccountModel        *userAccount;
@property (nonatomic, strong) NSString                  *userLastName;
@property (nonatomic, strong) NSString                  *userEmail;
@property (nonatomic, strong) NSString                  *userAccessToken;

- (NSString *)stringOfAccessToken;
- (NSString *)stringOfTokenType;
- (NSString *)stringOfUserName;
- (NSString *)stringOfProfileEmail;
@end
