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

@implementation COLoginManager

+ (id)shared {
    static COLoginManager *instance = nil;
    static dispatch_once_t oneTOken;
    dispatch_once(&oneTOken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)callAPILogin:(NSDictionary*)param actionLoginManager:(ActionLoginManager)actionLoginManager; {
    [[WSURLSessionManager shared] wsLoginWithUserInfo:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]&& [responseObject valueForKey:kACCESS_TOKEN]) {
            [self tokenObject:responseObject callWSGetListProfile:^(id object,BOOL sucess){
                if ([object isKindOfClass:[NSDictionary class]] && sucess) {
                    NSError *error;
                    COUserProfileModel *userProModel = [MTLJSONAdapter modelOfClass:[COUserProfileModel class] fromJSONDictionary:object error:&error];
                    _userModel = userProModel;
                    NSDictionary *dic = object;
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
                    [kUserDefaults setObject:data forKey:kPROFILE_JSON];
                    [kUserDefaults synchronize];
                }
                if (actionLoginManager) {
                    actionLoginManager(object,YES);
                }
            }];
        } else {
            if (actionLoginManager) {
                actionLoginManager(nil,NO);
            }
        }
    }];
}

- (void)tokenObject:(NSDictionary*)token callWSGetListProfile:(ActionLoginManager)actionLoginManager {
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:token handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
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

- (void)setUserModel:(COUserProfileModel *)userModel {
    _userModel = userModel;
}

@synthesize userModel = _userModel;
@end
