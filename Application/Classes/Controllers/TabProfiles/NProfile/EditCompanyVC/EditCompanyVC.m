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
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet NSLayoutConstraint *_heightTopView;
    NSInteger _indexActtionOrgType;
    NSString *_orgType;
    NSString *_urlImageProfile;
}

@property (nonatomic, strong) NSArray *arrayOrgType;

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
}

- (NSArray *)arrayOrgType {
    if (_arrayOrgType) {
        return _arrayOrgType;
    }
    _arrayOrgType = @[@"Developer",@"Agency",@"Reseller",@"Funds",@"Others ",@"Route Sale"];
    return _arrayOrgType;
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
        self.actionDone(_heightTopView.constant);
    }
    [self dismissViewControllerAnimated:YES completion:^{}];
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
        [_imageCompany setImage:image];
        _urlImageProfile = @"http://www.tapchidanong.org/product_images/h/616/chau-tu-na-3289%284%29__92564_zoom.jpg";
    } else {
        DBG(@"/********-No-Image-Choice-*********/");
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)_updateHeightViewTop:(UIImage *)image {
    CGFloat heightTopView;
    CGSize sizeImage = image.size;
    CGFloat defaultHeight = ([UIScreen mainScreen].bounds.size.width - 40);
    CGFloat ratioImage = sizeImage.height/sizeImage.width;
    heightTopView = ratioImage*defaultHeight;
    _heightTopView.constant = heightTopView;
    [_contentView setNeedsUpdateConstraints];
}

@end
