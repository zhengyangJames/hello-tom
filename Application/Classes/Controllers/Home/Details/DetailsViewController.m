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
#import "COSlidingView.h"
#import "WSURLSessionManager+ListHome.h"
#import "UIImageView+Networking.h"

@interface DetailsViewController () 
{

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
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Setup
- (void)_setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self _setupHeaderView];
    self.detailsDataSource    = [[CODetailsDataSource alloc]initWithController:self tableView:self.tableView];
    self.tableView.dataSource = self.detailsDataSource;
    self.detailsDelegate      = [[CODetailsDelegate alloc]initWithController:self];
    self.tableView.delegate   = self.detailsDelegate;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.detailsDataSource.object = self.objectDetails;
        [self.tableView reloadData];
    }];
}

#pragma mark Set Get 
- (void)setObjectDetails:(CODetailsOffersObject *)objectDetails {
    _objectDetails = objectDetails;
}

#pragma Web Service 


#pragma mark - Action 
- (IBAction)__actionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private 
- (void)_setupHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSURL *url = [NSURL URLWithString:[self.objectDetails valueForKey:@"imageBig"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageView setImage:[UIImage imageNamed:@"ic_placeholder"]];
    [imageView setImageURL:url];
    [headerView addSubview:imageView];
    [imageView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    self.tableView.tableHeaderView = headerView;
}

@end

