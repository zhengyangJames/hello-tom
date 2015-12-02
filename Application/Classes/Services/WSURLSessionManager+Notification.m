//
//  WSURLSessionManager+Notification.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/11/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Notification.h"
#import "NotificationViewController.h"
#import "COContactsModel.h"
#import "CONotificationModel.h"

@implementation WSURLSessionManager (Notification)


- (void)wsPostDeviceTokenRequest:(NSDictionary *)pagaBody handler:(WSURLSessionHandler)handler {
    
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    request = [request setBodyDeviceToken:pagaBody];
    
    [self sendRequest:request requiredLogin:NO clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            [kUserDefaults setBool:YES forKey:DEVICE_TOKEN_EXIST];
            [kUserDefaults synchronize];
            if (handler) {
                handler(responseObject,response,error);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

- (void)wsGetNotificationListRequest:(NSDictionary *)listDic handler:(WSURLSessionHandler)handler {
    
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    request = [request getNotificationList:listDic];
    
    [self sendRequest:request requiredLogin:NO clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            NSMutableArray *arrayData = [[NSMutableArray alloc]init];
            
            for (NSDictionary *data in responseObject) {
                NSError *error;
                CONotificationModel *notiModel = [MTLJSONAdapter modelOfClass:[CONotificationModel class] fromJSONDictionary:data error:&error];
                [arrayData addObject:notiModel];
            }
            if (handler) {
                handler(arrayData,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

- (void)wsReadNotificationList:(NSDictionary *)bodyDic handler:(WSURLSessionHandler)handler{
    WSPostDeviceTokenRequest *request = [[WSPostDeviceTokenRequest alloc]init];
    request = [request readNotificationList:bodyDic];
    [self sendRequest:request requiredLogin:YES clearCache:NO handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]]) {
            if (handler) {
                handler(responseObject,response,error);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

@end
