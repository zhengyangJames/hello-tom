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

#define NumberOfCellForWithAndHeight    175
#define Top_Bottom_Tabar_Nav_Aligin     131
#define Left_Reight_Aligin              18

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
    self.navigationItem.title = m_string(@"Portfolio");
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:[PortFolioCell identifier] bundle:nil] forCellWithReuseIdentifier:[PortFolioCell identifier]];
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
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 18) / 2;
    CGFloat height = ([UIScreen mainScreen].bounds.size.height - 131) / 2;
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
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

@end
