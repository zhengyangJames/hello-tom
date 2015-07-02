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
#import "PasswordTableViewCell.h"
#import "EditAboutProfileVC.h"
#import "EditCompanyVC.h"
#import "LoadFileManager.h"
#import "COListProfileObject.h"
#import "CODummyDataManager.h"
#import "COListProfileObject.h"
#import "NSString+Validation.h"
#import "WSURLSessionManager+Profile.h"
#import "LoginViewController.h"
#import "WSURLSessionManager+User.h"
#import "NSUserDefaultHelper.h"

#define DEFAULT_HEIGHT_CELL             44
#define AUTO_HEIGHT_CELL_ABOUT          (self.view.bounds.size.height - (200+90))/6
#define AUTO_HEIGHT_CELL_COMPANY        (self.view.bounds.size.height - (200+90+44))
#define DEFAULT_HEIGHT_CELL_COMPANY     205
#define AUTO_HEIGHT_CELL_PASSWORD       (self.view.bounds.size.height - (200+90))
#define DEFAULT_HEIGHT_CELL_PASSWORD    171

#define UPDATE_ABOUT_PROFILE    @"Update profile"
#define UPDATE_COMNPANY_PROFILE @"Update company profile"

typedef void(^ActionUpdateTextFieldPassword)(PasswordTableViewCell* passwordCell);

@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate,PasswordTableViewCellDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
    UIImage *_imageCompany;
    NSString *_oldPassword;
    NSString *_newPassword;
    NSString *_comfilmPassword;
    NSInteger _indexSelectSeg;
    NSDictionary *oldTokenObj;
}
@property (strong, nonatomic) COListProfileObject           *profileObject;
@property (strong, nonatomic) TableBottomView               *tablefooterView;
@property (strong, nonatomic) TableHeaderView               *tableheaderView;
@property (weak, nonatomic  ) PasswordTableViewCell         *passwordTableViewCell;
@property (strong,nonatomic ) NSArray                       *arrayCountryCode;
@property (copy, nonatomic  ) ActionUpdateTextFieldPassword actionUpdateTextFieldPassword;

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
    [self _checkInLogin];
}

#pragma mark - Setup
- (void)_setupUI {
    self.navigationItem.title = m_string(@"CoAssests");
    [self _setupHeaderTableView];
    [self _setupFooterTableView];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:[AboutTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[AboutTableViewCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[PasswordTableViewCell identifier] bundle:nil] forCellReuseIdentifier:[PasswordTableViewCell identifier]];
}

- (void)_setupCellStyle:(NSInteger)index {
    _indexSelectSeg = index;
    [_tableView reloadData];
    switch (_indexSelectSeg) {
        case COSegmentStyleAbout: self.tablefooterView.lblUpdateButton    = m_string(@"Update profile"); break;
        case COSegmentStylePasswork: self.tablefooterView.lblUpdateButton = m_string(@"Update password"); break;
    }
}

- (NSMutableDictionary*)_setupAccessToken {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = [kUserDefaults valueForKey:kACCESS_TOKEN];
    dic[kTOKEN_TYPE] = [kUserDefaults valueForKey:kTOKEN_TYPE];
    return dic;
}

- (void)_checkInLogin {
    if (![kUserDefaults boolForKey:KDEFAULT_LOGIN]) {
        [self _setUpLogginVC];
    } else {
        if (!self.profileObject) {
            [self _callWSGetListProfile];
        }
    }
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
        [UIHelper hideLoadingFromView:self.view];
    }];
}


- (void)_callWSChangePassword:(NSDictionary*)param {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsChangePassword:[self _setupAccessToken] body:param handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && [responseObject isKindOfClass:[NSDictionary class]] && [responseObject valueForKey:@"success"]) {
            DBG(@"%@",responseObject);
            [self _setupShowAleartViewWithTitle:@"Password changed successfully"];
        } else {
            [self _setupShowAleartViewWithTitle:@"Password not changed"];
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.view endEditing:YES];
        }];
        [UIHelper hideLoadingFromView:self.view];
    }];
}


#pragma mark - Private
- (void)_setUpLogginVC {
    LoginViewController *vcLogin = [[LoginViewController alloc]init];
    __weak LoginViewController *weakLogin = vcLogin;
    CATransition* transition = [CATransition animation];
    transition.duration = 1.5;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    BaseNavigationController *base = [[BaseNavigationController alloc] initWithRootViewController:vcLogin];
    [base.view.layer addAnimation:transition forKey:kCATransition];
    [[kAppDelegate baseTabBarController].view.layer addAnimation:transition forKey:kCATransition];
    [[kAppDelegate baseTabBarController] presentViewController:base
                                                      animated:NO completion:nil];
    vcLogin.actionLogin = ^(id profileObj){
        [[kAppDelegate baseTabBarController] dismissViewControllerAnimated:weakLogin completion:^{
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView reloadData];
            }];
        }];
    };
}

- (void)_setupHeaderTableView {
    __weak __typeof__(self) weakSelf = self;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 200)];
    _tableheaderView   = [[TableHeaderView alloc] initWithNibName:[TableHeaderView identifier]];
    [_tableheaderView setActionSegment:^(NSInteger indexSelectSegment){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf _setupCellStyle:indexSelectSegment];
    } ];
//    [_tableheaderView setActionPickerImageProfile:^(){
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        [strongSelf _showActionSheet];
//    }];
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
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf __actionButtonUpdate:string];
    }];
    _tablefooterView.translatesAutoresizingMaskIntoConstraints = NO;
    [footerView addSubview:_tablefooterView];
    [_tablefooterView pinToSuperviewEdges:JRTViewPinAllEdges inset:0];
    _tableView.tableFooterView = footerView;
}

