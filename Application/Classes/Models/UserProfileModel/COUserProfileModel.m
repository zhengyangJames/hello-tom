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

@implementation COUserProfileModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
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

+ (NSValueTransformer *)userTokensJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserTokensModel.class];
}

+ (NSValueTransformer *)userProfileJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:COUserProfileDetailModel.class];
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
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileCellPhone;
}

- (NSString *)nameOfUserAddress1 {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileAddress1;
}

- (NSString *)nameOfUserRegion {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileRegionState;
}

- (NSString *)nameOfUserAddress2 {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileAddress2;
}

- (NSString *)nameOfUserCity {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileCity;
}

- (NSString *)nameOfUserCountry {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileCountry;
}

- (NSString *)nameOfUserCountryCode {
    COUserProfileDetailModel *proModel = self.userProfile;
    return proModel.profileCountryPrefix;
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
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileCellPhone = string;
}

- (void)setNameOfUserAddress1:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileAddress1 = string;
}

- (void)setNameOfUserRegion:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileRegionState = string;
}

- (void)setNameOfUserAddress2:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileAddress2 = string;
}

- (void)setNameOfUserCity:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileCity = string;
}

- (void)setNameOfUserCountry:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileCountry = string;
}

- (void)setNameOfUserCountryCode:(NSString*)string {
    COUserProfileDetailModel *proModel = self.userProfile;
    proModel.profileCountryPrefix = string;
}

@end
