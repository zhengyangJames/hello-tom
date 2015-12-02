//
//  COTextCell.h
//  CoAssets
//
//  Created by TruongVO07 on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "COOfferData.h"

@interface COTextCell : UITableViewCell

@property (nonatomic, strong) id<COOfferDescription> offerDescription;
@property (nonatomic, strong) id<COOfferDocument> offerDocumentInfo;
@property (nonatomic, strong) id<COOfferProject> offerProject;
@property (nonatomic, strong) id<COOfferAddress> offerAddress;

@end
