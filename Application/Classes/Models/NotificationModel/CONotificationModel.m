//
//  CONotificationModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CONotificationModel.h"
#import "CONotificationDataModel.h"
#import "MTLValueTransformer.h"

@implementation CONotificationModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"notifiAlert"      : @"alert",
        @"notifiData"       : @"data",
    };
}

+ (NSValueTransformer *)notifiDataJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:CONotificationDataModel.class];
}

- (NSString *)stringOfAlert {
    return self.notifiAlert;
}

@end
