//
//  ProtfolioController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//


#import "PortFolioController.h"
#import "LoadFileManager.h"
#import "PortFolioCell.h"
#import "COLoginManager.h"
#import "CompletedCell.h"
#import "AvailableBalanceCell.h"
#import "FormCell.h"
#import "COLoginManager.h"
#import "WSURLSessionManager+Portfolio.h"
#import "COUserProfileModel.h"
#import "COMultiPortFolioModel.h"

#define Height_ForRow_PortFolioCell        50

@interface PortfolioController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong,nonatomic) NSArray *arrayBalances;
@property (strong,nonatomic) NSArray *arrayCompleted;
@property (nonatomic, strong) COUserProfileModel *userModel;

@property (strong, nonatomic) COMultiPortfolioModel *multiPortfolio;
@property (strong, nonatomic) NSMutableArray *arrType;

@end

@implementation PortfolioController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

#pragma mark - Private
- (void)_setUpUI {
    self.navigationItem.title = m_string(@"PORTFOLIO");
    [self _callAPIGetCompleteDrawals];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:[PortfolioCell identifier] bundle:nil] forCellReuseIdentifier:[PortfolioCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompletedCell identifier] bundle:nil] forCellReuseIdentifier:[CompletedCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[AvailableBalanceCell identifier] bundle:nil] forCellReuseIdentifier:[AvailableBalanceCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[FormCell identifier] bundle:nil] forCellReuseIdentifier:[FormCell identifier]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)_reloadData {
    self.arrType = nil;
    [_tableView reloadData];
}

#pragma mark - Set Get
- (NSMutableArray *)arrType {
    if (_arrType) {
        return _arrType;
    }
    _arrType = [[NSMutableArray alloc] initWithArray:@[[NSNumber numberWithInteger:COPortfolioCellPortfolio], [NSNumber numberWithInteger:COPortfolioCellPortfolio]]];
    
    if (self.arrayCompleted && self.arrayCompleted.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortfolioCellComplete]];
    }
    
    if (self.arrayBalances && self.arrayBalances.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortfolioCellAvailableBalance]];
        [_arrType addObject:[NSNumber numberWithInteger:COPortfolioCellForm]];
    }
    return _arrType;
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    return _userModel = [[COLoginManager shared] userModel];
}

- (COMultiPortfolioModel *)multiPortfolio {
    if (_multiPortfolio) {
        return _multiPortfolio;
    }
    return _multiPortfolio = [[COLoginManager shared] multiPortfolio];
}

- (NSArray *)arrayCompleted {
    if (_arrayCompleted) {
        return _arrayCompleted;
    }
    return _arrayCompleted = [[NSArray alloc] init];
}

- (NSArray *)arrayBalances {
    if (_arrayBalances) {
        return _arrayBalances;
    }
    return _arrayBalances = [[NSArray alloc] init];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrType.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    COPortfolioSection type = [[self.arrType objectAtIndex:indexPath.row] integerValue];
    switch (type) {
        case COPortfolioCellPortfolio:
            return [self tableView:tableView portfolioCellForRowAtIndexPath:indexPath];
            break;
        case COPortfolioCellAvailableBalance:
            return  [self tableView:tableView availableBalanceCellForRowAtIndexPath:indexPath];
            break;
        case COPortfolioCellComplete:
            return [self tableView:tableView completedCellForRowAtIndexPath:indexPath];
            break;
        case COPortfolioCellForm:
            return [self tableView:tableView formCellForRowAtIndexPath:indexPath];
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_ForRow_PortFolioCell;
}

#pragma mark - cells
- (UITableViewCell *)tableView:(UITableView *)tableView portfolioCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PortfolioCell *cell = [tableView dequeueReusableCellWithIdentifier:[PortfolioCell identifier] forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.multiPortfolio = self.multiPortfolio;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView completedCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompletedCell *cellComplete = [tableView dequeueReusableCellWithIdentifier:[CompletedCell identifier] forIndexPath:indexPath];
    cellComplete.arrayComplete = self.arrayCompleted;
    return cellComplete;
}

- (UITableViewCell *)tableView:(UITableView *)tableView availableBalanceCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AvailableBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AvailableBalanceCell identifier] forIndexPath:indexPath];
    cell.arrayAvailableBalances = self.arrayBalances;
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView formCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:[FormCell identifier] forIndexPath:indexPath];
    cell.arrayAvailableBalance = self.arrayBalances;
    return cell;
}

#pragma mark - CallAPI
- (void)_callAPIGetCompleteDrawals {
    [UIHelper showLoadingInView:self.view];
    NSString *username = [self.userModel userName];
    [[WSURLSessionManager shared] wsGetCompleteDrawalsRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.arrayCompleted = responseObject;
                [self _callAPIGetAvailableBalances];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_callAPIGetAvailableBalances {
    [UIHelper showLoadingInView:self.view];
    NSString *username = [self.userModel userName];
    [[WSURLSessionManager shared] wsGetBalancesRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.arrayBalances = responseObject;
                [self _reloadData];
            }];
        } else {
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingFromView:self.view];
    }];
}

@end
