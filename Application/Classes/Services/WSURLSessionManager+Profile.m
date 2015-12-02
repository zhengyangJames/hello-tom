//
//  WSURLSessionManager+Profile.m
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Profile.h"
#import "COUserProfileModel.h"
#import "WSURLSessionManager+User.h"
#import "COLoginManager.h"
#import "WSGetProfileRequest.h"
#import "WSUpdateProfileRequest.h"
#import "WSGetAccountInvestment.h"
#import "WSGetInvestorProfile.h"
#import "COUserInverstorModel.h"

@implementation WSURLSessionManager (Profile)

#pragma mark - User Profile

- (void)wsGetProfileWithUserToken:(NSDictionary*)paramToken handler:(WSURLSessionHandler)handler {
    WSGetProfileRequest *request = [[WSGetProfileRequest alloc] init];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_LIST_PROFILE]];
    [request setHTTPMethod:METHOD_GET];
    [request setValueWithTokenData:paramToken];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *mutaDic = [NSMutableDictionary dictionary];
            [mutaDic addEntriesFromDictionary:paramToken];
            [mutaDic addEntriesFromDictionary:responseObject];
            if (handler) {
                handler(mutaDic,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsUpdateProfileWithRequest:(WSUpdateProfileRequest *)request handler:(WSURLSessionHandler)handler  {
    [self sendRequest:request requiredLogin:YES clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            COUserProfileModel *userModel = [self _updateProfileUserModel:responseObject];
            if (handler) {
                handler(userModel,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

- (COUserProfileModel*)_updateProfileUserModel:(NSDictionary*)obj {
    COUserProfileModel *userModel = [[COLoginManager shared] userModel];
    [userModel setUserFirstName:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileFirstName]]];
    [userModel setUserLastName:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileLastName]]];
    [userModel setUserEmail:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileEmail]]];
    [userModel setNumberOfUserPhone:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileCellPhone]]];
    [userModel setNameOfUserAddress1:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileAddress1]]];
    [userModel setNameOfUserAddress2:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileAddress2]]];
    [userModel setNameOfUserCity:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileCity]]];
    [userModel setNameOfUserCountry:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileCountry]]];
    [userModel setNameOfUserCountryCode:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileNumCountry]]];
    [userModel setNameOfUserRegion:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpProfileState]]];
    return userModel;
}

- (id)_setModelNullOrNotNull:(NSString*)string {
    if ([string isEmpty]) {
        return nil;
    } else {
        return string;
    }
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

#pragma mark - WS Get Account

- (void)wsGetAccountInvestment:(NSDictionary *)paramToken handler:(WSURLSessionHandler)handler {
    WSGetAccountInvestment *request = [[WSGetAccountInvestment alloc]init];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_ACCOUNT_INVESTER]];
    [request setHeaderWithToken:paramToken];
    [self sendRequest:request requiredLogin:YES clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

#pragma mark - WS Get Investor Profile

- (void)wsGetInvestorProfile:(NSDictionary *)paramToken handler:(WSURLSessionHandler)handler {
    WSGetInvestorProfile *request = [[WSGetInvestorProfile alloc] init];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_PROFILE_INVESTER]];
    [request setRequestWithToken:paramToken];
    [self sendRequest:request requiredLogin:YES clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (void)wsUpdateInvestorProfile:(WSUpdateInvestorProfile*)request handler:(WSURLSessionHandler)handler {
    [self sendRequest:request requiredLogin:YES clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            COUserInverstorModel *model = [self _updateInvestorProfile:(NSDictionary*)responseObject];
            if (handler) {
                handler(model,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

- (COUserInverstorModel*)_updateInvestorProfile:(NSDictionary*)obj {
    COUserInverstorModel *model = [[COLoginManager shared] investorModel];
    [model setCOCureencyContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileCurrencyUpdate]]];
    [model setCOInvestorPreferenceContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileProjectUpdate]]];
    [model setCOInvestorTypeContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileInvestorUpdate]]];
    [model setCODescriptionsContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileDescriptionsUpdate]]];
    [model setCOInvestorAmountContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileInvestmentUpdate]]];
    [model setCOInvestorCountriesContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileCountriesUpdate]]];
    [model setCOInvestorDurationContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileDurationUpdate]]];
    [model setCOInvestorTargetContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileTargetUpdate]]];
    [model setCOWebsiteContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpIVProfileWebsiteUpdate]]];
    return model;
}

@end
