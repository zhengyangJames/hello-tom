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


#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
    _detailsTextView.text = @"";
    _headerLabel.text = @"";
}

@end
