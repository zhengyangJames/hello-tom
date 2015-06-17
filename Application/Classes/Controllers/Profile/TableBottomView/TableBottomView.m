//
//  TableBottomView.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "TableBottomView.h"
#import "COPositive&NagitiveButton.h"

@interface TableBottomView ()
{
    __weak IBOutlet COPositive_NagitiveButton *_btnUpdate;
}

@end

@implementation TableBottomView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
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
    if (self.actionButtonUpdate) {
        self.actionButtonUpdate(_btnUpdate.titleLabel.text);
    }
}

@end
