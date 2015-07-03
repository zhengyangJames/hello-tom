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
    [[WSURLSessionManager shared] wsLoginWithUser:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if ([responseObject isKindOfClass:[NSDictionary class]]&& [responseObject valueForKey:kACCESS_TOKEN]) {
            [kUserDefaults setValue:[responseObject valueForKey:kACCESS_TOKEN] forKey:kACCESS_TOKEN];
            [kUserDefaults setValue:[responseObject valueForKey:kTOKEN_TYPE] forKey:kTOKEN_TYPE];
            [kUserDefaults setBool:YES forKey:KDEFAULT_LOGIN];
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
            [UIHelper showError:error];
        }
    }];
}

- (void)callWSGetListProfile:(ActionLoginManager)actionLoginManager {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = [kUserDefaults valueForKey:kACCESS_TOKEN];
    dic[kTOKEN_TYPE] = [kUserDefaults valueForKey:kTOKEN_TYPE];
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [self _zipDataProfile:responseObject];
            [kNotificationCenter postNotificationName:kUPDATE_PROFILE object:nil];
            if (actionLoginManager) {
                actionLoginManager(responseObject,YES);
            }
        }else {
            if (actionLoginManager) {
                actionLoginManager(nil,NO);
            }
            [UIHelper showError:error];
        }
    }];
}

- (void)_zipDataProfile:(COListProfileObject*)object {
    NSMutableDictionary *dicPro = [NSMutableDictionary new];
    dicPro[kNUM_CELL_PHONE] = object.cell_phone;
    dicPro[kNUM_COUNTRY] = object.country_prefix;
    dicPro[KADDRESS] = object.address_1;
    dicPro[KADDRESS2] = object.address_2;
    dicPro[KSATE] = object.region_state ;
    dicPro[KCITY] = object.city;
    dicPro[KCOUNTRY] = object.country;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"profile"] = dicPro;
    dic[kUSER] = object.username;
    dic[KFRIST_NAME] = object.first_name;
    dic[KLAST_NAME] = object.last_name;
    dic[KEMAIL] = object.email;
    [kUserDefaults setObject:dic forKey:kPROFILE_OBJECT];
    [kUserDefaults synchronize];
}

@end
