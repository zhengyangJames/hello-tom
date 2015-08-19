//
//  CODetailsTextCell.h
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferData.h"

@interface CODetailsTextCell : UITableViewCell
@property (nonatomic, strong) id<COOfferDescription> offerDescription;
@property (nonatomic, strong) id<COOfferDocument> offerDocumentInfo;
@property (nonatomic, strong) id<COOfferAddress> offerAddress;
@end
