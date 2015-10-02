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
#import "WSUpdateProfileRequest.h"

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

- (WSUpdateProfileRequest *)_setUpdateProfileRequest {
    WSUpdateProfileRequest *request = [[WSUpdateProfileRequest alloc] init];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_LIST_PROFILE]];
    [request setHTTPMethod:METHOD_PUT];
    [request setValueWithModel:[[COLoginManager shared] userModel]];
    [request setBodyParam:self.userProfileModel.nameOfUserName forKey:kUpProfileUserName];
    [request setBodyParam:self.userProfileModel.nameOfUserFirstName forKey:kUpProfileFirstName];
    [request setBodyParam:self.userProfileModel.nameOfUserLastName forKey:kUpProfileLastName];
    [request setBodyParam:emailNameTXT.text forKey:kUpProfileEmail];
    NSString *phone = [self.arrayCountryCode[_indexActtionCountryCode] valueForKey:@"code"];
    [request setBodyParam:phone forKey:kUpProfileNumCountry];
    [request setBodyParam:phoneNameTXT.text forKey:kUpProfileCellPhone];
    [request setBodyParam:addressNameTXT.text forKey:kUpProfileAddress1];
    [request setBodyParam:address2TXT.text forKey:kUpProfileAddress2];
    [request setBodyParam:cityTXT.text forKey:kUpProfileCity];
    [request setBodyParam:countryTXT.text forKey:kUpProfileCountry];
    [request setBodyParam:regionStateTXT.text forKey:kUpProfileState];
    return request;
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
    [[WSURLSessionManager shared] wsUpdateProfileWithRequest:[self _setUpdateProfileRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
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
