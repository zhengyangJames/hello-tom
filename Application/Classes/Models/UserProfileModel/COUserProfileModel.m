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
@end
