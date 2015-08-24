//
//  COUserAccountModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/24/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface COUserAccountModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *accountType;
@property (nonatomic, strong) NSString *accountExpiry;
@end
