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
@class COProfileStockModel;
@class COMultiPortpolioModel;
@class COCurrencyModel;

typedef void(^ActionLoginManager)(id object, NSError *error);
typedef void(^AcccountGetInvestor)(id object, NSError *errorAcccountInvestor);
typedef void(^ProfileGetInvestor)(id object, NSError *errorInvestor);

@interface COLoginManager : NSObject

+ (COLoginManager *)shared;

@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel *companyModel;
@property (nonatomic, strong) COUserInverstorModel *investorModel;
@property (nonatomic, strong) COAccountInvestmentModel *accountModel;
@property (nonatomic, strong) COMultiPortpolioModel *multiPortpolio;
@property (nonatomic, strong) COProfileStockModel *stockModel;
@property (nonatomic, strong) NSDictionary *currencyPortpolio;

@property (nonatomic, assign) BOOL isReloadListHome;
@property (nonatomic, strong) NSNumber *offerId;
@property (nonatomic, strong) NSString *offerType;

@property (nonatomic, strong) NSString *notificationID;

- (void)callAPILoginWithRequest:(WSLoginRequest*)loginRequest actionLoginManager:(ActionLoginManager)actionLoginManager;
- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager;

- (void)wsGetAccountInverstment:(AcccountGetInvestor)AcccountGetInvestor;
@end
