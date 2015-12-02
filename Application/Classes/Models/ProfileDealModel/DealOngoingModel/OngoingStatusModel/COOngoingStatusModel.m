//
//  COOngoingStatusModel.m
//  CoAssets
//
//  Created by Macintosh HD on 11/19/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COOngoingStatusModel.h"

@implementation COOngoingStatusModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"dealOngoingStatusIsPaid"          : @"is_paid",
        @"dealOngoingStatusIsSigned"        : @"is_signed",
    };
}

- (BOOL )boolOfIsPaid {
    return self.dealOngoingStatusIsPaid;
}

- (BOOL )boolOfIsSigned {
    return self.dealOngoingStatusIsSigned;
}

@end
