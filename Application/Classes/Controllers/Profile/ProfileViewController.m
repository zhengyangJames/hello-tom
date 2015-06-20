//
//  ProfileViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ProfileViewController.h"
#import "TableHeaderView.h"
#import "TableBottomView.h"
#import "AboutTableViewCell.h"
#import "CompanyTableViewCell.h"
#import "CompanyTableViewCell2.h"
#import "PasswordTableViewCell.h"
#import "EditAboutProfileVC.h"
#import "EditCompanyVC.h"
#import "LoadFileManager.h"
#import "ProfileObject.h"
#import "CODummyDataManager.h"
#import "ProfileObject.h"

#define DEFAULT_HEIGHT_CELL             44

#define AUTO_HEIGHT_CELL_ABOUT          (self.view.bounds.size.height - (200+90))/6

#define AUTO_HEIGHT_CELL_COMPANY        (self.view.bounds.size.height - (200+90+44))
#define DEFAULT_HEIGHT_CELL_COMPANY     205

#define AUTO_HEIGHT_CELL_PASSWORD       (self.view.bounds.size.height - (200+90))
#define DEFAULT_HEIGHT_CELL_PASSWORD    231

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak  IBOutlet UITableView *_tableView;
    TableHeaderView *_tableheaderView;
    TableBottomView *_tablefooterView;
    NSInteger _indexSelectSeg;
}
@property (strong, nonatomic) ProfileObject *profileObject;

@end

@implementation ProfileViewController

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
    self.navigationItem.title = m_string(@"CoAssests");
    [self _setupHeaderTableView];
    [self _setupFooterTableView];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[AboutTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[AboutTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompanyTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[CompanyTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompanyTableViewCell2 identifier] bundle:nil] forCellReuseIdentifier:[CompanyTableViewCell2 identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[PasswordTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[PasswordTableViewCell identifier]];
}

- (void)_setupCellStyle:(NSInteger)index {
    _indexSelectSeg = index;
    [_tableView reloadData];
    switch (_indexSelectSeg) {
        case 0:
        {
            ((TableBottomView *)_tableView.tableFooterView.subviews[0]).lblUpdateButton = m_string(@"Update profile");
        }
            break;
        case 1:
        {
            ((TableBottomView *)_tableView.tableFooterView.subviews[0]).lblUpdateButton = m_string(@"Update company profile");
        }
            break;
        case 2:
        {
            ((TableBottomView *)_tableView.tableFooterView.subviews[0]).lblUpdateButton = m_string(@"Update password");
        }
            break;
        default:
            break;
    }
}

#pragma mark - Private 
- (void)_setupHeaderTableView {
    __weak __typeof__(self) weakSelf = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    _tableheaderView   = [[TableHeaderView alloc] initWithNibName:[TableHeaderView identifier]];
    [_tableheaderView setActionSegment:^(NSInteger indexSelectSegment){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf _setupCellStyle:indexSelectSegment];
    } ];
    _tableheaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:_tableheaderView];
    [_tableheaderView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableHeaderView = headerView;
}

- (void)_setupFooterTableView {
    __weak __typeof__(self) weakSelf = self;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 90)];
    _tablefooterView   = [[TableBottomView alloc] initWithNibName:[TableBottomView identifier]];
    [_tablefooterView setActionButtonUpdate:^(NSString *string){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf __actionButtonUpdate:string];
    }];
    _tablefooterView.translatesAutoresizingMaskIntoConstraints = NO;
    [footerView addSubview:_tablefooterView];
    [_tablefooterView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableFooterView = footerView;
}


#pragma mark - Setter Getter

- (ProfileObject*)profileObject {
    if (!_profileObject) {
        NSArray *arr = [[CODummyDataManager shared] arrayAboutProfileObj];
        return _profileObject = arr[0];
    }
    return _profileObject;
}


