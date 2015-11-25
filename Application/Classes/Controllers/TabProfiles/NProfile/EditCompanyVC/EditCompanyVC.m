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
#import "LoginViewController.h"
#import "WSURLSessionManager+CompanyProfile.h"
#import "LoadFileManager.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EditCompanyVC () <UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet CoDropListButtom *_btnOrgType;
    __weak IBOutlet COBorderTextField *orgNameTextField;
    __weak IBOutlet COBorderTextField *addressTextField;
    __weak IBOutlet COBorderTextField *address2TextField;
    __weak IBOutlet COBorderTextField *orgCityTextField;
    __weak IBOutlet COBorderTextField *countryTextField;
    __weak IBOutlet UIImageView *_imageCompany;
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet NSLayoutConstraint *_heightTopView;
    NSInteger _indexActtionOrgType;
    NSString *_orgType;
    NSString *_urlImageProfile;
    CGFloat _heightImage;
    
    BOOL _isChooseImage;
}

@property (nonatomic, strong) NSMutableArray *arrayOrgType;
@property (nonatomic, strong) NSArray *arrayType;

@end

@implementation EditCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.companyUserModel = self.companyUserModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

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
    [_btnOrgType setTitle:[self.arrayOrgType objectAtIndex:[self _getOrgType:_companyUserModel.orgType]] forState:UIControlStateNormal];
    NSString *path = _companyUserModel.imageUrl;
    if (path) {
        [_imageCompany sd_setImageWithURL:[NSURL URLWithString:path]];
        _heightTopView.constant = [_companyUserModel.heightForImage floatValue] - 20;
    }
}

- (NSArray*)arrayType {
    if (!_arrayType) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CompanyOrgType" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        return array;
    }
    return _arrayType;
}

- (NSMutableArray*)arrayOrgType {
    if (_arrayOrgType != nil) {
        return _arrayOrgType;
    }
    _arrayOrgType = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in self.arrayType) {
        [_arrayOrgType addObject:[dic objectForKey:@"value"]];
    }
    return _arrayOrgType;
}

#pragma mark - Private

- (NSInteger)_getOrgType:(NSString *)type {
    for (NSInteger i = 0; i < self.arrayType.count; i++) {
        NSDictionary *dict = [self.arrayType objectAtIndex:i];
        NSString *type_ = [dict objectForKeyNotNull:@"key"];
        if ([type_ isEqualToString:type]) {
            return i;
        }
    }
    return 0;
}

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

#pragma mark - Check
- (BOOL)_checkORGName {
    if ([[orgNameTextField.text trim] isEmpty]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"ORG_NAME_REQUIRED", nil) delegate:nil tag:0];
        return NO;
    }
    return YES;
}



#pragma mark - Action

- (void)__actionDone:(id)sender {
    [self.view endEditing:YES];
    if ([self _checkORGName]) {
        [self _postCampanyProfile:[self _creatUpdateInfoCompany]];
    }
}

- (void)__actionDCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)__actionPickImage:(id)sender {
    [self.view endEditing:YES];
    [self _showActionSheet];
}

- (IBAction)__actionOrgType:(id)sender {
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Org Type" data:self.arrayOrgType selectedIndex:_indexActtionOrgType didSelect:^(NSInteger index) {
        NSString *type = self.arrayOrgType[index];
        [_btnOrgType setTitle:type forState:UIControlStateNormal];
        _indexActtionOrgType = index;
        _orgType = type;
    }];
}

- (void)_showActionSheet {
    [UIHelper showActionsheetWithTitle:nil cancelButtonTitle:m_string(@"CANCEL_TITLE") destructiveButtonTitle:nil otherButtonsTitle:@[m_string(@"TAKE_PHOTO_TITLE"), m_string(@"CHOOSE_EXISTING_TITLE")] delegate:self tag:100 showInView:self.view];
}

#pragma mark - WS update info

- (NSDictionary *)_creatUpdateInfoCompany {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[self _setModelNilOrNotNil:orgCityTextField.text] forKey:kUpCPProfileCity];
    [dic setValue:[self _setModelNilOrNotNil:addressTextField.text] forKey:kUpCPProfileAddress1];
    [dic setValue:[self _setModelNilOrNotNil:address2TextField.text] forKey:kUpCPProfileAddress2];
    [dic setValue:[self _setModelNilOrNotNil:orgNameTextField.text] forKey:kUpCPProfileOrgName];
    [dic setValue:[self _setModelNilOrNotNil:countryTextField.text] forKey:kUpCPProfileCountry];
    [dic setValue:[self _setModelNilOrNotNil:_urlImageProfile] forKey:kUpCPProfileImage];
    [dic setValue:[self _setModelNilOrNotNil:[[self.arrayType objectAtIndex:_indexActtionOrgType] objectForKey:@"key"]] forKey:kUpCPProfileOrgType];
    NSString *height = [NSString stringWithFormat:@"%f",_heightImage];
    [dic setValue:[self _setModelNilOrNotNil:height] forKey:kUpCPProfileImageHeight];
    return dic;
}

- (id)_setModelNilOrNotNil:(NSString*)string {
    if ([string isEmpty]) {
        return nil;
    } else {
        return string;
    }
}

- (void)_updateProfileUserModel:(NSDictionary*)obj {
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    [kUserDefaults setObject:data forKey:UPDATE_COMPANY_PROFILE_JSON];
    [kUserDefaults synchronize];
}

#pragma mark - Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 100) {
        if (actionSheet.cancelButtonIndex != buttonIndex) {
            [UIHelper showImagePickerAtController:self withDelegate:self andMode:buttonIndex];
        }
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self _updateHeightViewTop:image];
    if (image) {
        _isChooseImage = YES;
        [_imageCompany setImage:image];
    } else {
        DBG(@"/********-No-Image-Choice-*********/");
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_updateHeightViewTop:(UIImage *)image {
    CGSize sizeImage = image.size;
    CGFloat defaultHeight = ([UIScreen mainScreen].bounds.size.width);
    CGFloat ratioImage = sizeImage.height/sizeImage.width;
    _heightImage = ratioImage*defaultHeight;
    _heightTopView.constant = _heightImage - 20;
    //[_contentView setNeedsUpdateConstraints];
}

- (void)_postCampanyProfile:(NSDictionary *)dic {
    [UIHelper showLoadingInView:self.view];
    UIImageView *logo = _isChooseImage == YES?_imageCompany:nil;
    [[WSURLSessionManager shared] wsPostDeviceCompanyProfileTokenRequest:dic imageView:logo Handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [self _updateProfileUserModel:dic];
            UIImage *image = logo == nil?nil:logo.image;
            if (self.actionDone) {
                self.actionDone(_heightImage, image);
            }
            [self dismissViewControllerAnimated:YES completion:^{}];
        } else {
            [UIHelper showLoadingInView:self.view];
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

@end
