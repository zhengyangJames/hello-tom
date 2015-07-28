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
        }
    }];
}

- (void)_zipDataProfile:(NSDictionary*)dic {
    NSMutableDictionary *dicPro = [NSMutableDictionary new];
    dicPro[kUSER] = [dic objectForKeyNotNull:@"username"];
    dicPro[KFRIST_NAME] = [dic objectForKeyNotNull:@"first_name"];
    dicPro[KLAST_NAME] = [dic objectForKeyNotNull:@"last_name"];
    dicPro[KEMAIL] = [dic objectForKeyNotNull:@"email"];
    NSDictionary *dicProfile = [dic objectForKeyNotNull:@"profile"];
    dicPro[kNUM_CELL_PHONE] = [dicProfile objectForKeyNotNull:@"cellphone"];
    dicPro[kNUM_COUNTRY] = [dicProfile objectForKeyNotNull:@"country_prefix"];
    dicPro[KADDRESS] = [dicProfile objectForKeyNotNull:@"address_1"];
    dicPro[KADDRESS2] = [dicProfile objectForKeyNotNull:@"address_2"];
    dicPro[KSATE] = [dicProfile objectForKeyNotNull:@"region_state"];
    dicPro[KCITY] = [dicProfile objectForKeyNotNull:@"city"];
    dicPro[KCOUNTRY] = [dicProfile objectForKeyNotNull:@"country"];
    [kUserDefaults setObject:dicPro forKey:kPROFILE_OBJECT];
    [kUserDefaults synchronize];
}

@end
