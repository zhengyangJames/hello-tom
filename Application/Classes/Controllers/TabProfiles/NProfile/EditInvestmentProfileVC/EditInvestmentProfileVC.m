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
    __weak IBOutlet COBorderTextField *_countriesTextField;
    __weak IBOutlet COBorderTextField *_descriptionTextField;
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
    if ([[_investorUserModel COInvestorDurationContent] isEqualToString:@"Unknown"]) {
        _durationTextField.text = @"0";
    } else {
        _durationTextField.text = [_investorUserModel COInvestorDurationContent];
    }
    if ([[_investorUserModel COInvestorTargetContent] isEqualToString:@"Unknown"]) {
        _targetTextField.text = @"0";
    } else {
        _targetTextField.text = [_investorUserModel COInvestorTargetContent];
    }
    
    _investmentTextField.text = [_investorUserModel COInvestorAmountContent];
    _countriesTextField.text = [_investorUserModel COInvestorCountriesContent];
    _descriptionTextField.text = [_investorUserModel CODescriptionsContent];
    _websiteTextField.text = [_investorUserModel COWebsiteContent];
    [_btnCurrency setTitle:[_investorUserModel COCureencyContent] forState:UIControlStateNormal];
    [_btnInvestor setTitle:[_investorUserModel COInvestorTypeContent] forState:UIControlStateNormal];
    [_btnProject setTitle:[_investorUserModel COInvestorPreferenceContent] forState:UIControlStateNormal];
}

- (NSArray *)arrayCurrency {
    if (_arrayCurrency) {
        return _arrayCurrency;
    }
    return _arrayCurrency = [UIHelper getArrayCurrency];
}

- (NSArray *)arrayInvertor {
    if (_arrayInvertor) {
        return _arrayInvertor;
    }
    return _arrayInvertor = [UIHelper getInvestorType];
}

- (NSArray *)arrayProject {
    if (_arrayProject) {
        return _arrayProject;
    }
    return _arrayProject = @[@"Bulk Purchase",@"Crowdfunding",@"Pre-Sales"];
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
    [dic setValue:[self _setModelNilOrNotNil:_investmentTextField.text] forKey:kUpIVProfileInvestment];
    [dic setValue:[self _setModelNilOrNotNil:_durationTextField.text] forKey:kUpIVProfileDuration];
    [dic setValue:[self _setModelNilOrNotNil:_targetTextField.text] forKey:kUpIVProfileTarget];
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
