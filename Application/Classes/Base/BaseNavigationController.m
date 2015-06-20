//
//  BaseNavigationController.m
//  NikmeApps
//
//  Created by Linh NGUYEN on 9/5/14.
//  Copyright (c) 2014 Nikmesoft Ltd. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName :[UIFont fontWithName:@"Raleway-Regular" size:15]}];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationBar setBarTintColor:KNAV_BG_COLOR];
}

@end
