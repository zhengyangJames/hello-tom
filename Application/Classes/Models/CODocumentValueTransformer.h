//
//  DocumentValueTransformer.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CODocumentValueTransformer : NSValueTransformer

+ (NSValueTransformer *)convertToArrayWithDictionary:(id)dictionary;

@end
