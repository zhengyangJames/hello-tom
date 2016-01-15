//
//  WSStockRequest.m
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSStockRequest.h"

@implementation WSStockRequest

- (WSStockRequest *)getStockRequset {
    WSStockRequest *request = [[WSStockRequest alloc]init];
    [request setHTTPMethod:METHOD_GET];
    NSString *acc = [kUserDefaults objectForKey:KEY_ACCESS_TOKEN];
    if (acc) {
        [request setValue:acc forHTTPHeaderField:@"Authorization"];
    }
    [request setURL:[NSURL URLWithString:WS_METHOD_STOCK]];
    return request;
}

- (WSStockRequest *)postStockProfile:(NSString *)content  {
    WSStockRequest *request = [[WSStockRequest alloc]init];
    
    [request setValue:content forHTTPHeaderField: @"custom_message"];
    [request setHTTPMethod:METHOD_POST];
    [request setURL:[NSURL URLWithString:WS_METHOD_STOCK_POST]];
    return request;
}


@end
