//
//  SettingViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"Setting");
}

#pragma mark - Action
- (IBAction)__actionLogOut:(id)sender {
    [kAppDelegate gotoHome];
}

@end
