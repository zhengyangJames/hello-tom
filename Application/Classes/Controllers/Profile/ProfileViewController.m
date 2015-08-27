//
//  ProfileViewController.m
//  CoAssest
//
//  Created by Macintosh HD on 6/10/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "ProfileViewController.h"
#import "TableHeaderView.h"
#import "AboutTableViewCell.h"
#import "PasswordTableViewCell.h"
#import "EditAboutProfileVC.h"
#import "EditCompanyVC.h"
#import "LoadFileManager.h"
#import "NSString+Validation.h"
#import "WSURLSessionManager+Profile.h"
#import "LoginViewController.h"
#import "WSURLSessionManager+User.h"
#import "AboutTableViewCellAddress.h"
#import "TableBottomViewCell.h"
#import "COUserProfileModel.h"
#import "COLoginManager.h"

@interface ProfileViewController ()
<UITableViewDataSource,
UITableViewDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate,
UIAlertViewDelegate,
PasswordTableViewCellDelegate,
EditAboutProfileVCDelegate,
TableHeaderViewDelegate,
LoginViewControllerDelegate,
TableBottomViewCellDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    UIImage *_imageCompany;
    NSInteger _indexSelectSeg;
    NSDictionary *oldTokenObj;
}
@property (weak, nonatomic  ) TableBottomViewCell   *tableBottomViewCell;
@property (strong, nonatomic) TableHeaderView       *tableheaderView;
@property (weak, nonatomic  ) PasswordTableViewCell *passwordTableViewCell;
@property (strong, nonatomic) NSArray               *arrayCountryCode;
@property (strong, nonatomic) COUserProfileModel *userModel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(__actionUpdateProfile) name:kUPDATE_PROFILE object:nil];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [_tableView reloadData];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = NSLocalizedString(@"COASSETS_TITLE", nil);
    [self _setupHeaderTableView];
    [self _setupFooterTableView];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[AboutTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[AboutTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[PasswordTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[PasswordTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[AboutTableViewCellAddress identifier] bundle:nil] forCellReuseIdentifier:[AboutTableViewCellAddress identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[TableBottomViewCell identifier] bundle:nil] forCellReuseIdentifier:[TableBottomViewCell identifier]];
}

- (void)_setupCellStyle:(NSInteger)index {
    _indexSelectSeg = index;
    [_tableView reloadData];
}

#pragma mark - Private

- (void)_setupHeaderTableView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, HIEGHT_HEADERVIEW)];
    _tableheaderView   = [[TableHeaderView alloc] initWithNibName:[TableHeaderView identifier]];
    _tableheaderView.delegate = self;
    _tableheaderView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:_tableheaderView];
    [_tableheaderView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableHeaderView = headerView;
}

- (void)_setupFooterTableView {
    UIView *footerView = [[UIView alloc] init];
    _tableView.tableFooterView = footerView;
}

- (void)_setupEditAboutProfileVC {
    EditAboutProfileVC *vc = [[EditAboutProfileVC alloc]init];
    vc.delegate = self;
    vc.aboutUserModel = self.userModel;
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

#pragma mark - Setter Getter

- (NSString*)_getPhoneCode:(NSString*)phoneCode {
    NSString *str = @"";
    for (int i = 0 ; i < self.arrayCountryCode.count; i++) {
        if ([phoneCode isEqualToString:[self.arrayCountryCode[i] objectForKey:@"code"]]) {
            str = [self.arrayCountryCode[i] objectForKey:@"code"];
        }
    }
    return str;
}

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    return _userModel = [[COLoginManager shared] userModel];
}
#pragma mark - Action
- (void)__actionButtonUpdate:(NSString*)string {
    if ([string isEqualToString:UPDATE_ABOUT_PROFILE]) {
        [self _setupEditAboutProfileVC];
    } else {
        [kNotificationCenter postNotificationName:@"check_password" object:nil];
    }
}

- (void)__actionUpdateProfile {
    self.userModel = nil;
    [self userModel];
}

#pragma mark - Web Service

- (void)_callWSChangePassword:(NSDictionary*)param {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsChangePassword:self.userModel body:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_CHANGE_SUCCESSFULLY", nil) delegate:self tag:0];
        } else {
            [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PASSWORD_NOT_CHANGED", nil) delegate:self tag:0];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.view endEditing:YES];
        }];
        [UIHelper hideLoadingFromView:self.view];
    }];
    
}


#pragma mark - TableView DataSource

- (CGFloat)_heightForTableView:(UITableView*)tableView cell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    CGSize cellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return cellSize.height;
}
/*
 Setup Cell Style
 */

