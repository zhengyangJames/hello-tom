//
//  WSRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRequest : NSMutableURLRequest

- (id)createAuthRequest:(NSString*)url body:(NSData*)bodyData httpMethod:(NSString*)method;

- (NSString*)stringToLoginWithUserName:(NSString *)userName password:(NSString *)password;
- (NSString*)paramsToString:(NSDictionary*)params;

@end
