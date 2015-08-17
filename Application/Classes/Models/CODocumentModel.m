//
//  CODocumentModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentModel.h"
#import "CODocumentItemModel.h"

@implementation CODocumentModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"title" : @"title",
        @"items" : @"items"
    };
}

+ (NSValueTransformer *)itemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CODocumentItemModel class]];
}

@end
