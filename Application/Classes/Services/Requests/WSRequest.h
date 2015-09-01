//
//  WSRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/31/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSRequest : NSMutableURLRequest

- (NSString*)paramsToString:(NSDictionary*)params user:(NSString *)user password:(NSString *)password;
- (NSMutableURLRequest*)createAuthRequest:(NSString*)url
                                     body:(NSData*)bodyData
                               httpMethod:(NSString*)method;
@end
