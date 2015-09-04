//
//  WSGetListOfferRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSGetListOfferRequest : WSRequest

@property (nonatomic, strong) NSString* offerType;
@end
