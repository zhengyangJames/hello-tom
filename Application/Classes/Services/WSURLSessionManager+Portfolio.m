//
//  WSURLSessionManager+Portfolio.m
//  CoAssets
//
//  Created by Macintosh HD on 1/19/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSURLSessionManager+Portfolio.h"
#import "WSPortfolioRequest.h"
#import "COBalanceModel.h"

@implementation WSURLSessionManager (Portfolio)
- (void)wsGetCompleteDrawalsRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    request = [request getCompleteWitdDrawals:username];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        [kUserDefaults removeObjectForKey:UPDATE_PORTPOLIO_COMPLTETE];
        [kUserDefaults synchronize];
        if (!error && responseObject) {
            if ([kUserDefaults objectForKey:UPDATE_PORTPOLIO_COMPLTETE] != responseObject) {
                [kUserDefaults setObject:responseObject forKey:UPDATE_PORTPOLIO_COMPLTETE];
                [kUserDefaults synchronize];
            }
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

- (void)wsGetBalancesRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    request = [request getBalances:username];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject && [responseObject isKindOfClass:[NSArray class]]) {
            NSArray *arrayTemp_ = (NSArray *)responseObject;
            NSMutableArray *arrayBalance = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in arrayTemp_) {
                COBalanceModel *balanceModel = [MTLJSONAdapter modelOfClass:[COBalanceModel class] fromJSONDictionary:dict error:&error];
                [arrayBalance addObject:balanceModel];
                
            }
            if (handler) {
                handler(arrayBalance,response,nil);
            }
        } else {
            if (handler) {
                handler(responseObject,response,error);
            }
        }
    }];
}
@end
