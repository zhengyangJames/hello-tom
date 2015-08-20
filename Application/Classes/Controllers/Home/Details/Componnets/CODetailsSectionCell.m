//
//  CODetailsSectionCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/19/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsSectionCell.h"
#import "CODocumentModel.h"

@interface CODetailsSectionCell ()
{
    __weak IBOutlet UILabel *_lblSection;
}
@end

@implementation CODetailsSectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}

#pragma mark - Set Get
- (void)setDocDetail:(id<COOfferDocumentDetail>)docDetail {
    _docDetail = docDetail;
    NSString *title = NSLocalizedString(_docDetail.offerDocumentDetailTitle, nil);
    _lblSection.text = title;
}
	
@end
