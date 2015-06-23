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
#import "EditAboutProfileVC.h"
#import "EditCompanyVC.h"
#import "LoadFileManager.h"
#import "ProfileObject.h"
#import "CODummyDataManager.h"
#import "ProfileObject.h"
#import "NSString+Validation.h"

#define DEFAULT_HEIGHT_CELL             44
#define AUTO_HEIGHT_CELL_ABOUT          (self.view.bounds.size.height - (200+90))/6
#define AUTO_HEIGHT_CELL_COMPANY        (self.view.bounds.size.height - (200+90+44))
#define DEFAULT_HEIGHT_CELL_COMPANY     205
#define AUTO_HEIGHT_CELL_PASSWORD       (self.view.bounds.size.height - (200+90))
#define DEFAULT_HEIGHT_CELL_PASSWORD    231

#define UPDATE_ABOUT_PROFILE    @"Update profile"
#define UPDATE_COMNPANY_PROFILE @"Update company profile"

typedef void(^ActionUpdateTextFieldPassword)(PasswordTableViewCell* passwordCell);

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate,PasswordTableViewCellDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    UIImage *_imageCompany;
    NSString *_oldPassword;
    NSString *_newPassword;
    NSString *_comfilmPassword;
    NSInteger _indexSelectSeg;
    NSInteger _indexActtionCountryCode;
}
@property (strong, nonatomic) ProfileObject *profileObject;
@property (strong, nonatomic) TableBottomView *tablefooterView;
@property (strong, nonatomic) TableHeaderView *tableheaderView;
@property (weak, nonatomic) PasswordTableViewCell *passwordTableViewCell;
@property (strong,nonatomic) NSArray *arrayCountryCode;
@property (copy, nonatomic) ActionUpdateTextFieldPassword actionUpdateTextFieldPassword;

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
    [_tableView reloadData];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssests");
    [self _setupHeaderTableView];
    [self _setupFooterTableView];
    _indexActtionCountryCode = 0;
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
        case COSegmentStyleAbout: self.tablefooterView.lblUpdateButton    = m_string(@"Update profile"); break;
        case COSegmentStyleCompany: self.tablefooterView.lblUpdateButton  = m_string(@"Update company profile"); break;
        case COSegmentStylePasswork: self.tablefooterView.lblUpdateButton = m_string(@"Update password"); break;
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
    [_tableheaderView setActionPickerImageProfile:^(){
        __typeof__(self) strongSelf = weakSelf;
        [strongSelf _showActionSheet];
    }];
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

- (void)_setupEditAboutProfileVC {
    EditAboutProfileVC *vc = [[EditAboutProfileVC alloc]init];
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    vc.phoneCode = _indexActtionCountryCode;
    vc.phoneName = self.profileObject.phone;
    vc.addressName = self.profileObject.address;
    vc.emailName = self.profileObject.email;
    vc.actionDone = ^(NSString* emailName,NSString* phone,NSInteger phoneCode,NSString* address) {
        self.profileObject.phone = phone;
        self.profileObject.address = address;
        self.profileObject.email = emailName;
        _indexActtionCountryCode = phoneCode;
    };
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

- (void)_setupEditCompanyVC {
    EditCompanyVC *vc = [[EditCompanyVC alloc]init];
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    vc.orgName = self.profileObject.orgname;
    vc.address = self.profileObject.address;
    vc.imageName = _imageCompany?_imageCompany:[UIImage imageNamed:@"ic_placeholder"];
    vc.actionDone = ^(NSString *orgName,NSString* address,UIImage *imageCompany){
        self.profileObject.orgname = orgName;
        self.profileObject.address = address;
        _imageCompany = imageCompany;
    };
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
}

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:nil
                                  tag:0
                     arrayTitleButton:nil];
}

- (BOOL)_isValidationPassword {
    if ([_comfilmPassword isEqualToString:_newPassword]) {
        return YES;
    }
    return NO;
}

#pragma mark - Setter Getter

- (ProfileObject*)profileObject {
    if (!_profileObject) {
        _profileObject = [[CODummyDataManager shared] AboutProfileObj];
    }
    return _profileObject;
}

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

