//
//  EditCompanyVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditCompanyVC.h"
#import "CODropListView.h"
#import "CoDropListButtom.h"
#import "COBorderTextField.h"
#import "COUserCompanyModel.h"
#import "WSUpdateCompanyProfile.h"

@interface EditCompanyVC () <UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet CoDropListButtom *_btnOrgType;
    __weak IBOutlet COBorderTextField *orgNameTextField;
    __weak IBOutlet COBorderTextField *addressTextField;
    __weak IBOutlet COBorderTextField *address2TextField;
    __weak IBOutlet COBorderTextField *orgCityTextField;
    __weak IBOutlet COBorderTextField *countryTextField;
    __weak IBOutlet UIImageView *_imageCompany;
    NSInteger _indexActtionOrgType;
    NSString *_orgType;
    NSString *_urlImageProfile;
}
@end

@implementation EditCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    self.companyUserModel = self.companyUserModel;
}


#pragma mark - Set Get
- (void)setCompanyUserModel:(COUserCompanyModel *)companyUserModel {
    _companyUserModel = companyUserModel;
    NSString *name = _companyUserModel.companyNameContent;
    if ([name isEqualToString:m_string(@"NoCompanyAssociated")]) {
        [orgNameTextField setText:@""];
    } else {
        [orgNameTextField setText:_companyUserModel.companyNameContent];
    }
    
    [addressTextField setText:_companyUserModel.companyAdressContent1];
    [address2TextField setText:_companyUserModel.companyAdressContent2];
    [orgCityTextField setText:_companyUserModel.companyCity];
    [countryTextField setText:_companyUserModel.companyCountry];
    
}

#pragma mark - Private

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"C_PROFILE");
    [self _setupBarButtonCancel];
    [self _setupBarButtonDone];
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"DONE_TITLE", nil)
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"CANCEL_TITLE", nil)
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btCancel;
}



#pragma mark - Action

- (void)__actionDone:(id)sender {
    [self _updateProfileUserModel:[self _creatUpdateInfoCompany]];
    if (self.actionDone) {
        self.actionDone();
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (NSDictionary *)_creatUpdateInfoCompany {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[self _setModelNilOrNotNil:orgCityTextField.text] forKey:kUpCPProfileCity];
    [dic setValue:[self _setModelNilOrNotNil:addressTextField.text] forKey:kUpCPProfileAddress1];
    [dic setValue:[self _setModelNilOrNotNil:address2TextField.text] forKey:kUpCPProfileAddress2];
    [dic setValue:[self _setModelNilOrNotNil:orgNameTextField.text] forKey:kUpCPProfileOrgName];
    [dic setValue:[self _setModelNilOrNotNil:countryTextField.text] forKey:kUpCPProfileCountry];
    [dic setValue:[self _setModelNilOrNotNil:_urlImageProfile] forKey:kUpCPProfileImage];
    return dic;
}

- (id)_setModelNilOrNotNil:(NSString*)string {
    if ([string isEmpty]) {
        return nil;
    } else {
        return string;
    }
}

- (void)__actionDCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)__actionPickImage:(id)sender {
    [self _showActionSheet];
}

- (IBAction)__actionOrgType:(id)sender {
    NSArray *array = @[@"Developer",@"Agency",@"Reseller",@"Funds",@"Others ",@"Route Sale"];
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Org Type" data:array selectedIndex:_indexActtionOrgType didSelect:^(NSInteger index) {
        [_btnOrgType setTitle:array[index] forState:UIControlStateNormal];
        _indexActtionOrgType = index;
        _orgType = array[index];
    }];
}

- (void)_showActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"CANCEL_TITLE", nil)
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:NSLocalizedString(@"TAKE_PHOTO_TITLE", nil),NSLocalizedString(@"CHOOSE_EXISTING_TITLE", nil), nil];
    [actionSheet showInView:self.view];
}

#pragma mark - WS update info

- (void)_updateProfileUserModel:(NSDictionary*)obj {
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    [kUserDefaults setObject:data forKey:UPDATE_COMPANY_PROFILE_JSON];
    [kUserDefaults synchronize];
    
//    COUserCompanyModel *userModel = [[COUserCompanyModel alloc] init];
//    [userModel setCompanyImageURL:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileImage]]];
//    [userModel setCompanyNameContent:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileOrgName]]];
//    [userModel setCompanyOrgtype:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileOrgType]]];
//    [userModel setCompanyAdressContent1:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileAddress1]]];
//    [userModel setCompanyAdressContent2:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileAddress2]]];
//    [userModel setCompanyCity:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileCity]]];
//    [userModel setCompanyCountry:[self _setModelNullOrNotNull:[obj valueForKeyNotNull:kUpCPProfileCountry]]];
//    return userModel;
}

#pragma mark - Delegate
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
    [_imageCompany setImage:image];
    if (image) {
        _urlImageProfile = [[NSURL URLWithString:@"http://www.tapchidanong.org/product_images/h/616/chau-tu-na-3289%284%29__92564_zoom.jpg"] absoluteString];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
