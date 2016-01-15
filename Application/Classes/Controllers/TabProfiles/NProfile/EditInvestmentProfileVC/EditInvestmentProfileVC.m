//
//  EditInvestmentProfileVC.m
//  CoAssets
//
//  Created by Tony Tuong on 10/7/15.
//  Copyright © 2015 Sanyi. All rights reserved.
//

#import "EditInvestmentProfileVC.h"
#import "CODropListView.h"
#import "COBorderTextField.h"
#import "COBorderTextView.h"
#import "CoDropListButtom.h"
#import "WSUpdateInvestorProfile.h"
#import "WSURLSessionManager+Profile.h"
#import "COLoginManager.h"

@interface EditInvestmentProfileVC ()
{
    __weak IBOutlet CoDropListButtom *_btnInvestor;
    __weak IBOutlet CoDropListButtom *_btnProject;
    __weak IBOutlet CoDropListButtom *_btnCurrency;
    __weak IBOutlet COBorderTextField *_investmentTextField;
    __weak IBOutlet COBorderTextField *_durationTextField;
    __weak IBOutlet COBorderTextField *_targetTextField;
    __weak IBOutlet COBorderTextView *_countriesTextField;
    __weak IBOutlet COBorderTextView *_descriptionTextField;
    __weak IBOutlet COBorderTextField *_websiteTextField;
    
    NSInteger _indexActtionInvestor;
    NSInteger _indexActtionProject;
    NSInteger _indexActtionCureency;
}

@property (nonatomic, strong) NSArray *arrayInvertor;
@property (nonatomic, strong) NSArray *arrayProject;
@property (nonatomic, strong) NSArray *arrayCurrency;


@end

@implementation EditInvestmentProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setupUI];
    self.investorUserModel = self.investorUserModel;
}

#pragma mark - Set Get

- (void)setInvestorUserModel:(COUserInverstorModel *)investorUserModel {
    _investorUserModel = investorUserModel;
    NSString *stringDuration = [UIHelper formatStringUnknown:[_investorUserModel COInvestorDurationContent]];
    if ([stringDuration isEqualToString:@"0"]||[stringDuration isEqualToString:@"Unknown"]){
        _durationTextField.placeholder = @"0";
    } else {
        _durationTextField.text = stringDuration;
    }
    NSString *stringTagert = [UIHelper formatStringUnknown:[_investorUserModel COInvestorTargetContent]];
    if ([stringTagert isEqualToString:@"0"]||[stringTagert isEqualToString:@"Unknown"]) {
        _targetTextField.placeholder = @"0";
    } else {
        _targetTextField.text = stringTagert;
    }
    NSString *invester = [UIHelper formatStringUnknown:[_investorUserModel COInvestorAmountContent]];
    if ([invester isEqualToString:@"0"]||[invester isEqualToString:@"Unknown"]) {
        _investmentTextField.placeholder = @"0";
    } else {
        _investmentTextField.text = invester;
    }
    _countriesTextField.text = [_investorUserModel COInvestorCountriesContent];
    _descriptionTextField.text = [_investorUserModel CODescriptionsContent];
    _websiteTextField.text = [_investorUserModel COWebsiteContent];
    NSString *currency = [_investorUserModel COCureencyContent];
    _indexActtionCureency = [self _getCurrencyForString:currency];
    [_btnCurrency setTitle:[UIHelper getStringCurrencyOfferWithKey:currency] forState:UIControlStateNormal];
    NSString *Invertor = [_investorUserModel COInvestorTypeContent];
    _indexActtionInvestor = [self _getInvertorForString:Invertor];
    [_btnInvestor setTitle:[UIHelper getInvestorTypeWithKey:Invertor] forState:UIControlStateNormal];
    NSString *project = [_investorUserModel COInvestorPreferenceContent];
    _indexActtionProject = [self _getProjectForString:project];
    [_btnProject setTitle:[UIHelper getProjectTypeWithKey:project] forState:UIControlStateNormal];
}

- (NSArray *)arrayCurrency {
    if (_arrayCurrency) {
        return _arrayCurrency;
    }
    return _arrayCurrency = [UIHelper getArrayCurrency];
}

- (NSInteger)_getCurrencyForString:(NSString*)string{
    string = [UIHelper getStringCurrencyOfferWithKey:string];
    NSInteger num = 0;
    for (int i = 0 ; i < self.arrayCurrency.count; i++) {
        if ([string isEqualToString:self.arrayCurrency[i]]) {
            num = i ;
        }
    }
    return num;
}

- (NSArray *)arrayInvertor {
    if (_arrayInvertor) {
        return _arrayInvertor;
    }
    return _arrayInvertor = [UIHelper getInvestorType];
}

- (NSInteger)_getInvertorForString:(NSString*)string {
    string = [UIHelper getInvestorTypeWithKey:string];
    NSInteger num = 0;
    for (int i = 0 ; i < self.arrayInvertor.count; i++) {
        if ([string isEqualToString:self.arrayInvertor[i]]) {
            num = i ;
        }
    }
    return num;
}

- (NSArray *)arrayProject {
    if (_arrayProject) {
        return _arrayProject;
    }
    return _arrayProject = [UIHelper arrayProjectType];
}

- (NSInteger)_getProjectForString:(NSString*)string {
    string = [UIHelper getProjectTypeWithKey:string];
    NSInteger num = 0;
    for (int i = 0 ; i < self.arrayProject.count; i++) {
        if ([string isEqualToString:self.arrayProject[i]]) {
            num = i ;
        }
    }
    return num;
}

