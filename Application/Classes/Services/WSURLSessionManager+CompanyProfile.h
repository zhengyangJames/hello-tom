//
//  WSURLSessionManager+CompanyProfile.h
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSURLSessionManager.h"

@interface WSURLSessionManager (CompanyProfile)
- (void)wsPostDeviceCompanyProfileTokenRequest:(NSDictionary *)dic imageView:(UIImageView *)imageView Handler:(WSURLSessionHandler)handler;
- (void)wsGetDealCompanyProfileRequestHandler:(WSURLSessionHandler)handler;
@end
