//
//  DocumentValueTransformer.m
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentValueTransformer.h"
#import "CODocumentModel.h"
#import "CODocumentItemModel.h"

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
            NSMutableArray *arrayAdd = [[NSMutableArray alloc] init];
            for (NSDictionary *diction  in  items) {
                CODocumentItemModel *itemModel = [[CODocumentItemModel alloc] init];
                itemModel.docItemUrl = [diction objectForKey:@"url"];
                itemModel.docItemTitle = [diction objectForKey:@"title"];
                [arrayAdd addObject:itemModel];
            }
            document.title = key;
            document.items = arrayAdd;
            [array addObject:document];
        }
    }
    id model = [ad transformedValue:array];
    return model;
}

@end
