//
//  WSProjectFundInfoRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

static NSString *kFundOfferID = @"offer_id";

@interface WSProjectFundInfoRequest : WSRequest

- (void)setValueWithModel:(id)model;
@end
