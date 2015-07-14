//
//  TableBottomViewCell.m
//  CoAssets
//
//  Created by TUONG DANG on 7/14/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "TableBottomViewCell.h"
#import "COPositive&NagitiveButton.h"

@interface TableBottomViewCell ()
{
    __weak IBOutlet COPositive_NagitiveButton *_btnUpdate;
}

@end

@implementation TableBottomViewCell

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.lblUpdateButton = self.lblUpdateButton;
}


#pragma mark - SetupUI

- (void)_setupUI {
    
}

#pragma mark - Set Get

- (void)setLblUpdateButton:(NSString *)lblUpdateButton {
    _lblUpdateButton = lblUpdateButton;
    [_btnUpdate setTitle:_lblUpdateButton forState:UIControlStateNormal];
}

#pragma mark - Action

- (IBAction)__actionButtonUpdate:(id)sender {
    if ([self.delegate respondsToSelector:@selector(tableBottomView:titlerButton:)]) {
        [self.delegate tableBottomView:self titlerButton:_btnUpdate.titleLabel.text];
    }
}

@end
