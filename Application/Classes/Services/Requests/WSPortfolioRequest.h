//
//  WSPortfolioRequest.h
//  CoAssets
//
//  Created by Macintosh HD on 1/19/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSPortfolioRequest : NSMutableURLRequest
- (WSPortfolioRequest *)getCompleteWitdDrawals:(NSString *)userName;
- (WSPortfolioRequest *)getBalances:(NSString *)userName;
@end
