//
//  WSURLSessionManager+Stock.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Stock.h"
#import "WSStockRequest.h"
#import "COProfileStockModel.h"

@implementation WSURLSessionManager (Stock)

- (void)wsGetStockProfileRequestHandler:(WSURLSessionHandler)handler {
    WSStockRequest *request = [[WSStockRequest alloc]init];
    request = [request getStockRequset];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            COProfileStockModel *model = [MTLJSONAdapter modelOfClass:[COProfileStockModel class] fromJSONDictionary:responseObject error:&error];
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


- (void)wsPostDeviceCompanyProfileTokenRequest:(NSString *)message Handler:(WSURLSessionHandler)handler  {
    
    WSStockRequest *request = [[WSStockRequest alloc]init];
    [request postStockProfile:message];
    
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
