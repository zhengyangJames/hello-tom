//
//  CODetailsAccessoryCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODocumentItemCell.h"
#import "CODocumentModel.h"
#import "CODocumentItemModel.h"

@interface CODocumentItemCell() {
    __weak IBOutlet UILabel  *_detailsLabel;
    __weak IBOutlet UIButton *_btnAction;
}

@end

@implementation CODocumentItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    _detailsLabel.text  = NSLocalizedString(@"NoDocumentsUploaded", nil);
}


#pragma mark - Set Get

- (void)setDocDetailItem:(id<CODocumentItem>)docDetailItem {
    _docDetailItem = docDetailItem;
    if (docDetailItem.itemTitle) {
        _detailsLabel.text = docDetailItem.itemTitle;
    }
}

#pragma mark - Action
- (IBAction)__actionTapCell:(id)sender {
    if (_docDetailItem.itemTitle != nil) {
        if ([self.delegate respondsToSelector:@selector(showWebsiteWithTitle:andUrl:)]) {
            [self.delegate showWebsiteWithTitle:_docDetailItem.itemTitle andUrl:_docDetailItem.itemUrl];
        }
    }
}
@end
