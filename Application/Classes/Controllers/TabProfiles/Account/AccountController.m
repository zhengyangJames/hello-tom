//
//  AccountController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//

#import "AccountController.h"
#import "AccountCell.h"
#import "LoadFileManager.h"
#import "WSURLSessionManager+Profile.h"
#import "COLoginManager.h"


#define NUMBER_OF_ROW       5

@interface AccountController ()<UITableViewDelegate, UITableViewDataSource>
{
    __weak IBOutlet UITableView *_tableView;
    
}


@end

@implementation AccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
//    [self wsGetAccountInverstment];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = m_string(@"Account");
    [_tableView registerNib:[UINib nibWithNibName:[AccountCell identifier] bundle:nil] forCellReuseIdentifier:[AccountCell identifier]];
    UIView *view = [[UIView alloc]init];
    _tableView.tableFooterView = view;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma mark - Set Get



#pragma mark - WS
//- (void)wsGetAccountInverstment {
//    [UIHelper showLoadingInView:self.view];
//    NSDictionary *paramToken = [UIHelper getParamTokenWithModel:[[COLoginManager shared] userModel]];
//    [[WSURLSessionManager shared] wsGetAccountInvestment:paramToken handler:^(id responseObject, NSURLResponse *response, NSError *error) {
//        if (responseObject &&[responseObject isKindOfClass:[NSDictionary class]] && !error) {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//            [dic addEntriesFromDictionary:responseObject];
//            COAccountInvestmentModel *model = [MTLJSONAdapter modelOfClass:[COAccountInvestmentModel class] fromJSONDictionary:dic error:nil];
//            self.accountModel = model;
//        } else {
//            [UIHelper showError:error];
//        }
//        [UIHelper hideLoadingFromView:self.view];
//    }];
//}

#pragma mark - UITableView - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.accountModel) {
        return NUMBER_OF_ROW;
    } else {
        return 0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:[AccountCell identifier]
                                                        forIndexPath:indexPath];
    switch (indexPath.row) {
        case COAccountOngoingStype: cell.accountOnGoing = self.accountModel; break;
        case COAccountFundedStype: cell.accountFunded = self.accountModel; break;
        case COAccountCompleteStype: cell.accountCompleted = self.accountModel; break;
        case COAccountPotentialStype: cell.accountPotential = self.accountModel; break;
        case COAccountRealsStype: cell.accountRealised = self.accountModel; break;
        default:  break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DEFAULT_HEIGHT_CELL;
}

@synthesize accountModel = _accountModel;
@end
