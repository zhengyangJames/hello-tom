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
#import "COLoginManager.h"

@interface NProfileController ()<NProfileHeaderViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    __weak NProfileHeaderView *_headerView;
}

@property (nonatomic, strong) NProfileDataSource *profileDatasource;
@property (nonatomic, strong) NProfileDelegate *profileDelegate;

@property (nonatomic, strong) NSArray *arrayObject;
@property (nonatomic, strong) NSArray *arrayAbout;
@property (nonatomic, strong) NSArray *arrayCompany;
@property (nonatomic, strong) NSArray *arrayInvestorProfile;
@property (nonatomic, assign) NSInteger profileStyle;

@property (nonatomic, strong) COUserProfileModel *userModel;

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

- (NSArray *)arrayObject {
    if (_arrayObject) {
        return _arrayObject;
    }
    _arrayObject = self.arrayAbout;
    self.profileStyle = NProfileStyleAbout;
    self.profileDatasource.userModel = self.userModel;
    return _arrayObject;
}

- (NSArray *)arrayAbout {
    if (_arrayAbout) {
        return _arrayAbout;
    }
    _arrayAbout = @[@"0", @"0",@"0", @"0",@"0", @"0",@"0"];
    return _arrayAbout;
}

- (NSArray *)arrayCompany {
    if (_arrayCompany) {
        return _arrayCompany;
    }
    _arrayCompany = @[@"1", @"1",@"1", @"1"];
    return _arrayCompany;
}

- (NSArray *)arrayInvestorProfile {
    if (_arrayInvestorProfile) {
        return _arrayInvestorProfile;
    }
    _arrayInvestorProfile = @[@"2", @"2",@"2", @"2",@"2", @"2",@"2"];
    return _arrayInvestorProfile;
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    return _userModel = [[COLoginManager shared] userModel];
}

#pragma mark - Private
- (void)_reloadTableview {
    self.profileDatasource.arrayObject = self.arrayObject;
    self.profileDatasource.profileStyle = self.profileStyle;
    self.profileDatasource.userModel = self.userModel;
    [_tableView reloadData];
}

#pragma mark - NProfileDeaderViewDelegate
- (void)nprofileHeaderView:(NProfileHeaderView *)profileHeader didSelectindex:(NSInteger)index {
    switch (index) {
        case NProfileStyleAbout:
            self.arrayObject = self.arrayAbout;
            self.profileStyle = NProfileStyleAbout;
            break;
        case NProfileStyleCompany:
            self.arrayObject = self.arrayCompany;
            self.profileStyle = NProfileStyleCompany;
            break;
        case NProfileStyleInvestorProfile:
            self.arrayObject = self.arrayInvestorProfile;
            self.profileStyle = NProfileStyleInvestorProfile;
            break;
    }
    [self _reloadTableview];
}

@end