- (void)_setupEditAboutProfileVC {
    EditAboutProfileVC *vc = [[EditAboutProfileVC alloc]init];
    __weak __typeof__(EditAboutProfileVC) *weakSelf = vc;
    BaseNavigationController *baseNAV = [[BaseNavigationController alloc]initWithRootViewController:vc];
    vc.phoneCode = self.profileObject.country_prefix;
    vc.phoneName = self.profileObject.cell_phone;
    vc.addressName = self.profileObject.address_1;
    vc.emailName = self.profileObject.email;
    vc.city = self.profileObject.city;
    vc.country = self.profileObject.country;
    vc.addressName2 = self.profileObject.address_2;
    vc.state = self.profileObject.region_state;
    vc.actionDone = ^(NSString* emailName,NSString* phone,NSString *phoneCode,NSString* address,NSString* addressName2,NSString* city,NSString* country,NSString* state) {
        self.profileObject.country_prefix = [self _getPhoneCode:phoneCode];
        self.profileObject.cell_phone = phone;
        self.profileObject.address_1 = address;
        self.profileObject.email = emailName;
        self.profileObject.city = city;
        self.profileObject.country = country;
        self.profileObject.address_2 = addressName2;
        self.profileObject.region_state = state;
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.profileObject = self.profileObject;
    };
    [self.navigationController presentViewController:baseNAV animated:YES completion:nil];
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

- (void)_setupShowAleartViewWithTitle:(NSString*)message {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIHelper showAleartViewWithTitle:m_string(@"CoAssests")
                                  message:m_string(message)
                             cancelButton:m_string(@"OK")
                                 delegate:self
                                      tag:0
                         arrayTitleButton:nil];
    }];
}

- (BOOL)_isValidationPassword {
    if ([_comfilmPassword isEqualToString:_newPassword]) {
        return YES;
    }
    return NO;
}

#pragma mark - Setter Getter

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

- (COListProfileObject*)profileObject {
    if (!_profileObject) {
        return _profileObject = [self _unzipDataProfile];
    }
    return _profileObject;
}

- (COListProfileObject*)_unzipDataProfile {
    COListProfileObject *obj = [[COListProfileObject alloc]initWithDictionary:[kUserDefaults objectForKey:kPROFILE_OBJECT]];
    return obj;
}


#pragma mark - Action
- (void)__actionButtonUpdate:(NSString*)string {
    if ([string isEqualToString:UPDATE_ABOUT_PROFILE]) {
        [self _setupEditAboutProfileVC];
    } else {
        [kNotificationCenter postNotificationName:@"check_password" object:nil];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_passwordTableViewCell.newpassowrdTXT.text,@"new_password", nil];
        [self _callWSChangePassword:dic];
    }
}

- (void)_showActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:m_string(@"Cancel")
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:m_string(@"Take a photo"),m_string(@"Choose existing"), nil];
    [actionSheet showInView:self.view];
}

- (void)__actionUpdateProfile {
    self.profileObject = nil;
    [self profileObject];
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return 6;
    } else {
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return [self _setupAboutCell:tableView cellForRowAtIndexPath:indexPath];
    } else {
        if (!_passwordTableViewCell) {
            _passwordTableViewCell = [self _setupPasswordCell:tableView cellForRowAtIndexPath:indexPath];
        }
        return _passwordTableViewCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (TableViewCellStyleAbout == _indexSelectSeg) {
        return AUTO_HEIGHT_CELL_ABOUT < DEFAULT_HEIGHT_CELL ? DEFAULT_HEIGHT_CELL : AUTO_HEIGHT_CELL_ABOUT;
    } else {
        return DEFAULT_HEIGHT_CELL_PASSWORD;
    }
}

/*
 Setup Cell Style
 */

- (AboutTableViewCell*)_setupAboutCell:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AboutTableViewCell *aboutCell = [tableView dequeueReusableCellWithIdentifier:[AboutTableViewCell identifier]
                                                                    forIndexPath:indexPath];
    if (indexPath.row == COAboutProfileStyleSalutation) {
        aboutCell.lblDetail.text = @""; //self.profileObject.salutation;
        aboutCell.lblname.text = m_string(@"Salutation");
    } else if (indexPath.row == COAboutProfileStyleFirstName) {
        aboutCell.lblDetail.text = self.profileObject.first_name;
        aboutCell.lblname.text = m_string(@"First Name");
    } else if (indexPath.row == COAboutProfileStyleLastNameSurname) {
        aboutCell.lblDetail.text = self.profileObject.last_name;
        aboutCell.lblname.text = m_string(@"Last Name");
    } else if (indexPath.row == COAboutProfileStyleEmail) {
        aboutCell.lblDetail.text = self.profileObject.email;
        aboutCell.lblname.text = m_string(@"Email");
    } else if (indexPath.row == COAboutProfileStylePhone) {
        NSString *phoneCode = self.profileObject.country_prefix;
        NSString *string = [NSString stringWithFormat:@"%@ %@",phoneCode,self.profileObject.cell_phone];
        aboutCell.lblDetail.text = string;
        aboutCell.lblname.text = m_string(@"Phone");
    } else {
        aboutCell.lblDetail.text = self.profileObject.address_1;
        aboutCell.lblname.text = m_string(@"Address");
    }
    aboutCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return aboutCell;
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    _passwordTableViewCell.newpassowrdTXT.text = @"";
    _passwordTableViewCell.comfilmPassowrdTXT.text = @"";
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    [_tableheaderView.imageProfile setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
