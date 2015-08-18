//
//  DocumentValueTransformer.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentValueTransformer.h"
#import "CODocumentModel.h"

@implementation CODocumentValueTransformer

- (id)init {
    self = [super init];
    return self;
}

+ (NSValueTransformer *)convertToArrayWithDictionary:(id)dictionary {
    NSValueTransformer *ad = [[NSValueTransformer alloc] init];
    NSDictionary *dic = dictionary;
    NSMutableArray *array;
    if (dictionary) {
        array = [[NSMutableArray alloc] init];
        for (NSString *key in dic.allKeys) {
            CODocumentModel *document = [[CODocumentModel alloc] init];
            NSArray *items = [dictionary objectForKey:key];
            document.title = key;
            document.items = items;
            [array addObject:document];
        }
    }
    id model = [ad transformedValue:array];
    return model;
}

@end
