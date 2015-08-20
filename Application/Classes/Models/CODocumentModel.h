//
//  CODocumentModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COOfferData.h"

@class CODocumentItemModel;

@interface CODocumentModel : MTLModel<MTLJSONSerializing,COOfferDocumentDetail>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *items;

- (NSArray *)arrayOfItems;
@end
