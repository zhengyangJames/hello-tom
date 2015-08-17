//
//  CODocumentItemModel.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentItemModel.h"

@implementation CODocumentItemModel

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    return @ {
        @"docItemUrl" : @"url",
        @"docItemTitle" : @"title"
    };
}

@end
