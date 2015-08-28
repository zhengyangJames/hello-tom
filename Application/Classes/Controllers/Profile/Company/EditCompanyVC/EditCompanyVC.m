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
#import "COListProfileObject.h"
#import "COBorderTextField.h"

@interface EditCompanyVC () <UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    __weak IBOutlet CoDropListButtom *_btnOrgType;
    __weak IBOutlet COBorderTextField *orgNameTextField;
    __weak IBOutlet COBorderTextField *addressTextField;
    __weak IBOutlet UIImageView *_imageCompany;
    NSInteger _indexActtionOrgType;
}
@property (strong, nonatomic) COListProfileObject *profileObject;

@end

@implementation EditCompanyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.orgName = self.orgName;
    self.address = self.address;
    self.imageName = self.imageName;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}


#pragma mark - Set Get
- (void)setOrgName:(NSString *)orgName {
    _orgName = orgName;
    orgNameTextField.text = _orgName;
}

- (void)setAddress:(NSString *)address {
    _address = address;
    addressTextField.text = _address;
}

- (void)setImageName:(UIImage *)imageName {
    _imageName = imageName;
    _imageCompany.image = _imageName;
}

- (COListProfileObject*)profileObject {
    if (!_profileObject) {
        _profileObject = [[COListProfileObject alloc] init];
    }
    return _profileObject;
}

#pragma mark - Private

- (void)_setupUI {
    
    self.navigationItem.title = NSLocalizedString(@"BASIC_INFO", nil);
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
    if (self.actionDone) {
        self.actionDone(orgNameTextField.text,addressTextField.text,_imageCompany.image);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)__actionDCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
