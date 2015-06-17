//
//  EditAboutProfileVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditAboutProfileVC.h"
#import "CODropListView.h"

@interface EditAboutProfileVC ()

@end

@implementation EditAboutProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private 

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"Basic Info");
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc] initWithTitle:m_string(@"Submit") style:UIBarButtonItemStyleDone target:self action:@selector(__actionDone:)];
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(__actionDCancel:)];
    self.navigationItem.rightBarButtonItem = btDone;
    self.navigationItem.leftBarButtonItem = btCancel;
}


#pragma mark - Action

- (void)__actionDone:(id)sender {

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)__actionDCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
