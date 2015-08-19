//
//  CODetailsAccessoryCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsAccessoryCell.h"
#import "CODocumentModel.h"
#import "CODocumentItemModel.h"

@interface CODetailsAccessoryCell() {
    __weak IBOutlet UILabel  *_detailsLabel;
}

@end

@implementation CODetailsAccessoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}


#pragma mark - Set Get

- (void)setOfferDocDetail:(id<COOfferDocumentDetail>)offerDocDetail {
    _offerDocDetail = offerDocDetail;
    NSArray *array = _offerDocDetail.offerDocumentDetail;
    if (array && array.count > 0) {
        CODocumentModel *docModel = [array objectAtIndex:self.indexPath.section];
        if (docModel.items && docModel.items.count > 0) {
            CODocumentItemModel *item = docModel.items[self.indexPath.row];
            _detailsLabel.text = item.docItemTitle;
        } else {
            _detailsLabel.text = NSLocalizedString(@"NoDocumentsUploaded", nil);
        }
    } else {
        _detailsLabel.text = NSLocalizedString(@"NoDocumentsUploaded", nil);
    }
}

#pragma mark - Action
- (IBAction)__actionTapCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsAccessoryCell:didSelectCell:)]) {
        [self.delegate detailsAccessoryCell:self didSelectCell:nil];
    }
}


@end
