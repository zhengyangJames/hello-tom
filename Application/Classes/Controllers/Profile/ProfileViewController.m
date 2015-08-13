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
#import "COListProfileObject.h"
#import "COListProfileObject.h"
#import "NSString+Validation.h"
#import "WSURLSessionManager+Profile.h"
#import "LoginViewController.h"
#import "WSURLSessionManager+User.h"
#import "AboutTableViewCellAddress.h"
#import "TableBottomViewCell.h"

#define DEFAULT_HEIGHT_CELL             44
#define AUTO_HEIGHT_CELL_ABOUT          (self.view.bounds.size.height - (200+90))/4
#define AUTO_HEIGHT_CELL_COMPANY        (self.view.bounds.size.height - (200+90+44))
#define DEFAULT_HEIGHT_CELL_COMPANY     205
#define AUTO_HEIGHT_CELL_PASSWORD       (self.view.bounds.size.height - (200+90))
#define DEFAULT_HEIGHT_CELL_PASSWORD    171
#define HIEGHT_HEADERVIEW               200
#define HIEGHT_BOTTOMVIEW               90

#define IS_IOS8_OR_ABOVE    [[[UIDevice currentDevice] systemVersion] floatValue] >= 8

#define UPDATE_ABOUT_PROFILE    @"Update profile"
#define UPDATE_COMNPANY_PROFILE @"Update company profile"


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
@property (strong, nonatomic) COListProfileObject   *profileObject;
@property (weak, nonatomic  ) TableBottomViewCell   *tableBottomViewCell;
@property (strong, nonatomic) TableHeaderView       *tableheaderView;
@property (weak, nonatomic  ) PasswordTableViewCell *passwordTableViewCell;
@property (strong, nonatomic) NSArray               *arrayCountryCode;

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
    vc.dicProfile = [self.profileObject getProfileObject];
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

#pragma mark - Setter Getter

- (NSMutableDictionary*)_setupAccessToken {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = [kUserDefaults valueForKey:kACCESS_TOKEN];
    dic[kTOKEN_TYPE] = [kUserDefaults valueForKey:kTOKEN_TYPE];
    return dic;
}

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

- (COListProfileObject*)profileObject {
    if (!_profileObject) {
        return _profileObject = [[COListProfileObject alloc]initWithDictionary:[kUserDefaults objectForKey:kPROFILE_OBJECT]];
    }
    return _profileObject;
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
    self.profileObject = nil;
    [self profileObject];
}

#pragma mark - Web Service
- (void)_callWSGetListProfile {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsGetProfileWithUserToken:[self _setupAccessToken] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            self.profileObject = nil;
            self.profileObject = (COListProfileObject*)responseObject;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView reloadData];
            }];
        }else {
            [UIHelper showError:error];
        }
    }];
    [UIHelper hideLoadingFromView:self.view];
}


- (void)_callWSChangePassword:(NSDictionary*)param {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsChangePassword:[self _setupAccessToken] body:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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
        aboutCell.lblDetail.text = self.profileObject.first_name;
        aboutCell.lblname.text = NSLocalizedString(@"FIRST_NAME", nil);
    } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
        aboutCell.lblDetail.text = self.profileObject.last_name;
        aboutCell.lblname.text = NSLocalizedString(@"LAST_NAME", nil);
    } else if (indexPath.row == COAboutProfileStyleEmail) {
        aboutCell.lblDetail.text = self.profileObject.email;
        aboutCell.lblname.text = NSLocalizedString(@"EMAIl", nil);
    } else {
        NSString *phoneCode = self.profileObject.country_prefix;
        NSString *string = [NSString stringWithFormat:@"%@ %@",phoneCode,self.profileObject.cell_phone];
        aboutCell.lblDetail.text = string;
        aboutCell.lblname.text = NSLocalizedString(@"PHONE", nil);
    }
    return aboutCell;
}

- (AboutTableViewCellAddress*)_setupAboutCell_Address:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCellAddress *cell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCellAddress identifier]];
    cell.profileObject = self.profileObject;
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
        return 6;
    } else {
        return 2;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        if (indexPath.row == 4) {
            return [self _setupAboutCell_Address:tableView cellForRowAtIndexPath:indexPath];
        } else if (indexPath.row == 5) {
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

- (void)editAboutProfile:(EditAboutProfileVC *)editAboutProfileVC profileUpdate:(NSDictionary *)profileUpdate {
    [self.profileObject setProfileObject:profileUpdate];
    editAboutProfileVC.profileObject = self.profileObject;
}

- (void)tableHeaderView:(TableHeaderView *)tableHeaderView indexSelectSegment:(NSInteger)indexSelect {
    [self _setupCellStyle:indexSelect];
}

- (void)tableBottomView:(TableBottomViewCell *)tableBottomView titlerButton:(NSString *)titlerButton {
    [self __actionButtonUpdate:titlerButton];
}

@end
