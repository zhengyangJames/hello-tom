//
//  WSURLSessionManager+CompanyProfile.m
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+CompanyProfile.h"
#import "WSCompanyProfileRequest.h"
#import "COUserCompanyModel.h"

@implementation WSURLSessionManager (CompanyProfile)


- (void)wsPostDeviceCompanyProfileTokenRequest:(NSDictionary *)dic imageView:(UIImageView *)imageView Handler:(WSURLSessionHandler)handler  {
    
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    request = [request postCompanyProfile:dic imageView:imageView];
    
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

- (void)wsGetDealCompanyProfileRequestHandler:(WSURLSessionHandler)handler {
    WSCompanyProfileRequest *request = [[WSCompanyProfileRequest alloc]init];
    request = [request getCompanyProfile];
    
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        
        if (!error && responseObject) {
            NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
            [kUserDefaults setObject:data forKey:UPDATE_COMPANY_PROFILE_JSON];
            [kUserDefaults synchronize];

            COUserCompanyModel *model = [MTLJSONAdapter modelOfClass:[COUserCompanyModel class] fromJSONDictionary:responseObject error:&error];
            
            if (handler) {
                handler(model,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}


@end
