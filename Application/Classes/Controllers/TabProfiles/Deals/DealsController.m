//
//  DealsController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DealsController.h"

@interface DealsController ()

@end

@implementation DealsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = NSLocalizedString(@"Deals", nil);
}

@end
