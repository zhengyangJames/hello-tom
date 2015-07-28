//
//  BaseTabBarController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)_setupUI {
    [self.tabBar setTranslucent:NO];
    [self.tabBar setBarTintColor:KBACKGROUND_COLOR];
    [self.tabBar setTintColor:KNAV_BG_COLOR];
}

@end
