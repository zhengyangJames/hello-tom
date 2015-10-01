//
//  NProfileController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/1/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "NProfileController.h"
#import "NProfileDataSource.h"
#import "NProfileDelegate.h"
#import "NProfileHeaderView.h"
#import "COUserProfileModel.h"
#import "COUserCompanyModel.h"
#import "COLoginManager.h"

@interface NProfileController ()<NProfileHeaderViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    __weak NProfileHeaderView *_headerView;
}

@property (nonatomic, strong) NProfileDataSource *profileDatasource;
@property (nonatomic, strong) NProfileDelegate *profileDelegate;

@property (nonatomic, assign) NSInteger profileStyle;
@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel *companyModel;

@end

@implementation NProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

#pragma mark - SetupUI
- (void)_setupUI {
    self.navigationItem.title = @"Profile";
    NProfileDataSource *datasource = [[NProfileDataSource alloc] initWithTableview:_tableView];
    NProfileDelegate *delegate = [[NProfileDelegate alloc] initWithTableview:_tableView];
    self.profileDatasource = datasource;
    self.profileDelegate = delegate;
    
    self.profileDatasource.profileStyle = NProfileStyleAbout;
    self.profileDatasource.userModel = self.userModel;
    self.profileDatasource.companyModel = self.companyModel;
    
    _tableView.delegate = self.profileDelegate;
    _tableView.dataSource = self.profileDatasource;
    _tableView.tableHeaderView = [self _headerView];
    _tableView.tableFooterView = [UIView new];
    
    [self _reloadTableview];
}

- (UIView *)_headerView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, HIEGHT_HEADERVIEW)];
    NProfileHeaderView *v = [[NProfileHeaderView alloc] initWithNibName:[NProfileHeaderView identifier]];
    v.delegate = self;
    v.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:v];
    [v pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _headerView = v;
    return headerView;
}

#pragma mark - Setter, Getter
- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    return _userModel = [[COLoginManager shared] userModel];
}

- (COUserCompanyModel *)companyModel {
    if (_companyModel) {
        return _companyModel;
    }
    return _companyModel = [[COUserCompanyModel alloc] init];
}

#pragma mark - Private
- (void)_reloadTableview {
    self.profileDatasource.profileStyle = self.profileStyle;
    self.profileDatasource.userModel = self.userModel;
    self.profileDatasource.companyModel = self.companyModel;
    [_tableView reloadData];
}

#pragma mark - NProfileDeaderViewDelegate
- (void)nprofileHeaderView:(NProfileHeaderView *)profileHeader didSelectindex:(NSInteger)index {
    self.profileStyle = index;
    [self _reloadTableview];
}

@end
