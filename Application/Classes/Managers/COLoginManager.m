//
//  COLoginManager.m
//  CoAssets
//
//  Created by TUONG DANG on 7/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COLoginManager.h"
#import "WSURLSessionManager+User.h"
#import "WSURLSessionManager+Profile.h"
#import "COUserProfileModel.h"
#import "COUserCompanyModel.h"
#import "COUserInverstorModel.h"
#import "COAccountInvestmentModel.h"
#import "COUserPortFolioModel.h"

@implementation COLoginManager

+ (COLoginManager *)shared {
    static COLoginManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)callAPILoginWithRequest:(WSLoginRequest*)loginRequest actionLoginManager:(ActionLoginManager)actionLoginManager {
    [[WSURLSessionManager shared] wsLoginWithRequest:loginRequest handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]&& [responseObject valueForKey:kACCESS_TOKEN]) {
            [self tokenObject:responseObject callWSGetListProfile:^(id object, NSError *error){
                if ([object isKindOfClass:[NSDictionary class]] && !error) {
                    __block NSDictionary *dic = object;
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
                    [kUserDefaults setObject:data forKey:kPROFILE_JSON];
                    [kUserDefaults synchronize];
                    [self wsGetAccountInverstment:^(id object, NSError *error){
                        if (error && !object) {
                            [UIHelper showError:error];
                        } else {
                            if (actionLoginManager) {
                                actionLoginManager(dic,nil);
                            }
                        }
                    }];
                } else {
                    if (actionLoginManager) {
                        actionLoginManager(nil,error);
                    }
                }
            }];
        } else {
            NSString *errorCode = [NSString stringWithFormat:@"%tu",error.code];
            NSString *errorMessage = NSLocalizedString(@"INVAlID_USERNAME_OR_PASSWORD", nil);
            NSError *error = [NSError errorWithDomain:WS_ERROR_DOMAIN code:0 userInfo:@{@"message":errorMessage, @"code":errorCode}];
            if (actionLoginManager) {
                actionLoginManager(nil,error);
            }
        }
    }];
}

- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager {
    if (!token) {
        token = [UIHelper getParamTokenWithModel:[[COLoginManager shared] userModel]];
    }
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:token handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]] && !error) {
                NSDictionary *dicProfile = (NSDictionary*)responseObject;
                NSData *data = [NSJSONSerialization dataWithJSONObject:dicProfile options:0 error:nil];
                [kUserDefaults setObject:data forKey:kPROFILE_JSON];
                [kUserDefaults synchronize];
                if (dicProfile) {
                    if (actionLoginManager) {
                        actionLoginManager(dicProfile,nil);
                    }
                } else {
                    if (actionLoginManager) {
                        actionLoginManager(nil,error);
                    }
                }
            }
        }else {
            if (actionLoginManager) {
                actionLoginManager(nil,error);
            }
        }
    }];
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    NSError *error;
    if ([kUserDefaults objectForKey:kPROFILE_JSON]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[kUserDefaults objectForKey:kPROFILE_JSON] options:0 error:&error];
        if (dic) {
            COUserProfileModel *userProModel = [MTLJSONAdapter modelOfClass:[COUserProfileModel class] fromJSONDictionary:dic error:&error];
            return _userModel = userProModel;
        }
    }
    return nil;
}

- (COUserCompanyModel *)companyModel {
    NSError *error;
    if ([kUserDefaults objectForKey:UPDATE_COMPANY_PROFILE_JSON]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[kUserDefaults objectForKey:UPDATE_COMPANY_PROFILE_JSON] options:0 error:&error];
        if (dic) {
            COUserCompanyModel *userProModel = [MTLJSONAdapter modelOfClass:[COUserCompanyModel class] fromJSONDictionary:dic error:&error];
            return _companyModel = userProModel;
        }
    } else {
        return _companyModel = [[COUserCompanyModel alloc]init];
    }
    return nil;
}

- (COUserInverstorModel *)investorModel {
    NSError *error;
    if ([kUserDefaults objectForKey:UPDATE_INVESTOR_PROFILE_JSON]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[kUserDefaults objectForKey:UPDATE_INVESTOR_PROFILE_JSON] options:0 error:&error];
        if (dic) {
            COUserInverstorModel *userProModel = [MTLJSONAdapter modelOfClass:[COUserInverstorModel class] fromJSONDictionary:dic error:&error];
            return _investorModel = userProModel;
        }
    } else {
        return _investorModel = [[COUserInverstorModel alloc]init];
    }
    return nil;
}

#pragma mark -Account Investor WS

- (void)wsGetAccountInverstment:(AcccountGetInvestor)AcccountGetInvestor {
    NSDictionary *paramToken = [UIHelper getParamTokenWithModel:[[COLoginManager shared] userModel]];
    [[WSURLSessionManager shared] wsGetAccountInvestment:paramToken handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (responseObject &&[responseObject isKindOfClass:[NSDictionary class]] && !error) {
//            DBG(@"%@",responseObject);
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic addEntriesFromDictionary:responseObject];
            NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
            [kUserDefaults setObject:data forKey:UPDATE_ACCOUNT_PROFILE_JSON];
            [kUserDefaults synchronize];
            if (AcccountGetInvestor) {
                AcccountGetInvestor(dic,nil);
            }
        } else {
            if (AcccountGetInvestor) {
                AcccountGetInvestor(nil,error);
            }
        }
    }];
}

- (COAccountInvestmentModel *)accountModel {
    if (_accountModel) {
        return _accountModel;
    }
    NSError *error;
    if ([kUserDefaults objectForKey:UPDATE_ACCOUNT_PROFILE_JSON]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[kUserDefaults objectForKey:UPDATE_ACCOUNT_PROFILE_JSON] options:0 error:&error];
        if (dic) {
            COAccountInvestmentModel *userProModel = [MTLJSONAdapter modelOfClass:[COAccountInvestmentModel class] fromJSONDictionary:dic error:&error];
            return _accountModel = userProModel;
        }
    }
    return nil;
}

#pragma mark - Protfolio 


@end
