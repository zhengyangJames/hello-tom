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
#import "COListProfileObject.h"
#import "COUserProfileModel.h"

@interface COLoginManager()

@property (nonatomic, strong) NSDictionary *dictionToken;
@end

@implementation COLoginManager

+ (id)shared {
    static COLoginManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)callAPILogin:(NSDictionary*)param actionLoginManager:(ActionLoginManager)actionLoginManager {
    self.dictionToken = [[NSDictionary alloc] init];
    [[WSURLSessionManager shared] wsLoginWithUser:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]&& [responseObject valueForKey:kACCESS_TOKEN]) {
            NSError *error;
            NSDictionary *dic = responseObject;
            NSData *dataToken = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
            [kUserDefaults setObject:dataToken forKey:kPROFILE_TOKEN_JSON];
            [kUserDefaults synchronize];
            [self callWSGetListProfile:^(id object,BOOL sucess){
                if (actionLoginManager) {
                    actionLoginManager(object,sucess);
                }
            }];
        } else {
            if (actionLoginManager) {
                actionLoginManager(nil,NO);
            }
        }
    }];
}

- (NSDictionary*)getAccessToken {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSData *dataToken = [kUserDefaults objectForKey:kPROFILE_TOKEN_JSON];
    if (dataToken) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:dataToken options:kNilOptions error:nil];
        if (jsonDic) {
            [dic setObject:[jsonDic objectForKey:kACCESS_TOKEN] forKey:kACCESS_TOKEN];
            [dic setObject:[jsonDic objectForKey:kTOKEN_TYPE] forKey:kTOKEN_TYPE];
        }
        return dic;
    }
    return nil;
}

- (void)callWSGetListProfile:(ActionLoginManager)actionLoginManager {
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:[self getAccessToken] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            NSDictionary *dic = responseObject;
            NSError *error;
            NSData *dataProfile = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
            [kUserDefaults setObject:dataProfile forKey:kPROFILE_JSON];
            [kUserDefaults synchronize];
            [kNotificationCenter postNotificationName:kUPDATE_PROFILE object:nil];
            if (actionLoginManager) {
                actionLoginManager(responseObject,YES);
            }
        }else {
            if (actionLoginManager) {
                actionLoginManager(nil,NO);
            }
        }
    }];
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    } else {
        return _userModel = [self _getData];
    }
    return nil;
}

- (COUserProfileModel *)reloadDataModel {
    if (self.userModel) {
        self.userModel = nil;
    }
    return _userModel = [self _getData];
}

- (COUserProfileModel *)_getData {
    COUserProfileModel *model;
    NSData *dataProfile = [kUserDefaults objectForKey:kPROFILE_JSON];
    if (dataProfile) {
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataProfile options:kNilOptions error:nil];
        model =  [MTLJSONAdapter modelOfClass:[COUserProfileModel class] fromJSONDictionary:json error:&error];
    }
    NSData *dataToken = [kUserDefaults objectForKey:kPROFILE_TOKEN_JSON];
    if (dataToken) {
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataToken options:kNilOptions error:nil];
        COUserProfileModel *modelToken =  [MTLJSONAdapter modelOfClass:[COUserProfileModel class] fromJSONDictionary:json error:&error];
        [model setValueAccessToken:modelToken.stringOfAccessToken];
        [model setValueTokenType:modelToken.stringOfTokenTye];
    }
    return model;
}
@end
