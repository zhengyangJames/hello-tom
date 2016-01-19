//
//  WSPortfolioRequest.m
//  CoAssets
//
//  Created by Macintosh HD on 1/19/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSPortfolioRequest.h"

@implementation WSPortfolioRequest

- (WSPortfolioRequest *)getCompleteWitdDrawals:(NSString *)userName {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [request setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    NSString *urlStr = [[WS_METHOD_PORTPOLIO_GET_COMPLETE_DRAWALS stringByAppendingString: userName] stringByAppendingString:@"/"];
    [request setURL:[NSURL URLWithString:urlStr]];
    return request;
}

- (WSPortfolioRequest *)getBalances:(NSString *)userName {
    WSPortfolioRequest *request = [[WSPortfolioRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [request setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    NSString *urlStr = [[WS_METHOD_PORTPOLIO_GET_BALANCES stringByAppendingString: userName] stringByAppendingString:@"/"];
    [request setURL:[NSURL URLWithString:urlStr]];
    return request;
}

@end
