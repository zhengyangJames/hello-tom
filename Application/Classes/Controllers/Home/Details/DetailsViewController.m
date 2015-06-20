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
#import "COSlidingView.h"


@interface DetailsViewController () 
{
    CoDetailsHeaderTableView *_tableheaderView;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CODetailsDataSource *detailsDataSource;
@property (strong, nonatomic) CODetailsDelegate *detailsDelegate;
@property (nonatomic, weak) IBOutlet COSlidingView *headerSliderView;


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
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self _setupHeaderView];
    [self _setSliderHeaderView];
    self.detailsDataSource = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = self.detailsDataSource;
    
    self.detailsDelegate = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate = self.detailsDelegate;
    
    [self.tableView reloadData];
}

#pragma mark - Action 
- (IBAction)__actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private 
- (void)_setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableHeaderView = headerView;
}

- (void)_setSliderHeaderView {
    COSlidingView *viewSliding = [[COSlidingView alloc] initWithNibName:[COSlidingView identifier]];
    viewSliding.translatesAutoresizingMaskIntoConstraints = NO;
    viewSliding.arrayImage = @[@"19.jpg",@"9.jpg",@"17.jpg",@"17.jpg",@"1.jpg",@"15.jpg",@"6.jpg",@"8.jpg",@"11.jpg",@"13.jpg"];
    [_headerSliderView addSubview:viewSliding];
    [viewSliding pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

@end

