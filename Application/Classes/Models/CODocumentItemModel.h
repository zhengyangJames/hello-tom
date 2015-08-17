//
//  CODocumentItemModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/17/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CODocumentItemModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *docItemUrl;
@property (nonatomic, strong) NSString *docItemTitle;

@end
