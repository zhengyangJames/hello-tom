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

#define NumberOfCellForWithAndHeight    175
#define Top_Bottom_Tabar_Nav_Aligin     131
#define Left_Reight_Aligin              18
#define Height_ForRow_PortFolioCell        50

@interface PortFolioController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong,nonatomic) NSArray *arrayList;
@property (strong,nonatomic) NSArray *arrayBalances;
@property (strong,nonatomic) NSDictionary *dicData;
@property (nonatomic, strong) COUserProfileModel *userModel;

@property (readonly,nonatomic) COPortfolioProfile protfolioStyle;
@property (strong, nonatomic) COMultiPortFolioModel *multiPortpolio;
@property (strong, nonatomic) NSMutableArray *arrType;

@end

@implementation PortFolioController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

#pragma mark - Private
- (void)_setUpUI {
    self.navigationItem.title = m_string(@"PORTFOLIO");
    [self _callAPIGetCompleteDrawals];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:[PortFolioCell identifier] bundle:nil] forCellReuseIdentifier:[PortFolioCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompletedCell identifier] bundle:nil] forCellReuseIdentifier:[CompletedCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[AvailableBalanceCell identifier] bundle:nil] forCellReuseIdentifier:[AvailableBalanceCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[FormCell identifier] bundle:nil] forCellReuseIdentifier:[FormCell identifier]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - Set Get
- (NSMutableArray *)arrType {
    if (_arrType) {
        return _arrType;
    }
    _arrType = [[NSMutableArray alloc] initWithArray:@[[NSNumber numberWithInteger:COPortpolioCellPortFolio], [NSNumber numberWithInteger:COPortpolioCellPortFolio]]];
    
    if (self.dicData && self.dicData.allKeys.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellComplete]];
    }
    
    if (self.arrayBalances && self.arrayBalances.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellAvailable]];
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellForm]];
    }
    return _arrType;
}

- (NSArray*)arrayList {
    if (!_arrayList) {
        _arrayList = [LoadFileManager loadFilePlistWithName:@"FortFolioPlist"];
    }
    return _arrayList;
}

- (COUserProfileModel *)userModel {
    if (_userModel) {
        return _userModel;
    }
    return _userModel = [[COLoginManager shared] userModel];
}

- (COMultiPortFolioModel *)multiPortpolio {
    if (_multiPortpolio) {
        return _multiPortpolio;
    }
    return _multiPortpolio = [[COLoginManager shared] multiPortpolio];
}

- (NSDictionary *)dicData {
    if (_dicData) {
        return _dicData;
    }
    return _dicData = [kUserDefaults objectForKey:UPDATE_PORTPOLIO_COMPLTETE];
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
    
    COPortFolioSection type = [[self.arrType objectAtIndex:indexPath.row] integerValue];
    switch (type) {
        case COPortpolioCellPortFolio:
            return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
            break;
        case COPortpolioCellAvailable:
            return  [self tableView:tableView availableBalanceCellForRowAtIndexPath:indexPath];
            break;
        case COPortpolioCellComplete:
            return [self tableView:tableView completedCellForRowAtIndexPath:indexPath];
            break;
        case COPortpolioCellForm:
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
- (UITableViewCell *)tableView:(UITableView *)tableView portFolioCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PortFolioCell *cell = [tableView dequeueReusableCellWithIdentifier:[PortFolioCell identifier] forIndexPath:indexPath];
    cell.multiPortlio = self.multiPortpolio;
    if (indexPath.row == 0) {
        cell.ongoingProjects = [self.multiPortpolio ongoingProject];
        cell.ongoingInvestment = [self.multiPortpolio ongoingInvestment];
    } else {
        cell.completedInvestment = [self.multiPortpolio completeInvestment];
        cell.completedProjects = [self.multiPortpolio completeProject];
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView completedCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CompletedCell *cellComplete = [tableView dequeueReusableCellWithIdentifier:[CompletedCell identifier] forIndexPath:indexPath];
    if (self.dicData != nil) {
        cellComplete.dic = self.dicData;
    }
    return cellComplete;
}

- (UITableViewCell *)tableView:(UITableView *)tableView availableBalanceCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AvailableBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:[AvailableBalanceCell identifier] forIndexPath:indexPath];
    if (self.arrayBalances.count > 0) {
        cell.arrayAvailableBalances = self.arrayBalances;
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView formCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:[FormCell identifier] forIndexPath:indexPath];
    if (self.arrayBalances.count > 0) {
        cell.arrayAvailableBalance = self.arrayBalances;
    }
    return cell;
}

#pragma mark - CallAPI
- (void)_callAPIGetCompleteDrawals {
    if (self.dicData != nil) {
        [UIHelper showLoadingIndicator];
    } else {
        [UIHelper showLoadingInView:self.view];
    }
    NSString *username = [self.userModel userName];
    [[WSURLSessionManager shared] wsGetCompleteDrawalsRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [UIHelper hideLoadingIndicator];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.dicData = responseObject;
                [self _callAPIGetBalances];
            }];
        } else {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self _reloadData];
            }];
            [ErrorManager showError:error];
        }
        [UIHelper hideLoadingIndicator];
        [UIHelper hideLoadingFromView:self.view];
    }];
}
- (void)_callAPIGetBalances {
    if (self.arrayBalances != nil) {
        [UIHelper showLoadingIndicator];
    } else {
        [UIHelper showLoadingInView:self.view];
    }
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
        [UIHelper hideLoadingIndicator];
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_reloadData {
    self.arrType = nil;
    [_tableView reloadData];
}

@end
