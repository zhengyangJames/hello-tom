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
#import "CoDetailsHeaderTableView.h"

@interface DetailsViewController () 
{
    CoDetailsHeaderTableView *_tableheaderView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CODetailsDataSource *detailsDataSource;
@property (strong, nonatomic) CODetailsDelegate *detailsDelegate;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self _setupHeaderTableView];
    self.detailsDataSource = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = self.detailsDataSource;
    
    self.detailsDelegate = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate = self.detailsDelegate;
    
    [self.tableView reloadData];
}

#pragma mark - Private
- (void)_setupHeaderTableView {
    __weak __typeof__(self) weakSelf = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 185)];
    _tableheaderView   = [[CoDetailsHeaderTableView alloc] initWithNibName:[CoDetailsHeaderTableView identifier]];
    [_tableheaderView setActionPopView:^(){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    } ];
    _tableheaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:_tableheaderView];
    [_tableheaderView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    self.tableView.tableHeaderView = headerView;
}

@end
