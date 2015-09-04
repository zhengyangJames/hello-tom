//
//  WSGetOfferInfoWithRequest.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSRequest.h"

@interface WSGetOfferInfoWithRequest : WSRequest

@property (nonatomic, strong) NSString *offerID;
@end
