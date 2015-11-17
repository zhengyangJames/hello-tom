//
//  CONotificationDataModel.m
//  CoAssets
//
//  Created by Nikmesoft_M007 on 11/16/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "CONotificationDataModel.h"

@implementation CONotificationDataModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"notifiStatus"      : @"status",
        @"notifiUrl"         : @"url",
        @"notifiDateTime"    : @"date_time_created",
        @"notifiType"        : @"type",
        @"notifiId"          : @"id",
        @"notifiUnique"      : @"unique_id",
    };
}

- (NSString *)stringOfdata {
    return self.notifiDateTime;
}

- (NSNumber *)numberOfId {
    return self.notifiId;
}

@end
