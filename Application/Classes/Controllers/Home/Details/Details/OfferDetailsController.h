//
//  OfferDetailsController.h
//  CoAssets
//
//  Created by TruongVO07 on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "BaseViewController.h"
#import "COOfferData.h"

@interface OfferDetailsController : BaseViewController

@property (nonatomic, strong) id<COOfferDescription> offerDescription;
@property (nonatomic, strong) id<COOfferAddress> offerAddress;
@property (nonatomic, strong) id<COOfferProject> offerProject;

@end
