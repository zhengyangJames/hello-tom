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
#import "COUserInverstorModel.h"
#import "COLoginManager.h"
#import "EditAboutProfileVC.h"
#import "EditPasswordProfileVC.h"
#import "EditCompanyVC.h"

@interface NProfileController ()<NProfileHeaderViewDelegate,profileButtonCellDelegate,EditAboutProfileVCDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    __weak NProfileHeaderView *_headerView;
}

@property (nonatomic, strong) NProfileDataSource *profileDatasource;
@property (nonatomic, strong) NProfileDelegate *profileDelegate;

@property (nonatomic, assign) NSInteger profileStyle;
@property (nonatomic, strong) COUserProfileModel *userModel;
@property (nonatomic, strong) COUserCompanyModel *companyModel;
@property (nonatomic, strong) COUserInverstorModel *investorModel;

@end

@implementation NProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - SetupUI
- (void)_setupUI {
    self.navigationItem.title = @"Profile";
    NProfileDataSource *datasource = [[NProfileDataSource alloc] initWithTableview:_tableView controller:self];
    NProfileDelegate *delegate = [[NProfileDelegate alloc] initWithTableView:_tableView];
    self.profileDatasource = datasource;
    self.profileDelegate = delegate;

    
    self.profileDatasource.profileStyle = NProfileStyleAbout;
    self.profileDatasource.userModel = self.userModel;
    self.profileDatasource.companyModel = self.companyModel;
    self.profileDatasource.invedtorModel = self.investorModel;
    
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

- (COUserInverstorModel *)investorModel {
    if (_investorModel) {
        return _investorModel;
    }
    return _investorModel = [[COUserInverstorModel alloc] init];
}

#pragma mark - Private
- (void)_reloadTableview {
    self.profileDatasource.profileStyle = self.profileStyle;
    self.profileDatasource.userModel = self.userModel;
    self.profileDatasource.companyModel = self.companyModel;
    self.profileDatasource.invedtorModel = self.investorModel;
    [_tableView reloadData];
}

- (void)_setupEditAboutProfileVC {
    EditAboutProfileVC *vc = [[EditAboutProfileVC alloc]init];
    vc.delegate = self;
    vc.aboutUserModel = self.userModel;
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

- (void)_setupEditPasswordVC {
    EditPasswordProfileVC *vc = [[EditPasswordProfileVC alloc]init];
    
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

- (void)_setupEditCompanyVC {
    EditCompanyVC *vc = [[EditCompanyVC alloc]init];
    
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

#pragma mark - NProfileDeaderViewDelegate
- (void)nprofileHeaderView:(NProfileHeaderView *)profileHeader didSelectindex:(NSInteger)index {
    self.profileStyle = index;
    [self _reloadTableview];
}

- (void)acctionButtonProfileCell:(NprofileButtonCell *)profileButtonCell buttonStyle:(NProfileActionStyle)buttonStyle {
    switch (buttonStyle) {
        case NProfileActionUpdateProfile:
            [self _setupEditAboutProfileVC];
            break;
        case NProfileActionChangePassWord:
            [self _setupEditPasswordVC];
            break;
        case NProfileActionUpdateCompany:
            [self _setupEditCompanyVC];
            break;
        default:
            break;
    }
}

#pragma mark - Delegate EditProfile
- (void)editAboutProfile:(EditAboutProfileVC *)editAboutProfileVC {
    self.userModel = nil;
    [self _reloadTableview];
}

@end
