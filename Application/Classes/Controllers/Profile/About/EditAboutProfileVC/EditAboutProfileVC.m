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
        [self _actionShowAleartViewWithTitle:NSLocalizedString(@"EMAIL_REQUIRED", nil)];
        return NO;
    } else if (![emailNameTXT.text isValidEmail]) {
        _currentField = emailNameTXT;
        [self _actionShowAleartViewWithTitle:NSLocalizedString(@"EMAIL_INVALID", nil)];
        return NO;
    } else if ([phoneNameTXT.text isEmpty]) {
        _currentField = phoneNameTXT;
        [self _actionShowAleartViewWithTitle:NSLocalizedString(@"PHONE_REQUIRED", nil)];
        return NO;
    } else if ([self _checkStringIsNumberOrCharacter:countryTXT.text]) {
        [self _actionShowAleartViewWithTitle:NSLocalizedString(@"ERROR_COUNTRY", nil)];
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
    [[WSURLSessionManager shared] wsUpdateProfileWithUserToken:[self _getAccessToken] body:[self _getProfileObject] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self _zipDataProfile:responseObject];
        }else {
            [UIHelper showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_zipDataProfile:(NSDictionary*)dic {
    NSMutableDictionary *dicPro = [NSMutableDictionary new];
    if ([dic objectForKeyNotNull:@"username"]) {
        dicPro[kUSER] = [dic objectForKeyNotNull:@"username"];
    }
    
    if ([dic objectForKeyNotNull:@"first_name"]) {
       dicPro[KFRIST_NAME] = [dic objectForKeyNotNull:@"first_name"];
    }
    
    if ([dic objectForKeyNotNull:@"last_name"]) {
        dicPro[KLAST_NAME] = [dic objectForKeyNotNull:@"last_name"];
    }
    
    if ([dic objectForKeyNotNull:@"email"]) {
        dicPro[KEMAIL] = [dic objectForKeyNotNull:@"email"];
    }
    
    if ([dic objectForKeyNotNull:@"cellphone"]) {
        dicPro[kNUM_CELL_PHONE] = [dic objectForKeyNotNull:@"cellphone"];
    }
    
    if ([dic objectForKeyNotNull:@"country_prefix"]) {
        dicPro[kNUM_COUNTRY] = [dic objectForKeyNotNull:@"country_prefix"];
    }
    
    if ([dic objectForKeyNotNull:@"address_1"]) {
       dicPro[KADDRESS] = [dic objectForKeyNotNull:@"address_1"];
    }
    
    if ([dic objectForKeyNotNull:@"address_2"]) {
        dicPro[KADDRESS2] = [dic objectForKeyNotNull:@"address_2"];
    }
    
    if ([dic objectForKeyNotNull:@"region_state"]) {
        dicPro[KSATE] = [dic objectForKeyNotNull:@"region_state"];
    }
    
    if ([dic objectForKeyNotNull:@"city"]) {
         dicPro[KCITY] = [dic objectForKeyNotNull:@"city"];
    }
    
    if ([dic objectForKeyNotNull:@"country"]) {
        dicPro[KCOUNTRY] = [dic objectForKeyNotNull:@"country"];
    }
    [kUserDefaults setObject:dicPro forKey:kPROFILE_OBJECT];
    [kUserDefaults synchronize];
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
    [CODropListView presentWithTitle:NSLocalizedString(@"PHONE_CODE_TITLE", nil) data:self.arrayCountryCode selectedIndex:_indexActtionCountryCode
                           didSelect:^(NSInteger index) {
        [dropListCountryCode setTitle:[self.arrayCountryCode[index] objectForKey:@"code"] forState:UIControlStateNormal];
        _indexActtionCountryCode = index;
    }];
}

- (void)_actionShowAleartViewWithTitle:(NSString*)message {
    [self.view endEditing:YES];
    [UIHelper showAleartViewWithTitle:NSLocalizedString(@"COASSETS_TITLE", nil)
                              message:m_string(message)
                         cancelButton:NSLocalizedString(@"OK_TITLE", nil)
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
