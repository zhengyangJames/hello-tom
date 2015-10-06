//
//  UserProfileModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COUserProfileModel.h"
#import "COUserTokensModel.h"
#import "COUserProfileDetailModel.h"
#import "COUserAccountModel.h"

@implementation COUserProfileModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"userRefreshToken" : @"refresh_toke",
        @"userScope"        : @"scope",
        @"userTokenType"    : @"token_type",
        @"userAccessToken"  : @"access_token",
        @"userExpriesIn"    : @"expires_in",
        @"userAccount"      : @"account",
        @"userTokens"       : @"tokens",
        @"userId"           : @"id",
        @"userLastName"     : @"last_name",
        @"userName"         : @"username",
        @"userEmail"        : @"email",
        @"userProfile"      : @"profile",
        @"userFirstName"    : @"first_name",
    };
}

+ (NSValueTransformer *)userAccountJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserAccountModel.class];
}

+ (NSValueTransformer *)userTokensJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserTokensModel.class];
}

+ (NSValueTransformer *)userProfileJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserProfileDetailModel.class];
}

- (NSString *)stringOfAccessToken {
    return self.userAccessToken;
}

- (NSString *)stringOfTokenType {
    return self.userTokenType;
}

- (NSString *)stringOfProfileEmail {
   return self.userEmail;
}

- (NSString *)stringOfUserName {
    return self.userName;
}

#pragma mark - user name protocol
- (NSString *)userNameTitle {
    return m_string(@"USERNAME");
}
- (NSString *)userNameContent {
    return  self.userName;
}


#pragma mark - user first name protocol

- (NSString *)firstNameTitle {
    return NSLocalizedString(@"FIRST_NAME", nil);
}

- (NSString *)firstNameContent {
    return self.userFirstName;
}
#pragma mark - user last name protocol

- (NSString *)lastNameTitle {
    return NSLocalizedString(@"LAST_NAME", nil);
}

- (NSString *)lastNameContent {
    return self.userLastName;
}
#pragma mark - user email protocol

- (NSString *)emailTitle {
    return NSLocalizedString(@"EMAIL", nil);
}

- (NSString *)emailContent {
    return self.userEmail;
}
#pragma mark - user phone protocol

- (NSString *)phoneTitle {
    return NSLocalizedString(@"PHONE", nil);
}

- (NSString *)phoneContent {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileCellPhone;
}

- (NSString *)phoneContentWithPrefix {
    COUserProfileDetailModel *proModel = self.userProfile;
    NSString *phoneCode = proModel.profileCountryPrefix;
    NSString *phoneString = [NSString stringWithFormat:@"%@ %@",phoneCode,proModel.profileCellPhone];
    return phoneString;
}

#pragma mark - user about profile

- (NSString *)nameOfUserName{
    return self.userName;
}

- (NSString *)nameOfUserFirstName{
    return self.userFirstName;
}

- (NSString *)nameOfUserLastName {
    return self.userLastName;
}

- (NSString *)nameOfUserEmail {
    return self.userEmail;
}


- (NSString *)numberOfUserPhone {
    return self.userProfile.profileCellPhone;
}

- (NSString *)nameOfUserAddress1 {
    return self.userProfile.profileAddress1;
}

- (NSString *)nameOfUserRegion {
    return self.userProfile.profileRegionState;
}

- (NSString *)nameOfUserAddress2 {
    return self.userProfile.profileAddress2;
}

- (NSString *)nameOfUserCity {
    return self.userProfile.profileCity;
}

- (NSString *)nameOfUserCountry {
    return self.userProfile.profileCountry;
}

- (NSString *)nameOfUserCountryCode {
    return self.userProfile.profileCountryPrefix;
}
//set

- (void)setNameOfUserName:(NSString*)string {
    self.userName = string;
}

- (void)setNameOfUserFirstName:(NSString*)string {
    self.userFirstName = string;
}

- (void)setNameOfUserLastName:(NSString*)string {
    self.userLastName = string;
}

- (void)setNameOfUserEmail:(NSString*)string {
    self.userEmail = string;
}

- (void)setNumberOfUserPhone:(NSString*)string {
    self.userProfile.profileCellPhone = string;
}

- (void)setNameOfUserAddress1:(NSString*)string {
    self.userProfile.profileAddress1 = string;
}

- (void)setNameOfUserRegion:(NSString*)string {
    self.userProfile.profileRegionState = string;
}

- (void)setNameOfUserAddress2:(NSString*)string {
    self.userProfile.profileAddress2 = string;
}

- (void)setNameOfUserCity:(NSString*)string {
    self.userProfile.profileCity = string;
}

- (void)setNameOfUserCountry:(NSString*)string {
    self.userProfile.profileCountry = string;
}

- (void)setNameOfUserCountryCode:(NSString*)string {
    self.userProfile.profileCountryPrefix = string;
}

@end
