//
//  COTextCell.m
//  CoAssets
//
//  Created by TruongVO07 on 11/30/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "COTextCell.h"

@interface COTextCell ()
{
    __weak IBOutlet UILabel *_headerLabel;
}
@end

@implementation COTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

#pragma mark - Set Get

- (void)setOfferDescription:(id<COOfferDescription>)offerDescription {
    _offerDescription       = offerDescription;
    _headerLabel.text       = offerDescription.offerDescriptionTitle;
}

- (void)setOfferDocumentInfo:(id<COOfferDocument>)offerDocumentInfo {
    _offerDocumentInfo      = offerDocumentInfo;
    _headerLabel.text       = offerDocumentInfo.offerDocumentTitle;
}

- (void)setOfferAddress:(id<COOfferAddress>)offerAddress {
    _offerAddress           = offerAddress;
    _headerLabel.text       = offerAddress.offerAddressTitle;
}

- (void)setOfferProject:(id<COOfferProject>)offerProject {
    _offerProject = offerProject;
     _headerLabel.text = offerProject.offerProjectTitle;
}

@end
