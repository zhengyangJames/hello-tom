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

@interface PortFolioController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}
@property (strong,nonatomic) NSArray *arrayBalances;
@property (strong,nonatomic) NSArray *arrayCompleted;
@property (nonatomic, strong) COUserProfileModel *userModel;

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
    
    if (self.arrayCompleted && self.arrayCompleted.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellComplete]];
    }
    
    if (self.arrayBalances && self.arrayBalances.count > 0) {
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellAvailableBalance]];
        [_arrType addObject:[NSNumber numberWithInteger:COPortpolioCellForm]];
    }
    return _arrType;
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
    
    COPortFolioSection type = [[self.arrType objectAtIndex:indexPath.row] integerValue];
    switch (type) {
        case COPortpolioCellPortFolio:
            return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
            break;
        case COPortpolioCellAvailableBalance:
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
    cellComplete.arrayComplete = self.arrayCompleted;
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
    if (self.arrayCompleted.count > 0 ) {
        [UIHelper showLoadingIndicator];
    } else {
        [UIHelper showLoadingInView:self.view];
    }
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
        [UIHelper hideLoadingIndicator];
        [UIHelper hideLoadingFromView:self.view];
    }];
}

- (void)_callAPIGetAvailableBalances {
    if (self.arrayBalances.count > 0) {
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
