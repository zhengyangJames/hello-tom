//
//  WSURLSessionManager+Portfolio.h
//  CoAssets
//
//  Created by Macintosh HD on 1/19/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (Portfolio)
- (void)wsGetCompleteDrawalsRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler;
- (void)wsGetBalancesRequestHandler:(NSString *)username handle:(WSURLSessionHandler)handler;
@end
