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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

#pragma mark - Set Get

- (void)setInvestorUserModel:(COUserInverstorModel *)investorUserModel {
    _investorUserModel = investorUserModel;
    NSString *stringDuration = [UIHelper formatStringUnknown:[_investorUserModel COInvestorDurationContent]];
    if ([stringDuration isEqualToString:@"0"]){
        _durationTextField.placeholder = @"0";
    } else {
        _durationTextField.text = stringDuration;
    }
    NSString *stringTagert = [UIHelper formatStringUnknown:[_investorUserModel COInvestorTargetContent]];
    if ([stringTagert isEqualToString:@"0"]) {
        _targetTextField.placeholder = @"0";
    } else {
        _targetTextField.text = stringTagert;
    }
    _investmentTextField.text = [_investorUserModel COInvestorAmountContent];
    _countriesTextField.text = [_investorUserModel COInvestorCountriesContent];
    _descriptionTextField.text = [_investorUserModel CODescriptionsContent];
    _websiteTextField.text = [_investorUserModel COWebsiteContent];
    NSString *currency = [_investorUserModel COCureencyContent];
    _indexActtionCureency = [self _getCurrencyForString:currency];
    [_btnCurrency setTitle:currency forState:UIControlStateNormal];
    NSString *Invertor = [_investorUserModel COInvestorTypeContent];
    _indexActtionInvestor = [self _getInvertorForString:Invertor];
    [_btnInvestor setTitle:Invertor forState:UIControlStateNormal];
    NSString *project = [_investorUserModel COInvestorPreferenceContent];
    _indexActtionProject = [self _getProjectForString:project];
    [_btnProject setTitle:project forState:UIControlStateNormal];
}

- (NSArray *)arrayCurrency {
    if (_arrayCurrency) {
        return _arrayCurrency;
    }
    return _arrayCurrency = [UIHelper getArrayCurrency];
}

- (NSInteger)_getCurrencyForString:(NSString*)string{
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
    return _arrayProject = @[@"Bulk Purchase",@"Crowdfunding",@"Pre-Sales"];
}

- (NSInteger)_getProjectForString:(NSString*)string {
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

#pragma mark - WS

- (NSDictionary *)_creatUpdateInfoInvestor {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *duration = [UIHelper getNumberInstring:[UIHelper formatStringUnknown:_durationTextField.text]];
    [dic setValue:[self _setModelNilOrNotNil:duration] forKey:kUpIVProfileDuration];
    NSString *target = [UIHelper getNumberInstring:[UIHelper formatStringUnknown:_targetTextField.text]];
    [dic setValue:[self _setModelNilOrNotNil:target] forKey:kUpIVProfileTarget];
    [dic setValue:[self _setModelNilOrNotNil:_investmentTextField.text] forKey:kUpIVProfileInvestment];
    [dic setValue:[self _setModelNilOrNotNil:_countriesTextField.text] forKey:kUpIVProfileCountries];
    [dic setValue:[self _setModelNilOrNotNil:_descriptionTextField.text] forKey:kUpIVProfileDescriptions];
    [dic setValue:[self _setModelNilOrNotNil:_websiteTextField.text] forKey:kUpIVProfileWebsite];
    [dic setValue:[self _setModelNilOrNotNil:_btnCurrency.titleLabel.text] forKey:kUpIVProfileCurrency];
    [dic setValue:[self _setModelNilOrNotNil:_btnInvestor.titleLabel.text] forKey:kUpIVProfileInvestor];
    [dic setValue:[self _setModelNilOrNotNil:_btnProject.titleLabel.text] forKey:kUpIVProfileProject];
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
    [kUserDefaults setObject:data forKey:UPDATE_INVESTOR_PROFILE_JSON];
    [kUserDefaults synchronize];
}

#pragma mark - Action

- (void)__actionDone:(id)sender {
    [self _updateProfileUserModel:[self _creatUpdateInfoInvestor]];
    if (self.actionDone) {
        self.actionDone();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
