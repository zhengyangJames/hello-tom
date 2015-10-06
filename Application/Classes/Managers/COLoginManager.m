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

@implementation COLoginManager

+ (id)shared {
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
                    NSDictionary *dic = object;
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
                    [kUserDefaults setObject:data forKey:kPROFILE_JSON];
                    [kUserDefaults synchronize];
                    if (actionLoginManager) {
                        actionLoginManager(object,nil);
                    }
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
        token = [self _createParamTokenWithModel:[[COLoginManager shared] userModel]];
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:token handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (actionLoginManager) {
                actionLoginManager(responseObject,nil);
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
//    if (_companyModel) {
//        return _companyModel;
//    }
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

- (NSMutableDictionary*)_createParamTokenWithModel:(COUserProfileModel *)model {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (model.stringOfAccessToken) {
        dic[kACCESS_TOKEN] = model.stringOfAccessToken;
    } else {
        dic[kACCESS_TOKEN] = @"";
    }
    if (model.stringOfTokenType) {
        dic[kTOKEN_TYPE] = model.stringOfTokenType;
    } else {
        dic[kTOKEN_TYPE] = @"";
    }
    return dic;
}

@end
