//
//  COProjectModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COProjectModel.h"

@implementation COProjectModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"projectCity"          : @"city",
        @"projectCountry"       : @"country",
        @"projectId"            : @"id",
        @"projectAddress1"      : @"address_1",
        @"projectStateRegion"   : @"state_region",
        @"projectDeveloper"     : @"developer",
        @"projectPhoto"         : @"photo",
        @"projectAddress2"      : @"address_2",
        @"projectType"          : @"project_type",
        @"projectName"          : @"name"
             };
}

#pragma mark - address protocol

- (NSString *)offerAddressTitle {
    return NSLocalizedString(@"ADDRESS", nil);
}

- (NSString *)offerAddressContent {
    return [[[[self.projectAddress1 stringByAppendingString:@"\n"] stringByAppendingString:self.projectCity] stringByAppendingString:@"\n"] stringByAppendingString:self.projectCountry];
}
@end
