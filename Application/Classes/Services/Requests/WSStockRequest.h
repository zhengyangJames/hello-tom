//
//  WSStockRequest.h
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSStockRequest : NSMutableURLRequest

- (WSStockRequest *)getStockRequset;
- (WSStockRequest *)postStockProfile:(NSString *)content;
@end
