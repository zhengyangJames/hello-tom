
//
//  COFilterListModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/20/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COFilterListModel.h"

@implementation COFilterListModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"key" : @"key",
        @"value" : @"value"
    };
}

- (NSString *)filterTitle {
    return self.key;
}
- (NSString *)filterValue {
    return self.value;
}
@end
