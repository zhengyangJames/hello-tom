//
//  ProfileViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - Setup
- (void)_setupUI {
   self.navigationItem.title = m_string(@"Profile");
}

@end
