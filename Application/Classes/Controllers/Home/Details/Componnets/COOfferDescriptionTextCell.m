//
//  CODetailsTextCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "COOfferDescriptionTextCell.h"

@interface COOfferDescriptionTextCell () <UIWebViewDelegate>
{
    __weak IBOutlet UITextView  *_detailsTextView;
    __weak IBOutlet UILabel     *_headerLabel;
}
@end

@implementation COOfferDescriptionTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Set Get

- (void)setOfferDescription:(id<COOfferDescription>)offerDescription {
    _offerDescription = offerDescription;
    _headerLabel.text = self.offerDescription.offerDescriptionTitle;
    _detailsTextView.text = self.offerDescription.offerDescriptionContent;
}

- (void)setOfferDocumentInfo:(id<COOfferDocument>)offerDocumentInfo {
    _offerDocumentInfo = offerDocumentInfo;
    _headerLabel.text = self.offerDocumentInfo.offerDocumentTitle;
    _detailsTextView.text = self.offerDocumentInfo.offerDocumentContent;
}

- (void)setOfferAddress:(id<COOfferAddress>)offerAddress {
    _offerAddress = offerAddress;
    _headerLabel.text = self.offerAddress.offerAddressTitle;
    _detailsTextView.text = self.offerAddress.offerAddressContent;
}
@end
