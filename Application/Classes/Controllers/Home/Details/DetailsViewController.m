//
//  DetailsViewController.m
//  CoAssest
//
//  Created by TUONG DANG on 6/18/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DetailsViewController.h"
#import "CODetailsDataSource.h"
#import "CODetailsDelegate.h"

@interface DetailsViewController () <CODetailsAccessoryCellDelegate,CODetailsProjectCellDelegate,CODetailsController>
{

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    CODetailsDataSource *dataSource = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = dataSource;
    
    CODetailsDelegate *deleGate = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate = deleGate;
    [self.tableView reloadData];
}

@end