#pragma mark - Action
- (void)__actionButtonUpdate:(NSString*)string {
    if ([string isEqualToString:@"Update profile"]) {
        EditAboutProfileVC *vc = [[EditAboutProfileVC alloc]init];
        BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
    } else if([string isEqualToString:@"Update company profile"]){
        EditCompanyVC *vc = [[EditCompanyVC alloc]init];
        BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
    } else {
        [UIHelper showAleartViewWithTitle:m_string(@"CoAssests") message:m_string(@"Update Password Success") cancelButton:m_string(@"OK") delegate:nil tag:0 arrayTitleButton:nil];
    }
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return 6;
    } else if(TableViewCellStyleCompany == _indexSelectSeg) {
        return 2;
    }else{
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return [self _setupAboutCell:tableView cellForRowAtIndexPath:indexPath];
    } else if(TableViewCellStyleCompany == _indexSelectSeg) {
        if (indexPath.row == 0) {
            return  [self _setupCompanyCell:tableView cellForRowAtIndexPath:indexPath];
        }else {
            return  [self _setupCompanyCell2:tableView cellForRowAtIndexPath:indexPath];
        }
    }else{
        return [self _setupPasswordCell:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return AUTO_HEIGHT_CELL_ABOUT < DEFAULT_HEIGHT_CELL ? DEFAULT_HEIGHT_CELL : AUTO_HEIGHT_CELL_ABOUT;
    } else if(TableViewCellStyleCompany == _indexSelectSeg) {
        if (indexPath.row == 0) {
            return AUTO_HEIGHT_CELL_COMPANY > DEFAULT_HEIGHT_CELL_COMPANY ? AUTO_HEIGHT_CELL_COMPANY : DEFAULT_HEIGHT_CELL_COMPANY;
        }else {
            return DEFAULT_HEIGHT_CELL ;
        }
    }else{
        return AUTO_HEIGHT_CELL_PASSWORD < DEFAULT_HEIGHT_CELL_PASSWORD ? DEFAULT_HEIGHT_CELL_PASSWORD : AUTO_HEIGHT_CELL_PASSWORD;
    }
}

/*
 Setup Cell Style
 */

- (AboutTableViewCell*)_setupAboutCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCell *aboutCell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell identifier]
                                                                    forIndexPath:indexPath];
    if (indexPath.row == 0) {
        aboutCell.lblDetail.text = self.profileObject.salutation;
        aboutCell.lblname.text = m_string(@"Salutation");
    } else if (indexPath.row == 1) {
        aboutCell.lblDetail.text = self.profileObject.firstname;
        aboutCell.lblname.text = m_string(@"First Name");
    } else if (indexPath.row == 2) {
        aboutCell.lblDetail.text = self.profileObject.lastnameurname;
        aboutCell.lblname.text = m_string(@"Last Name/Surname");
    } else if (indexPath.row == 3) {
        aboutCell.lblDetail.text = self.profileObject.email;
        aboutCell.lblname.text = m_string(@"Email");
    } else if (indexPath.row == 4) {
        aboutCell.lblDetail.text = self.profileObject.phone;
        aboutCell.lblname.text = m_string(@"Phone");
    } else {
        aboutCell.lblDetail.text = self.profileObject.address;
        aboutCell.lblname.text = m_string(@"Address");
    }
    aboutCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return aboutCell;
}

- (CompanyTableViewCell*)_setupCompanyCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:[CompanyTableViewCell identifier]
                                                                        forIndexPath:indexPath];
    companyCell.lblDetail.text = self.profileObject.orgname;
    companyCell.lblname.text = m_string(@"Orgname");
    companyCell.image.image = [UIImage imageNamed:self.profileObject.image];
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return companyCell;
}

- (CompanyTableViewCell2*)_setupCompanyCell2:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompanyTableViewCell2 *companyCell = [tableView dequeueReusableCellWithIdentifier:[CompanyTableViewCell2 identifier]
                                                                        forIndexPath:indexPath];
    companyCell.lblDetail.text = self.profileObject.address;
    companyCell.lblname.text = m_string(@"Address");
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return companyCell;
}

- (PasswordTableViewCell*)_setupPasswordCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PasswordTableViewCell *passwordCell = [tableView dequeueReusableCellWithIdentifier:[PasswordTableViewCell identifier]
                                                                          forIndexPath:indexPath];
    passwordCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return passwordCell;
}

@end
