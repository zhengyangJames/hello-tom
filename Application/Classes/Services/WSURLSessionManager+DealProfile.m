//
//  WSURLSessionManager+DealProfile.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+DealProfile.h"
#import "CODealProfileModel.h"

@implementation WSURLSessionManager (DealProfile)

- (void)wsGetDealRequest:(NSDictionary *)dealList handler:(WSURLSessionHandler)handler {
    
    WSGetDealProfileRequest *request = [[WSGetDealProfileRequest alloc]init];
    request = [request getDealList:dealList];
    
    [self sendRequest:request requiredLogin:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
        /*
        //////DEBUG
        NSString *errorMessage = ERROR_AUTH_NOT_PROVIDED;
        NSInteger errorCode = 11;
        NSError *error___ = [NSError errorWithDomain:WS_ERROR_DOMAIN
                                                code:errorCode
                                            userInfo:@{@"message":errorMessage}];
        if (handler) {
            handler(nil,response,error___);
        }
        /////END
        */
        
        ///*
        if (!error && responseObject) {
            NSDictionary *responseObj = (NSDictionary *)responseObject;
            NSError *error;
            CODealProfileModel *dealModel = [MTLJSONAdapter modelOfClass:[CODealProfileModel class] fromJSONDictionary:responseObj error:&error];
            
            if (handler) {
                handler(dealModel,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
        // */
    }];
}

@end
