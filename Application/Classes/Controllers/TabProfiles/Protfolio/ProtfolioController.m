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

#define NumberOfItemInSection    7
#define NumberOfCellForWithAndHeight    175
#define Top_Bottom_Tabar_Nav_Aligin     131
#define Left_Reight_Aligin              18
#define Height_ForRow_PortFolioCell        210
#define Height_ForRow_CompletedCell        138
#define Height_ForRow_AvailableBalanceCell 119
#define Height_ForRow_FormCell             260

@interface ProtfolioController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_collectionView;
}

@property (strong,nonatomic) NSArray *arrayList;
@end

@implementation ProtfolioController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpUI];
}

#pragma mark - Private

- (void)_setUpUI {
    self.navigationItem.title = m_string(@"PORTFOLIO");
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:[PortFolioCell identifier] bundle:nil] forCellWithReuseIdentifier:[PortFolioCell identifier]];
    [_collectionView registerNib:[UINib nibWithNibName:[CompletedCell identifier] bundle:nil] forCellWithReuseIdentifier:[CompletedCell identifier]];
     [_collectionView registerNib:[UINib nibWithNibName:[AvailableBalanceCell identifier] bundle:nil] forCellWithReuseIdentifier:[AvailableBalanceCell identifier]];
     [_collectionView registerNib:[UINib nibWithNibName:[FormCell identifier] bundle:nil] forCellWithReuseIdentifier:[FormCell identifier]];
}

#pragma mark - Set Get
- (NSArray*)arrayList {
    if (!_arrayList) {
        _arrayList = [LoadFileManager loadFilePlistWithName:@"FortFolioPlist"];
    }
    return _arrayList;
}

- (COAccountInvestmentModel*)accountModel {
    if (_accountModel) {
        return _accountModel;
    }
    return _accountModel = [[COLoginManager shared] accountModel];
}

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return NumberOfItemInSection;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 2;
    CGFloat height = Height_ForRow_PortFolioCell;
    
    if (indexPath.row == 4) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_CompletedCell;
    } else if ( indexPath.row == 5) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_AvailableBalanceCell;
    } else if ( indexPath.row == 6) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_FormCell;
    }
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return [self collectionView:collectionView CompletedCellAtIndexPath:indexPath];
    } else if (indexPath.row == 5) {
        return  [self collectionView:collectionView availableBalanceCellAtIndexPath:indexPath];
    } else if (indexPath.row == 6) {
        return  [self collectionView:collectionView formCellAtIndexPath:indexPath];
    }
    return [self collectionView:collectionView portFolioCellAtIndexPath:indexPath];
}

#pragma mark - cells
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView portFolioCellAtIndexPath:(NSIndexPath *)indexPath {
    PortFolioCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[PortFolioCell identifier] forIndexPath:indexPath];
    switch (indexPath.row) {
        case COPortfolioOngoingStype:
            cell.OngoingProjects = self.accountModel; break;
        case COPortfolioInvesterStype:
            cell.OngoingInvestment = self.accountModel; break;
        case COPortfolioFundedStype:
            cell.CompletedInvestment = self.accountModel; break;
        case COPortfolioCompleteStype:
            cell.CompletedProjects = self.accountModel; break;
        default: break;
    }
    return cell;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView CompletedCellAtIndexPath:(NSIndexPath *)indexPath {
    CompletedCell *cellComplete = [collectionView dequeueReusableCellWithReuseIdentifier:[CompletedCell identifier] forIndexPath:indexPath];
    return cellComplete;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView availableBalanceCellAtIndexPath:(NSIndexPath *)indexPath {
    AvailableBalanceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AvailableBalanceCell identifier] forIndexPath:indexPath];
    return cell;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView formCellAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FormCell identifier] forIndexPath:indexPath];
    return cell;
}

@end
