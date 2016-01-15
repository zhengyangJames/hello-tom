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
}

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) CODealProfileModel *dealModel;

@end

@implementation DealsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self _callGetDealList];
}

#pragma mark - Getter

- (NSArray *)dataArray {
    if (_dataArray) {
        return _dataArray;
    }
    _dataArray = [[NSArray alloc] init];
    switch (_segment.selectedSegmentIndex) {
        case CODealsStypeOngoing:
            _introductionLabel.text = m_string(@"ON_GOING");
            _dataArray = self.dealModel.dealOngoingModel;
            break;
        case CODealsStypeCompleted:
            _introductionLabel.text = m_string(@"COMPLETED");
            _dataArray = self.dealModel.dealCompleteModel;
            break;
        case CODealsStypeFunded:
            _introductionLabel.text = m_string(@"FUNDED");
            _dataArray = self.dealModel.dealFundedModel;
            break;
    }
    return _dataArray;
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = m_string(@"DEALS");
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

- (void)_reloadData {
    self.dataArray = nil;
    [_tableView reloadData];
    BOOL hiden = self.dataArray.count >0;
    [self _setTilerLabelAndButton:!hiden];
}

#pragma mark - Action
- (IBAction)__actionSegment:(id)sender {
    _segment = (UISegmentedControl*)sender;
    [self _reloadData];
}

- (IBAction)__actionButtonGetStart:(id)sender {
    BaseTabBarController *base = [kAppDelegate baseTabBarController];
    [base setSelectedIndex:0];
}

- (void)_callGetDealList {
    [UIHelper showLoadingInView:[kAppDelegate window]];
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
            self.dealModel = (CODealProfileModel *)responseObject;
            self.dataArray = nil;
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                [self _reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:[kAppDelegate window]];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealTableViewCell" forIndexPath:indexPath];
    cell.deal = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 185;
}

@end
