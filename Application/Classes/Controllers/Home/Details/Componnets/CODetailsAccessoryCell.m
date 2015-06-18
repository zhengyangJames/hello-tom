//
//  CODetailsAccessoryCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "CODetailsAccessoryCell.h"

@implementation CODetailsAccessoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


#pragma mark - Set Get
- (void)setObject:(NSDictionary *)object {
    _object = object;
    self.detailsLabel.text = @"";
}

#pragma mark - Action
- (IBAction)__actionTapCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(detailsAccessoryCell:didSelectCell:)]) {
        [self.delegate detailsAccessoryCell:self didSelectCell:nil];
    }
}


@end
