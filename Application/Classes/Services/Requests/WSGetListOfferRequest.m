//
//  WSGetListOfferRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSGetListOfferRequest.h"

@implementation WSGetListOfferRequest

- (void)setOfferType:(NSString *)offerType {
    _offerType = offerType;
    if (self.URL && _offerType) {
        NSString * url = [[self.URL absoluteString] stringByAppendingString:[_offerType stringByAppendingString:@"/"]];
        [self setURL:[NSURL URLWithString:url]];
    }
}
@end
