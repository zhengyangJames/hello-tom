//
//  WSGetDealProfileRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSGetDealProfileRequest : NSMutableURLRequest

- (WSGetDealProfileRequest *)getDealList:(NSDictionary *)dealDic;

@end