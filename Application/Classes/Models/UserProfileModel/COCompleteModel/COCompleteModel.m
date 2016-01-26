//
//  COCompleteModel.m
//  CoAssets
//
//  Created by Macintosh HD on 1/26/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "COCompleteModel.h"

@implementation COCompleteModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"keyComplete"       : @"key",
        @"valueComplete"       : @"value",
    };
}
@end
