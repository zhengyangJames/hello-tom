//
//  COLoginManager.h
//  CoAssets
//
//  Created by TUONG DANG on 7/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class COUserProfileModel;
@class WSLoginRequest;
@class COUserCompanyModel;
@class COUserInverstorModel;
@class COAccountInvestmentModel;

typedef void(^ActionLoginManager)(id object, NSError *error);
typedef void(^AcccountGetInvestor)(id object, NSError *error);

@interface COLoginManager : NSObject

+ (id)shared;

@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel *companyModel;
@property (nonatomic, strong) COUserInverstorModel *investorModel;
@property (nonatomic, strong) COAccountInvestmentModel *accountModel;

- (void)callAPILoginWithRequest:(WSLoginRequest*)loginRequest actionLoginManager:(ActionLoginManager)actionLoginManager;
- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager;
@end
