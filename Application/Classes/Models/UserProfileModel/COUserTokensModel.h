//
//  UserTokensModel.h
//  CoAssets
//
//  Created by Nikmesoft_M008 on 8/21/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface COUserTokensModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *tokenId;
@property (nonatomic, strong) NSNumber *tokenCreditQty;
@end
