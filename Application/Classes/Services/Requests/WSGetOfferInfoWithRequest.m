//
//  WSGetOfferInfoWithRequest.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 9/4/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "WSGetOfferInfoWithRequest.h"


@implementation WSGetOfferInfoWithRequest

- (void)setOfferID:(NSString *)offerID {
    _offerID = offerID;
    if (self.URL && _offerID) {
        NSString * url = [[self.URL absoluteString] stringByAppendingString:[_offerID stringByAppendingString:@"/"]];
        [self setURL:[NSURL URLWithString:url]];
    }
}
@end