- (AboutTableViewCell*)_setupAboutCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCell *aboutCell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell identifier]
                                                                    forIndexPath:indexPath];
    aboutCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == COAboutProfileStyleFirstName) {
        aboutCell.userFirstName = self.userModel;
    } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
        aboutCell.userLastName = self.userModel;
    } else if (indexPath.row == COAboutProfileStyleEmail) {
        aboutCell.userEmail = self.userModel;
    } else {
         aboutCell.userPhone = self.userModel;
    }
    return aboutCell;
}

- (AboutTableViewCellAddress*)_setupAboutCell_Address:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCellAddress *cell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCellAddress identifier]];
    cell.userAddress = self.userModel;
    return cell;
}

- (PasswordTableViewCell*)_setupPasswordCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _passwordTableViewCell = [tableView dequeueReusableCellWithIdentifier:[PasswordTableViewCell identifier] forIndexPath:indexPath];
    _passwordTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _passwordTableViewCell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    _passwordTableViewCell.delegate = self;
    return _passwordTableViewCell;
}

- (TableBottomViewCell*)_setupTableBottomViewCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _tableBottomViewCell = [tableView dequeueReusableCellWithIdentifier:[TableBottomViewCell identifier]];
    _tableBottomViewCell.separatorInset = UIEdgeInsetsMake(0.0, tableView.bounds.size.width+10, 0.0, 0.0);
    if (_indexSelectSeg == TableViewCellStyleAbout) {
        _tableBottomViewCell.lblUpdateButton = NSLocalizedString(@"UPDATE_PROFILE", nil);
    } else {
        _tableBottomViewCell.lblUpdateButton = NSLocalizedString(@"UPDATE_PASSWORD", nil);
    }
    _tableBottomViewCell.delegate = self;
    _tableBottomViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _tableBottomViewCell;
}

#pragma mark - TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return kNUMBERS_OF_ROW_OF_ABOUT;
    } else {
        return kNUMBERS_OF_ROW_OF_CHANGE_PASS;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        if (indexPath.row == kNUMBERS_OF_ROW_OF_ABOUT - 2) {
            return [self _setupAboutCell_Address:tableView cellForRowAtIndexPath:indexPath];
        } else if (indexPath.row == kNUMBERS_OF_ROW_OF_ABOUT - 1) {
            return [self _setupTableBottomViewCell:tableView cellForRowAtIndexPath:indexPath];
        } else {
            return [self _setupAboutCell:tableView cellForRowAtIndexPath:indexPath];
        }
    } else {
        if (indexPath.row == 1) {
            return [self _setupTableBottomViewCell:tableView cellForRowAtIndexPath:indexPath];
        } else {
            if (!_passwordTableViewCell) {
                _passwordTableViewCell = [self _setupPasswordCell:tableView cellForRowAtIndexPath:indexPath];
            }
            return _passwordTableViewCell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        if (indexPath.row == 4) {
            if(IS_IOS8_OR_ABOVE) {
                height = UITableViewAutomaticDimension;
                return height;
            } else {
                id cell = [self _setupAboutCell_Address:tableView cellForRowAtIndexPath:indexPath];
                height = [self _heightForTableView:tableView cell:cell atIndexPath:indexPath];
                return height;
            }
        } else if (indexPath.row == 5) {
            return height = 90;
        } else {
            return 40;
        }
    } else {
        if (indexPath.row == 1) {
            return 90;
        } else {
            return DEFAULT_HEIGHT_CELL_PASSWORD;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath*)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        if (indexPath.row == 4) {
            return 44;
        } else {
            return 40 ;
        }
    } else {
        if (indexPath.row == 1) {
            return 90;
        } else {
            return DEFAULT_HEIGHT_CELL_PASSWORD;
        }
    }
}


#pragma mark - Other Delegate
- (void)passwordTableViewCellTextFieldAction:(PasswordTableViewCell *)passwordTableViewCell newPassowrd:(NSString *)newPassowrd {
    [self _callWSChangePassword:@{@"new_password":newPassowrd}];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _passwordTableViewCell.newpassowrdTXT.text = @"";
    _passwordTableViewCell.comfilmPassowrdTXT.text = @"";
    [self.view endEditing:YES];
}

- (void)editAboutProfile:(EditAboutProfileVC *)editAboutProfileVC {
    _userModel = nil;

}

- (void)tableHeaderView:(TableHeaderView *)tableHeaderView indexSelectSegment:(NSInteger)indexSelect {
    [self _setupCellStyle:indexSelect];
}

- (void)tableBottomView:(TableBottomViewCell *)tableBottomView titlerButton:(NSString *)titlerButton {
    [self __actionButtonUpdate:titlerButton];
}

@end
