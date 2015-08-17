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
        @"title" : @"licenses",
        @"value" : @"others",
    };
}

+ (NSValueTransformer *)valueJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:CODocumentItemModel.class];
}

@end
