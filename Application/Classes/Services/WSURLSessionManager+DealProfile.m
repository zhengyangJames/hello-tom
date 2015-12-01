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
    
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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
    }];
}

@end
