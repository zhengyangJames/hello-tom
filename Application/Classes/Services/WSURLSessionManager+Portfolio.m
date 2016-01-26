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
#import "COCompleteModel.h"

@implementation WSURLSessionManager (Portfolio)
- (void)wsGetCompleteDrawalsRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    request = [request getCompleteWitdDrawals:username];
    [self sendRequest:request requiredLogin:YES clearCache:YES handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponseObject = (NSDictionary *)responseObject;
            NSDictionary *dicComplete = [[NSDictionary alloc] init];
            NSMutableArray *arrComplete = [[NSMutableArray alloc] init];

            for (NSString *key in [dicResponseObject allKeys]) {
                NSString *value = [dicResponseObject objectForKey:key];
                 dicComplete = @{@"key": key, @"value": value};
                COCompleteModel *model = [MTLJSONAdapter modelOfClass:[COCompleteModel class] fromJSONDictionary:dicComplete error:&error];
                [arrComplete addObject:model];
            }
            if (handler) {
                handler(arrComplete,response,nil);
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
