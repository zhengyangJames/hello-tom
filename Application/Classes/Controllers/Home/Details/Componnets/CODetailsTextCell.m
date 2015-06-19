//
//  CODetailsTextCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsTextCell.h"

@interface CODetailsTextCell ()
{
    __weak IBOutlet UITextView  *_detailsTextView;
    __weak IBOutlet UILabel     *_headerLabel;
}

@end

@implementation CODetailsTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.contentView.frame = self.bounds;
}

#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
    _detailsTextView.text = [object valueForKeyNotNull:@"details"];
    _headerLabel.text = [object valueForKeyNotNull:@"status"];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

@end
