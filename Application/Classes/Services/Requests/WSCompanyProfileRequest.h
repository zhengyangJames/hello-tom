//
//  WSCompanyProfileRequest.h
//  CoAssets
//
//  Created by Macintosh HD on 12/4/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSCompanyProfileRequest : NSMutableURLRequest

- (WSCompanyProfileRequest *)postCompanyProfile:(NSDictionary *)companyDic imageView:(UIImageView *)imageView;
- (WSCompanyProfileRequest *)getCompanyProfile;

@end
