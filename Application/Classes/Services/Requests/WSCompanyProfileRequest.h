//
//  WSCompanyProfileRequest.h
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSCompanyProfileRequest : NSMutableURLRequest

- (void)postCompanyProfile;
- (WSCompanyProfileRequest *)getCompanyProfile;

@end