#pragma mark - Action
- (void)__actionButtonUpdate:(NSString*)string {
    if ([string isEqualToString:UPDATE_ABOUT_PROFILE]) {
        [self _setupEditAboutProfileVC];
    } else if([string isEqualToString:UPDATE_COMNPANY_PROFILE]){
        [self _setupEditCompanyVC];
    } else {
        if ([self _isValidationPassword]) {
            _passwordTableViewCell.oldPassowrdTXT.text = nil;
            _passwordTableViewCell.newpassowrdTXT.text = nil;
            _passwordTableViewCell.comfilmPassowrdTXT.text = nil;
            [self _setupShowAleartViewWithTitle:@"Update Password Success"];
        } else {
            [self _setupShowAleartViewWithTitle:@"Password is ivalidation"];
        }
    }
}

- (void)_showActionSheet {
    [UIHelper showActionsheetWithTitle:nil
                     cancelButtonTitle:m_string(@"Cancel")
                destructiveButtonTitle:nil
                     otherButtonsTitle:@[m_string(@"Take a photo"),m_string(@"Choose existing")]
                              delegate:self
                                   tag:0
                            showInView:self.view];
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
        if (!_passwordTableViewCell) {
            _passwordTableViewCell = [self _setupPasswordCell:tableView cellForRowAtIndexPath:indexPath];
        }
        return _passwordTableViewCell;
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
    if (indexPath.row == COAboutProfileStyleSalutation) {
        aboutCell.lblDetail.text = self.profileObject.salutation;
        aboutCell.lblname.text = m_string(@"Salutation");
    } else if (indexPath.row == COAboutProfileStyleFirstName) {
        aboutCell.lblDetail.text = self.profileObject.firstname;
        aboutCell.lblname.text = m_string(@"First Name");
    } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
        aboutCell.lblDetail.text = self.profileObject.lastnameurname;
        aboutCell.lblname.text = m_string(@"Last Name");
    } else if (indexPath.row == COAboutProfileStyleEmail) {
        aboutCell.lblDetail.text = self.profileObject.email;
        aboutCell.lblname.text = m_string(@"Email");
    } else if (indexPath.row == COAboutProfileStylePhone) {
        NSString *phoneCode = [self.arrayCountryCode[_indexActtionCountryCode] objectForKey:@"code"];
        NSString *string = [NSString stringWithFormat:@"%@ %@",phoneCode,self.profileObject.phone];
        aboutCell.lblDetail.text = string;
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
    companyCell.image.image = _imageCompany?_imageCompany:[UIImage imageNamed:@"ic_placeholder"];
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return companyCell;
}

- (AboutTableViewCell*)_setupCompanyCell2:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCell *companyCell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell identifier]
                                                                        forIndexPath:indexPath];
    companyCell.lblDetail.text = self.profileObject.address;
    companyCell.lblname.text = m_string(@"Address");
    companyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return companyCell;
}

- (PasswordTableViewCell*)_setupPasswordCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _passwordTableViewCell = [tableView dequeueReusableCellWithIdentifier:[PasswordTableViewCell identifier]
                                                                        forIndexPath:indexPath];
    _passwordTableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _passwordTableViewCell.delegate = self;
    return _passwordTableViewCell;
}

#pragma mark - Delegate 
- (void)passwordTableViewCellTextFieldAction:(PasswordTableViewCell *)passwordTableViewCell oldPassowrd:(NSString *)oldPassowrd newPassowrd:(NSString *)newPassowrd comfilmPassowrd:(NSString *)comfilmPassowrd {
    if (![passwordTableViewCell.oldPassowrdTXT.text isEmpty]) {
        _oldPassword = oldPassowrd;
    }
    if (![passwordTableViewCell.newpassowrdTXT.text isEmpty]) {
        _newPassword = newPassowrd;
    }
    if (![passwordTableViewCell.comfilmPassowrdTXT.text isEmpty]) {
        _comfilmPassword = comfilmPassowrd;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: 
            [UIHelper showImagePickerAtController:self withDelegate:self andMode:0];
            break;
        case 1:
            [UIHelper showImagePickerAtController:self withDelegate:self andMode:1];
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [_tableheaderView.imageProfile setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
