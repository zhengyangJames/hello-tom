//
//  WSGetInvestorProfile.h
//  CoAssets
//
//  Created by Tony Tuong on 10/13/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

@interface WSGetInvestorProfile : WSRequest
- (void)setRequestWithToken:(NSDictionary*)tokenData;
@end