#pragma mark - Private

- (void)_setupUI {
    
    self.navigationItem.title = m_string(@"I_PROFILE");
    [self _setupBarButtonCancel];
    [self _setupBarButtonDone];
}

- (void)_setupBarButtonDone {
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithTitle:m_string(@"DONE_TITLE")
                                                              style:UIBarButtonItemStyleDone
                                                             target:self
                                                             action:@selector(__actionDone:)];
    [btDone setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                          forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btDone;
}

- (void)_setupBarButtonCancel {
    UIBarButtonItem *btCancel = [[UIBarButtonItem alloc]initWithTitle:m_string(@"CANCEL_TITLE")
                                                                style:UIBarButtonItemStyleDone
                                                               target:self
                                                               action:@selector(__actionDCancel:)];
    [btCancel setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:17]}
                            forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btCancel;
}

#pragma mark - WS

- (id)_setModelNotNil:(NSString*)string {
    if ([string isEmpty]) {
        return @"0";
    } else {
        return string;
    }
}


- (void)_callWSUpdateInvertorProfile {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    [[WSURLSessionManager shared] wsUpdateInvestorProfile:[self _setUpdateInvertorProfileRequest] handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
        if (self.actionDone) {
            self.actionDone();
        }
        if (error) {
            [ErrorManager showError:error];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
    }];
}

- (WSUpdateInvestorProfile *)_setUpdateInvertorProfileRequest {
    WSUpdateInvestorProfile *request = [[WSUpdateInvestorProfile alloc] init];
    [request setURL:[NSURL URLWithString:WS_METHOD_GET_PROFILE_INVESTER]];
    [request setHTTPMethod:METHOD_POST];
    [request setRequestWithTOken];
    [request setBodyParam:[UIHelper getStringCurrencyOfferWithValue:_btnCurrency.titleLabel.text]  forKey:kUpIVProfileCurrency];
    [request setBodyParam:_descriptionTextField.text forKey:kUpIVProfileDescriptions];
    [request setBodyParam:[self _setModelNotNil:_investmentTextField.text] forKey:kUpIVProfileInvestment];
    [request setBodyParam:_countriesTextField.text forKey:kUpIVProfileCountries];
    [request setBodyParam:[self _setModelNotNil:_durationTextField.text] forKey:kUpIVProfileDuration];
    [request setBodyParam:[UIHelper getProjectTypeWithValue:_btnProject.titleLabel.text] forKey:kUpIVProfileProject];
    [request setBodyParam:[self _setModelNotNil:_targetTextField.text] forKey:kUpIVProfileTarget];
    [request setBodyParam:[UIHelper getInvestorTypeWithValue:_btnInvestor.titleLabel.text] forKey:kUpIVProfileInvestor];
    [request setBodyParam:_websiteTextField.text forKey:kUpIVProfileWebsite];
    return request;
}

- (void)_updateInvestorProfileJson {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[UIHelper getStringCurrencyOfferWithValue:_btnCurrency.titleLabel.text]  forKey:kUpIVProfileCurrency];
    [dic setValue:_descriptionTextField.text forKey:kUpIVProfileDescriptions];
    [dic setValue:[self _setModelNotNil:_investmentTextField.text] forKey:kUpIVProfileInvestment];
    [dic setValue:_countriesTextField.text forKey:kUpIVProfileCountries];
    [dic setValue:[self _setModelNotNil:_durationTextField.text] forKey:kUpIVProfileDuration];
    [dic setValue:[UIHelper getProjectTypeWithValue:_btnProject.titleLabel.text] forKey:kUpIVProfileProject];
    [dic setValue:[self _setModelNotNil:_targetTextField.text] forKey:kUpIVProfileTarget];
    [dic setValue:[UIHelper getInvestorTypeWithValue:_btnInvestor.titleLabel.text] forKey:kUpIVProfileInvestor];
    [dic setValue:_websiteTextField.text forKey:kUpIVProfileWebsite];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    [kUserDefaults setObject:data forKey:UPDATE_INVESTOR_PROFILE_JSON];
    [kUserDefaults synchronize];
}


#pragma mark - Action

- (void)__actionDone:(id)sender {
    [self.view endEditing:YES];
    [self _callWSUpdateInvertorProfile];
}


- (void)__actionDCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)__actionInvestor:(id)sender {
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Investor Type" data:self.arrayInvertor selectedIndex:_indexActtionInvestor didSelect:^(NSInteger index) {
        _indexActtionInvestor = index;
        [_btnInvestor setTitle:self.arrayInvertor[index] forState:UIControlStateNormal];
    }];
}

- (IBAction)__actionProject:(id)sender {
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Project Preference" data:self.arrayProject selectedIndex:_indexActtionProject didSelect:^(NSInteger index) {
        _indexActtionProject = index;
        [_btnProject setTitle:self.arrayProject[index] forState:UIControlStateNormal];
    }];
}

- (IBAction)__actionCurrentcy:(id)sender {
    [self.view endEditing:NO];
    [CODropListView presentWithTitle:@"Currency" data:self.arrayCurrency selectedIndex:_indexActtionCureency didSelect:^(NSInteger index) {
        _indexActtionCureency = index;
        [_btnCurrency setTitle:self.arrayCurrency[index] forState:UIControlStateNormal];
    }];
}

@end
