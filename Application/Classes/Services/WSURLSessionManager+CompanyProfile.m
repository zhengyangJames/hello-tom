//
//  WSURLSessionManager+CompanyProfile.m
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+CompanyProfile.h"
#import "WSCompanyProfileRequest.h"

@implementation WSURLSessionManager (CompanyProfile)


- (void)wsPostDeviceTokenRequest:(NSDictionary *)pagaBody handler:(WSURLSessionHandler)handler {
    
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    [request postCompanyProfile];
    
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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

- (void)wsGetDealRequest:(NSDictionary *)dealList handler:(WSURLSessionHandler)handler {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    request = [request getCompanyProfile];
    
    [self sendRequest:request handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                handler(responseObject,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}


@end
