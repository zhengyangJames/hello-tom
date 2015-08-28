//
//  EditAboutProfileVC.m
//  CoAssest
//
//  Created by TUONG DANG on 6/16/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "EditAboutProfileVC.h"
#import "CODropListView.h"
#import "COBorderTextField.h"
#import "CoDropListButtom.h"
#import "LoadFileManager.h"
#import "WSURLSessionManager+Profile.h"
#import "COUserProfileDetailModel.h"
#import "COLoginManager.h"
#import "COUserProfileModel.h"

@interface EditAboutProfileVC () <UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *emailNameTXT;
    __weak IBOutlet CoDropListButtom  *dropListCountryCode;
    __weak IBOutlet COBorderTextField *phoneNameTXT;
    __weak IBOutlet COBorderTextField *addressNameTXT;
    __weak IBOutlet COBorderTextField *address2TXT;
    __weak IBOutlet COBorderTextField *cityTXT;
    __weak IBOutlet COBorderTextField *postCodeTXT;
    __weak IBOutlet COBorderTextField *regionStateTXT;
    __weak IBOutlet COBorderTextField *countryTXT;

    __weak COBorderTextField *_currentField;
    NSInteger _indexActtionCountryCode;
}
@property (strong, nonatomic) id<COUserAboutProfile> userProfileModel;
@property (strong,nonatomic) NSArray *arrayCountryCode;

@end

@implementation EditAboutProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [self _setupData];
}

- (void)_setupData {
    self.userProfileModel   = self.aboutUserModel;
    if (_userProfileModel) {
        addressNameTXT.text = _userProfileModel.nameOfUserAddress1;
        countryTXT.text     = _userProfileModel.nameOfUserCountry;
        address2TXT.text    = _userProfileModel.nameOfUserAddress2;
        phoneNameTXT.text   = _userProfileModel.numberOfUserPhone;
        emailNameTXT.text   = _userProfileModel.nameOfUserEmail;
        cityTXT.text        = _userProfileModel.nameOfUserCity;
        regionStateTXT.text = _userProfileModel.nameOfUserRegion;
        NSString *phone     = [self _getPhoneCode:_userProfileModel.nameOfUserCountryCode];
        _indexActtionCountryCode = [self _getPhoneCodeForString:phone];
        [dropListCountryCode setTitle:phone forState:UIControlStateNormal];
    }
}
#pragma mark - Set Get

- (void)setUserProfileModel:(id<COUserAboutProfile>)userProfileModel {
    _userProfileModel = userProfileModel;
}

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

- (NSDictionary*)_getProfileObject {
    NSString *phone = [self.arrayCountryCode[_indexActtionCountryCode] valueForKey:@"code"];
    NSMutableDictionary *obj = [[NSMutableDictionary alloc]init];
    [obj setValue:self.userProfileModel.nameOfUserName forKey:kUSER];
    [obj setValue:self.userProfileModel.nameOfUserFirstName forKey:KFRIST_NAME];
    [obj setValue:self.userProfileModel.nameOfUserLastName forKey:KLAST_NAME];
    [obj setValue:emailNameTXT.text forKey:KEMAIL];
    NSMutableDictionary *pro = [[NSMutableDictionary alloc] init];
    [pro setValue:phone forKey:kNUM_COUNTRY];
    [pro setValue:phoneNameTXT.text forKey:kNUM_CELL_PHONE];
    [pro setValue:addressNameTXT.text  forKey:KADDRESS];
    [pro setValue:cityTXT.text forKey:KCITY];
    [pro setValue:countryTXT.text forKey:KCOUNTRY];
    [pro setValue:address2TXT.text forKey:KADDRESS2];
    [pro setValue:regionStateTXT.text forKey:KSATE];
    [obj setValue:pro forKey:kPROFILE];
    return obj;
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

- (NSInteger)_getPhoneCodeForString:(NSString*)stringPhoneCode {
    NSInteger num = 0;
    for (int i = 0 ; i < self.arrayCountryCode.count; i++) {
        if ([stringPhoneCode isEqualToString:[self.arrayCountryCode[i] objectForKey:@"code"]]) {
            num = i ;
        }
    }
    return num;
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

- (BOOL)_isValidation {
    if ([emailNameTXT.text isEmpty]) {
        _currentField = emailNameTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if (![emailNameTXT.text isValidEmail]) {
        _currentField = emailNameTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"EMAIL_INVALID", nil) delegate:self tag:0];
        return NO;
    } else if ([phoneNameTXT.text isEmpty]) {
        _currentField = phoneNameTXT;
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"PHONE_REQUIRED", nil) delegate:self tag:0];
        return NO;
    } else if ([self _checkStringIsNumberOrCharacter:countryTXT.text]) {
        [UIHelper showAlertViewErrorWithMessage:NSLocalizedString(@"ERROR_COUNTRY", nil) delegate:self tag:0];
        return NO;
    }
    return YES;
}

- (BOOL)_checkStringIsNumberOrCharacter:(NSString*)string {
    if (string) {
        BOOL check = false;
        for (int i=0 ; i <string.length; i++) {
            NSString *s = [string substringWithRange:NSMakeRange(i, 1)];
            check = [string length] && isnumber([s characterAtIndex:0]);
            if (check) {
                break;
            }
        }
        return check;
    } else return YES;
}

#pragma mark - Web Service
- (void)_callWSUpdateProfile {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsUpdateProfileWithBody:[self _getProfileObject] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                if ([self.delegate respondsToSelector:@selector(editAboutProfile:)]) {
                    [self.delegate editAboutProfile:self];
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}
#pragma mark - Action

- (void)__actionDone:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    if ([self _isValidation]) {
        [self _callWSUpdateProfile];
    }
}

- (void)__actionDCancel:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)__actionCountryCode:(id)sender {
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:NSLocalizedString(@"PHONE_CODE_TITLE", nil) data:self.arrayCountryCode selectedIndex:_indexActtionCountryCode
                           didSelect:^(NSInteger index) {
        [dropListCountryCode setTitle:[self.arrayCountryCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionCountryCode = index;
    }];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_currentField becomeFirstResponder];
   _currentField = nil;
}
@synthesize aboutUserModel = _aboutUserModel;
@end
