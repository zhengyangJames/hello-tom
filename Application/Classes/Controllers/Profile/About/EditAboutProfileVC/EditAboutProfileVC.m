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


@interface EditAboutProfileVC () <UIAlertViewDelegate>
{
    __weak IBOutlet COBorderTextField *emailNameTXT;
    __weak IBOutlet COBorderTextField *phoneNameTXT;
    __weak IBOutlet COBorderTextField *addressNameTXT;
    __weak IBOutlet COBorderTextField *regionStateTXT;
    __weak IBOutlet COBorderTextField *address2TXT;
    __weak IBOutlet COBorderTextField *cityTXT;
    __weak IBOutlet COBorderTextField *countryTXT;
    __weak IBOutlet CoDropListButtom  *dropListCountryCode;
    __weak COBorderTextField *_currentField;
    NSInteger _indexActtionCountryCode;
}

@property (strong,nonatomic) NSArray *arrayCountryCode;

@end

@implementation EditAboutProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.dicProfile = self.dicProfile;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Set Get

- (void)setDicProfile:(NSDictionary *)dicProfile {
    _dicProfile = dicProfile;
    addressNameTXT.text = [_dicProfile valueForKey:KADDRESS];
    countryTXT.text = [_dicProfile valueForKey:KCOUNTRY];
    address2TXT.text = [_dicProfile valueForKey:KADDRESS2];
    phoneNameTXT.text = [_dicProfile valueForKey:kNUM_CELL_PHONE];
    emailNameTXT.text = [_dicProfile valueForKey:KEMAIL];
    cityTXT.text = [_dicProfile valueForKey:KCITY];
    regionStateTXT.text = [_dicProfile valueForKey:KSATE];
    NSString *phone = [self _getPhoneCode:[_dicProfile valueForKey:kNUM_COUNTRY]];
    _indexActtionCountryCode = [self _getPhoneCodeForString:phone];
    [dropListCountryCode setTitle:phone forState:UIControlStateNormal];
}

- (NSArray*)arrayCountryCode {
    if (!_arrayCountryCode) {
        return _arrayCountryCode = [LoadFileManager loadFileJsonWithName:@"JsonPhoneCode"];
    }
    return _arrayCountryCode;
}

- (void)setProfileObject:(COListProfileObject *)profileObject {
    _profileObject = profileObject;
}

- (NSMutableDictionary*)_getAccessToken {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[kACCESS_TOKEN] = [kUserDefaults valueForKey:kACCESS_TOKEN];
    dic[kTOKEN_TYPE] = [kUserDefaults valueForKey:kTOKEN_TYPE];
    return dic;
}


- (NSDictionary*)_getProfileObject {
    NSString *phone = [self.arrayCountryCode[_indexActtionCountryCode] valueForKey:@"code"];
    NSMutableDictionary *obj = [[NSMutableDictionary alloc]init];
    [obj setValue:self.profileObject.username forKey:kUSER];
    [obj setValue:self.profileObject.first_name forKey:KFRIST_NAME];
    [obj setValue:self.profileObject.last_name forKey:KLAST_NAME];
    [obj setValue:phone forKey:kNUM_COUNTRY];
    [obj setValue:phoneNameTXT.text forKey:kNUM_CELL_PHONE];
    [obj setValue:addressNameTXT.text  forKey:KADDRESS];
    [obj setValue:emailNameTXT.text forKey:KEMAIL];
    [obj setValue:cityTXT.text forKey:KCITY];
    [obj setValue:countryTXT.text forKey:KCOUNTRY];
    [obj setValue:address2TXT.text forKey:KADDRESS2];
    [obj setValue:regionStateTXT.text forKey:KSATE];
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
    
    self.navigationItem.title = m_string(@"Basic Info");
    [self _setupBarButtonCancel];
    [self _setupBarButtonDone];
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Done")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:m_string(@"Cancel")
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
        [self _actionShowAleartViewWithTitle:@"Email  is required."];
        return NO;
    } else if (![emailNameTXT.text isValidEmail]) {
        _currentField = emailNameTXT;
        [self _actionShowAleartViewWithTitle:@"Email is invalid."];
        return NO;
    } else if ([phoneNameTXT.text isEmpty]) {
        _currentField = phoneNameTXT;
        [self _actionShowAleartViewWithTitle:@"Phone is required."];
        return NO;
    } else if ([addressNameTXT.text isEmpty]) {
        _currentField = addressNameTXT;
        [self _actionShowAleartViewWithTitle:@"Address is required."];
        
        return NO;
    }
    return YES;
}

#pragma mark - Web Service
- (void)_callWSUpdateProfile {
    [UIHelper showLoadingInView:self.view];
    [[WSURLSessionManager shared] wsUpdateProfileWithUserToken:[self _getAccessToken] body:[self _getProfileObject] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            DBG(@"%@",responseObject);
            [self dismissViewControllerAnimated:YES completion:nil];
        }else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

#pragma mark - Action

- (void)__actionDone:(id)sender {
    if ([self _isValidation]) {
        if ([self.delegate respondsToSelector:@selector(editAboutProfile:profileUpdate:)]) {
            [self.delegate editAboutProfile:self profileUpdate:[self _getProfileObject]];
        }
        [self _callWSUpdateProfile];
    }
}

- (void)__actionDCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)__actionCountryCode:(id)sender {
    [self.view endEditing:YES];
    [CODropListView presentWithTitle:@"Phone Codes" data:self.arrayCountryCode selectedIndex:_indexActtionCountryCode
                           didSelect:^(NSInteger index) {
        [dropListCountryCode setTitle:[self.arrayCountryCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionCountryCode = index;
    }];
}

- (void)_actionShowAleartViewWithTitle:(NSString*)message {
    [self.view endEditing:YES];
    [UIHelper showAleartViewWithTitle:m_string(@"CoAssets")
                              message:m_string(message)
                         cancelButton:m_string(@"OK")
                             delegate:self
                                  tag:0
                     arrayTitleButton:nil];
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [_currentField becomeFirstResponder];
   _currentField = nil;
}

@end
