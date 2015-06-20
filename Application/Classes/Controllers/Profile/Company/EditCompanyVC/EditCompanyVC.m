//
//  EditCompanyVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditCompanyVC.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"

@interface EditCompanyVC ()
{
    __weak IBOutlet CoDropListButtom *_btnOrgType;
    NSInteger _indexActtionOrgType;
}
@end

@implementation EditCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"Investment Profile");
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc] initWithTitle:m_string(@"Submit") style:UIBarButtonItemStyleDone target:self action:@selector(__actionDone:)];
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(__actionDCancel:)];
    self.navigationItem.rightBarButtonItem = btDone;
    self.navigationItem.leftBarButtonItem = btCancel;
    _indexActtionOrgType = 0;
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

- (IBAction)__actionOrgType:(id)sender {
    NSArray *array = @[@"Developer",@"Property Insurance",@"Marketing",@"Property For Sale",@"Business Services",@"Route Sale",@"Rummage Sale",@"The cosmetics industry"];
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Org Type" data:array selectedIndex:_indexActtionOrgType didSelect:^(NSInteger index) {
        [_btnOrgType setTitle:array[index] forState:UIControlStateNormal];
        _indexActtionOrgType = index;
    }];
}

@end
