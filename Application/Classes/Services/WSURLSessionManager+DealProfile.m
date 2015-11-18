//
//  WSURLSessionManager+DealProfile.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+DealProfile.h"

@implementation WSURLSessionManager (DealProfile)

- (void)wsGetDealRequest:(NSDictionary *)dealList handler:(WSURLSessionHandler)handler {
    
    WSGetDealProfileRequest *request = [[WSGetDealProfileRequest alloc]init];
    request = [request getDealList:dealList];
    
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            NSMutableArray *arrayData = [[NSMutableArray alloc]init];
            
            for (NSDictionary *data in responseObject) {
                NSError *error;
//                CONotificationModel *notiModel = [MTLJSONAdapter modelOfClass:[CONotificationModel class] fromJSONDictionary:data error:&error];
//                [arrayData addObject:notiModel];
            }
            if (handler) {
                handler(arrayData,response,nil);
            }
        } else {
            if (handler) {
                handler(nil,response,error);
            }
        }
    }];
}

@end
