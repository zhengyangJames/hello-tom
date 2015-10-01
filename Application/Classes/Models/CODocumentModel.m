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
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value && [value isKindOfClass:[NSArray class]]) {
            NSMutableArray *finalArray = [NSMutableArray array];
            for (NSDictionary *dict in value) {
                NSURL *url = [NSURL URLWithString:[dict objectForKey:@"url"]];
                if(url && url.scheme && url.host) {
                    [finalArray addObject:dict];
                }
            }
            *success = YES;
            return [MTLJSONAdapter modelsOfClass:[CODocumentItemModel class] fromJSONArray:finalArray error:error];
        }
        *success = YES;
        return nil;
    }];
}

- (NSArray *)arrayOfItems {

    return self.items;
}
#pragma mark - doc detail protocol

- (NSString *)offerDocumentDetailTitle {
    return self.title;
}
- (NSArray *)offerDocumentDetailContent {
    return self.items;
}
@end
