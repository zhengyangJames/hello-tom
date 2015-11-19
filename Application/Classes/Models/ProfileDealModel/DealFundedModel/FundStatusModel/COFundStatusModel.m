//
//  COFundStatusModel.m
//  CoAssets
//
//  Created by Macintosh HD on 11/18/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COFundStatusModel.h"

@implementation COFundStatusModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealFundStatusIsPaid"          : @"ongoing",
        @"dealFundStatusIsSigned"        : @"funded",
    };
}

- (BOOL )boolOfIsPaid {
    return self.dealFundStatusIsPaid;
}

- (BOOL )boolOfIsSigned {
    return self.dealFundStatusIsSigned;
}

@end
