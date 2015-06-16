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
#import "PasswordTableViewCell.h"

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate>
{
    __weak  IBOutlet UITableView *_tableView;
    TableHeaderView *_tableheaderView;
    TableBottomView *_tablefooterView;
    NSInteger _indexSelectSeg;
}

@end

@implementation ProfileViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

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

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssest");
    
    __weak __typeof__(self) weakSelf = self;
    //setup header Tableview
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 215)];
    _tableheaderView   = [[TableHeaderView alloc] initWithNibName:[TableHeaderView identifier]];
    [_tableheaderView setActionSegment:^(NSInteger indexSelectSegment){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf _setupCellStyle:indexSelectSegment];
    } ];
    _tableheaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:_tableheaderView];
    [_tableheaderView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableHeaderView = headerView;
    
    //setup footer Tableview
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 90)];
    _tablefooterView   = [[TableBottomView alloc] initWithNibName:[TableBottomView identifier]];
    [_tablefooterView setActionButtonUpdate:^(){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf __actionButtonUpdate];
    }];
    _tablefooterView.translatesAutoresizingMaskIntoConstraints = NO;
    [footerView addSubview:_tablefooterView];
    [_tablefooterView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableFooterView = footerView;
    
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[AboutTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[AboutTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompanyTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[CompanyTableViewCell identifier]];
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

#pragma mark - Setter Getter


#pragma mark - Action
- (void)__actionButtonUpdate {
    DBG(@"Update Profile");
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (TableViewCellStyleAbout == _indexSelectSeg) {
        AboutTableViewCell *aboutCell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell identifier]
                                                                        forIndexPath:indexPath];
        aboutCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return aboutCell;
    } else if(TableViewCellStyleCompany == _indexSelectSeg) {
        CompanyTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:[CompanyTableViewCell identifier]
                                                                            forIndexPath:indexPath];
        companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return companyCell;
    }else{
        PasswordTableViewCell *passwordCell = [tableView dequeueReusableCellWithIdentifier:[PasswordTableViewCell identifier]
                                                                              forIndexPath:indexPath];
        passwordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return passwordCell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return 304;
    } else if(TableViewCellStyleCompany == _indexSelectSeg) {
        return 264;
    }else{
        return 231;
    }
}

@end
