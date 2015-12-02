//
//  WSGetAccountInvestment.h
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "WSRequest.h"

@interface WSGetAccountInvestment : WSRequest
- (void)setHeaderWithToken:(NSDictionary *)tokenDic;
@end
