//
//  BaseTableViewCell.m
//  NikmeApps
//
//  Created by Linh NGUYEN on 9/13/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self viewDidLoad];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self viewDidLoad];
}

- (void)viewDidLoad {
    
}


@end