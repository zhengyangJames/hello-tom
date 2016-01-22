//
//  BaseViewController.m
//  NikmeApps
//
//  Created by Linh NGUYEN on 9/5/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initUI];
}

- (void)_initUI
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:kNOTIFICATION_QUESTION object:nil];
    [kNotificationCenter removeObserver:self name:kNOTIFICATION_INTERESTED object:nil];
}

@end
