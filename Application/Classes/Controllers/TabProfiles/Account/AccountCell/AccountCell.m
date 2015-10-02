//
//  AccountCell.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AccountCell.h"
#import "BaseLabel.h"

@interface AccountCell ()
{
    __weak IBOutlet BaseLabel *_lblValue;
    __weak IBOutlet BaseLabel *_lblDetail;
}
@end

@implementation AccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setObject:(NSString *)object {
    _object = object;
    _lblDetail.text = object;
}

@end

