//
//  HomeListViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "HomeListViewController.h"

@interface HomeListViewController ()

@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssest");
}


@end
