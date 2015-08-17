//
//  COOfferModel.h
//  CoAssets
//
//  Created by Linh NGUYEN on 8/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "COProjectModel.h"

@interface COOfferModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *offerId;
@property (nonatomic, strong) NSString *offerTitle;
@property (nonatomic, strong) NSString *offerType;
@property (nonatomic, strong) COProjectModel *offerProject;

@end
