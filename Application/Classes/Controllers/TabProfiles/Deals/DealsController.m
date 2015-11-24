//
//  DealsController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "DealsController.h"
#import "COPositive&NagitiveButton.h"
#import "HomeListViewController.h"
#import "WSGetDealProfileRequest.h"
#import "WSURLSessionManager+DealProfile.h"
#import "DealTableViewCell.h"
#import "CODealProfileModel.h"
#import "COLoginManager.h"

@interface DealsController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UISegmentedControl *_segment;
    __weak IBOutlet UILabel *_introductionLabel;
    __weak IBOutlet UIView *_contentView;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UILabel *_greatLabel;
    __weak IBOutlet COPositive_NagitiveButton *__greatButton;
    __weak IBOutlet UIButton *_actionsegment;
    __weak NSString *strSignContract;
    __weak NSString *strPaymentInstruction;
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CODealProfileModel *dealModel;

@end

@implementation DealsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _callGetDealList];
    [self _setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _callGetDealList];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = NSLocalizedString(@"Deals", nil);
    [_segment setSelectedSegmentIndex:0];
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Raleway-Regular" size:15]} forState:UIControlStateNormal];
    [self _setupTableView];
    [self _setTilerLabelAndButton];
    
}

- (void)_setupTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerNib:[UINib nibWithNibName:@"DealTableViewCell" bundle:nil] forCellReuseIdentifier:@"DealTableViewCell"];
}

- (void)_setTilerLabelAndButton {
    _greatLabel.text = m_string(@"TITLE_LABEL");
    [__greatButton setTitle:m_string(@"TITLE_BUTTON") forState:UIControlStateNormal];
}

- (void)_setTilerLabelAndButton:(BOOL)hidden {
    [_tableView setHidden:hidden];
    _actionsegment.hidden = !hidden;
    _greatLabel.hidden = !hidden;
}

#pragma mark - Action
- (IBAction)__actionSegment:(id)sender {
    _segment = (UISegmentedControl*)sender;
    switch (_segment.selectedSegmentIndex) {
        case CODealsStypeOngoing:
            _introductionLabel.text = m_string(@"ON_GOING");
            [self reloadData:_segment.selectedSegmentIndex];
            break;
        case CODealsStypeCompleted:
            _introductionLabel.text = m_string(@"COMPLETED");
            [self reloadData:_segment.selectedSegmentIndex];
            break;
        case CODealsStypeFunded:
            _introductionLabel.text = m_string(@"FUNDED");
            [self reloadData:_segment.selectedSegmentIndex];
            break;
        default:  break;
    }
}

- (IBAction)__actionButtonGetStart:(id)sender {
    BaseTabBarController *base = [kAppDelegate baseTabBarController];
    [base setSelectedIndex:0];
}

- (void)reloadData:(NSInteger )index {
    [self _setTilerLabelAndButton:NO];
    self.dataArray = nil;
    if (index == 0) {
        self.dataArray = self.dealModel.dealOngoingModel;
    } else if (index == 1) {
        self.dataArray = self.dealModel.dealFundedModel;
    } else {
        self.dataArray = self.dealModel.dealCompleteModel;
    }
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        [_tableView reloadData];
    }];
}

- (void)_callGetDealList {
    
    [UIHelper showLoadingInView:self.view];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSString *device_token = [kUserDefaults objectForKey:KEY_DEVICE_TOKEN];
    if (device_token == nil) {
        device_token = @"debug_Simulator";
    }
    [dic setObject:device_token forKey:device_token_dic];
    [dic setObject:device_type forKey:device_type_dic];
    [dic setObject:application_name forKey:application_name_dic];
    [[WSURLSessionManager shared] wsGetDealRequest:dic handler:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [UIHelper hideLoadingFromView:self.view];
            self.dealModel = (CODealProfileModel *)responseObject;
            self.dataArray = self.dealModel.dealOngoingModel;
            strSignContract = self.dealModel.signContractInstruction;
            strPaymentInstruction =self.dealModel.paymentInstruction;
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [_tableView reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray != nil && self.dataArray.count >0) {
        [self _setTilerLabelAndButton:NO];
    } else {
        [self _setTilerLabelAndButton:YES];
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealTableViewCell" forIndexPath:indexPath];
    cell.strSig = strSignContract;
    cell.strPayMent = strPaymentInstruction;
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

@end
