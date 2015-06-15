//
//  DropListCell.m
//  CoAssest
//
//  Created by TUONG DANG on 6/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DropListCell.h"

@interface DropListCell() {
    __weak IBOutlet UILabel *_lblnameTitle;
    __weak IBOutlet UILabel *_lblnameDetail;
}

@end

@implementation DropListCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setObject:(NSDictionary *)object {
    _object = object;
    _lblnameDetail.text = [object valueForKey:@"name"];
    _lblnameTitle.text = [object valueForKey:@"code"];
}

@end
