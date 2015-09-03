//
//  WSURLSessionManager+Profile.m
//  CoAssets
//
//  Created by TUONG DANG on 6/29/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Profile.h"
#import "COListProfileObject.h"
#import "COUserProfileModel.h"
#import "WSURLSessionManager+User.h"
#import "COLoginManager.h"
#import "WSGetProfileRequest.h"
#import "WSUpdateProfileRequest.h"

@implementation WSURLSessionManager (Profile)

- (void)wsGetProfileWithUserToken:(NSDictionary*)paramToken handler:(WSURLSessionHandler)handler {
    WSGetProfileRequest *request = [[WSGetProfileRequest alloc] initGetProfileRequestWithParamsToken:paramToken];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsUpdateProfileWithBody:(NSDictionary *)body handler:(WSURLSessionHandler)handler {
    WSUpdateProfileRequest *request = [[WSUpdateProfileRequest alloc] initUpdateProfileRequestWithBodyParams:body];
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            COUserProfileModel *userModel = [[COLoginManager shared] userModel];
            [[COLoginManager shared] tokenObject:[self _createParamTokenWithModel:userModel] callWSGetListProfile:^(id object, BOOL sucess) {
                if (sucess && [object isKindOfClass:[NSDictionary class]]) {
                    [[COLoginManager shared] setUserModel:nil];
                    NSError *error;
                    NSDictionary *dic = object;
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
                    [kUserDefaults setObject:data forKey:kPROFILE_JSON];
                    [kUserDefaults synchronize];
                    if (handler) {
                        handler(object,response,nil);
                    }
                }
            }];
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
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
