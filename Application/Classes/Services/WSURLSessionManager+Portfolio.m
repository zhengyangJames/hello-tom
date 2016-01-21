//
//  WSURLSessionManager+Portfolio.m
//  CoAssets
//
//  Created by Macintosh HD on 1/19/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Portfolio.h"
#import "WSPortfolioRequest.h"

@implementation WSURLSessionManager (Portfolio)
- (void)wsGetCompleteDrawalsRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    request = [request getCompleteWitdDrawals:username];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                if ([kUserDefaults objectForKey:UPDATE_PORTPOLIO_COMPLTETE] != responseObject) {
                    [kUserDefaults setObject:responseObject forKey:UPDATE_PORTPOLIO_COMPLTETE];
                    [kUserDefaults synchronize];
                }
                handler([kUserDefaults objectForKey:UPDATE_PORTPOLIO_COMPLTETE],response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}

- (void)wsGetBalancesRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    request = [request getBalances:username];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            if (handler) {
                if ([kUserDefaults objectForKey:UPDATE_PORTPOLIO_BALANCE] != responseObject) {
                    [kUserDefaults setObject:[responseObject allObjects] forKey:UPDATE_PORTPOLIO_BALANCE];
                    [kUserDefaults synchronize];
                }

                handler([kUserDefaults objectForKey:UPDATE_PORTPOLIO_BALANCE],response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}
@end
