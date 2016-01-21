//
//  ProtfolioController.m
//  CoAssets
//
//  Created by Macintosh HD on 10/2/15.
//  Copyright (c) 2015 Sanyi. All rights reserved.
//


#import "ProtfolioController.h"
#import "LoadFileManager.h"
#import "PortFolioCell.h"
#import "COLoginManager.h"
#import "CompletedCell.h"
#import "AvailableBalanceCell.h"
#import "FormCell.h"
#import "COLoginManager.h"
#import "WSURLSessionManager+Portfolio.h"
#import "COUserProfileModel.h"
#import "COMultiPortpolioModel.h"

#define NumberOfCellForWithAndHeight    175
#define Top_Bottom_Tabar_Nav_Aligin     131
#define Left_Reight_Aligin              18
#define Height_ForRow_PortFolioCell        50

@interface ProtfolioController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *_tableView;
}

@property (strong,nonatomic) NSArray *arrayList;
@property (strong,nonatomic) NSArray *arrayBalances;
@property (strong,nonatomic) NSDictionary *dicData;
@property (nonatomic, strong) COUserProfileModel *userModel;

@end

@implementation ProtfolioController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = m_string(@"PORTFOLIO");
    [self callGetCompleteDrawals];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:[PortFolioCell identifier] bundle:nil] forCellReuseIdentifier:[PortFolioCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[CompletedCell identifier] bundle:nil] forCellReuseIdentifier:[CompletedCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[AvailableBalanceCell identifier] bundle:nil] forCellReuseIdentifier:[AvailableBalanceCell identifier]];
    [_tableView registerNib:[UINib nibWithNibName:[FormCell identifier] bundle:nil] forCellReuseIdentifier:[FormCell identifier]];
    
}

#pragma mark - Set Get
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

- (COMultiPortpolioModel *)multiPortpolio {
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
    return _arrayBalances = [kUserDefaults objectForKey:UPDATE_PORTPOLIO_BALANCE];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.dicData allKeys].count ==0 && self.arrayBalances.count == 0) {
        return 3;
    } else if ([self.dicData allKeys].count ==0 && self.arrayBalances.count != 0) {
        return 4;
    }  else if ([self.dicData allKeys].count ==0 && self.arrayBalances.count == 0) {
        return 4;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dicData allKeys].count ==0 && self.arrayBalances.count == 0) {
        return [self loadPortFolioCell:tableView indexpath:indexPath];
    } else if ([self.dicData allKeys].count ==0 && self.arrayBalances.count != 0) {
        return [self loadBalanceAndPortPolioCell:tableView indexpath:indexPath];
    }  else if ([self.dicData allKeys].count !=0 && self.arrayBalances.count == 0) {
        return [self loadCompleteAndPortPolioCell:tableView indexpath:indexPath];
    }
    return [self loadAllCell:tableView indexpath:indexPath];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Height_ForRow_PortFolioCell;
}

#pragma mark - LoadCell
- (UITableViewCell *)loadAllCell:(UITableView *)tableView indexpath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return [self tableView:tableView completedCellForRowAtIndexPath:indexPath];
    } else if (indexPath.row == 3) {
        return  [self tableView:tableView availableBalanceCellForRowAtIndexPath:indexPath];
    } else if (indexPath.row == 4) {
        return [self tableView:tableView formCellForRowAtIndexPath:indexPath];
    }
    return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)loadPortFolioCell:(UITableView *)tableView indexpath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return [self tableView:tableView formCellForRowAtIndexPath:indexPath];
    }
    return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)loadBalanceAndPortPolioCell:(UITableView *)tableView indexpath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return  [self tableView:tableView availableBalanceCellForRowAtIndexPath:indexPath];
    } else if (indexPath.row ==3 ) {
        return [self tableView:tableView formCellForRowAtIndexPath:indexPath];
    }
    return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)loadCompleteAndPortPolioCell:(UITableView *)tableView indexpath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return [self tableView:tableView completedCellForRowAtIndexPath:indexPath];
    } else if (indexPath.row ==3 ) {
        return [self tableView:tableView formCellForRowAtIndexPath:indexPath];
    }
    return [self tableView:tableView portFolioCellForRowAtIndexPath:indexPath];
}

#pragma mark - cells
- (UITableViewCell *)tableView:(UITableView *)tableView portFolioCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PortFolioCell *cell = [tableView dequeueReusableCellWithIdentifier:[PortFolioCell identifier] forIndexPath:indexPath];
    cell.multiPortlio = self.multiPortpolio;
    if (indexPath.row == 0) {
        cell.OngoingProjects = [self.multiPortpolio ongoingProject];
        cell.OngoingInvestment = [self.multiPortpolio ongoingInvestment];
    } else {
        cell.CompletedInvestment = [self.multiPortpolio completeInvestment];
        cell.CompletedProjects = [self.multiPortpolio completeProject];
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
        cell.arrayData = self.arrayBalances;
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView formCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:[FormCell identifier] forIndexPath:indexPath];
    return cell;
}

#pragma mark - webservice
- (void)callGetCompleteDrawals {
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
                [self callGetBalances];
                [UIHelper hideLoadingIndicator];
                [UIHelper hideLoadingFromView:self.view];
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingIndicator];
            [UIHelper hideLoadingFromView:self.view];
        }
    }];
}
- (void)callGetBalances {
    if (self.arrayBalances != nil) {
        [UIHelper showLoadingIndicator];
    } else {
        [UIHelper showLoadingInView:self.view];
    }
    NSString *username = [self.userModel userName];
    [[WSURLSessionManager shared] wsGetBalancesRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [_tableView reloadData];
                [UIHelper hideLoadingIndicator];
                [UIHelper hideLoadingFromView:self.view];
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingIndicator];
            [UIHelper hideLoadingFromView:self.view];
        }
    }];
}

@end
