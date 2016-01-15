//
//  WSURLSessionManager+Stock.h
//  CoAssets
//
//  Created by Macintosh HD on 1/15/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (Stock)
- (void)wsGetStockProfileRequestHandler:(WSURLSessionHandler)handler;
- (void)wsPostDeviceCompanyProfileTokenRequest:(NSString *)message Handler:(WSURLSessionHandler)handler;
@end
