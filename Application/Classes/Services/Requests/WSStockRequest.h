//
//  WSStockRequest.h
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSStockRequest : WSRequest

- (WSStockRequest *)getStockRequset;
- (void)postStockProfile:(NSString *)content;
@end
