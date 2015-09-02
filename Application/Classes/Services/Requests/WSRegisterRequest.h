//
//  WSRegisterRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSRegisterRequest : WSRequest

- (instancetype)initRegisterRequestWithBody:(NSDictionary *)paramsBody;
@end
