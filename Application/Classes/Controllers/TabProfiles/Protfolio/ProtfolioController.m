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

#define NumberSectionOfCollectionview    4
#define NumberOfItemInSection    7
#define NumberOfCellForWithAndHeight    175
#define Top_Bottom_Tabar_Nav_Aligin     131
#define Left_Reight_Aligin              18
#define Height_ForRow_PortFolioCell        210
#define Height_ForRow_CompletedCell        138
#define Height_ForRow_AvailableBalanceCell 119
#define Height_ForRow_FormCell             260

@interface ProtfolioController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet UICollectionView *_collectionView;
}

@property (strong,nonatomic) NSArray *arrayList;
@property (strong,nonatomic) NSArray *arrayBalances;
@property (strong,nonatomic) NSArray *arrayCompleteDrawals;

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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return NumberSectionOfCollectionview;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == COPortpolioSection0) {
        return 4;
    } else if (section == COPortpolioSection1) {
        if (self.arrayCompleteDrawals != nil && self.arrayCompleteDrawals.count > 0 ) {
            return self.arrayCompleteDrawals.count;
        }
        return 0;
    } else if (section == COPortpolioSection2) {
        if (self.arrayBalances != nil && self.arrayBalances.count > 0 ) {
            return self.arrayBalances.count;
        }
        return 0;
    } else {
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 50) / 2;
    CGFloat height = Height_ForRow_PortFolioCell;
    if (indexPath.section == COPortpolioSection1) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_CompletedCell;
        return CGSizeMake(width, height);
        
    } else if (indexPath.section == COPortpolioSection2) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_AvailableBalanceCell;
        return CGSizeMake(width, height);
    } else if (indexPath.section == COPortpolioSection3) {
        width = ([UIScreen mainScreen].bounds.size.width - 10) ;
        height = Height_ForRow_FormCell;
        return CGSizeMake(width, height);
    }
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  [self cellItem:collectionView indexPath:indexPath];
}

-(UICollectionViewCell *)cellItem:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == COPortpolioSection0) {
        return [self collectionView:collectionView portFolioCellAtIndexPath:indexPath];
    } else if (indexPath.section == COPortpolioSection1) {
        return [self collectionView:collectionView CompletedCellAtIndexPath:indexPath];
    } else if (indexPath.section == COPortpolioSection2) {
        return  [self collectionView:collectionView availableBalanceCellAtIndexPath:indexPath];
    }
    return  [self collectionView:collectionView formCellAtIndexPath:indexPath];
    
}

//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat *targetWidth = _collectionView.bounds.size.width - 3
//    // Set up desired width
//    let targetWidth: CGFloat = (self.collectionView.bounds.width - 3 * kHorizontalInsets) / 2
//    
//    // Use fake cell to calculate height
//    let reuseIdentifier = kCellIdentifier
//    var cell: MyCollectionViewCell? = self.offscreenCells[reuseIdentifier] as? MyCollectionViewCell
//    if cell == nil {
//        cell = NSBundle.mainBundle().loadNibNamed("MyCollectionViewCell", owner: self, options: nil)[0] as? MyCollectionViewCell
//        self.offscreenCells[reuseIdentifier] = cell
//    }
//    
//    // Config cell and let system determine size
//    cell!.configCell(titleData[indexPath.item] as String, content: contentData[indexPath.item] as String, titleFont: fontArray[indexPath.item] as String, contentFont: fontArray[indexPath.item] as String)
//    
//    // Cell's size is determined in nib file, need to set it's width (in this case), and inside, use this cell's width to set label's preferredMaxLayoutWidth, thus, height can be determined, this size will be returned for real cell initialization
//    cell!.bounds = CGRectMake(0, 0, targetWidth, cell!.bounds.height)
//    cell!.contentView.bounds = cell!.bounds
//    
//    // Layout subviews, this will let labels on this cell to set preferredMaxLayoutWidth
//    cell!.setNeedsLayout()
//    cell!.layoutIfNeeded()
//    
//    var size = cell!.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//    // Still need to force the width, since width can be smalled due to break mode of labels
//    size.width = targetWidth
//    return size
//
//}

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
    cellComplete.dic = [self.arrayCompleteDrawals objectAtIndex:indexPath.row];
    return cellComplete;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView availableBalanceCellAtIndexPath:(NSIndexPath *)indexPath {
    AvailableBalanceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AvailableBalanceCell identifier] forIndexPath:indexPath];
    cell.dic = [self.arrayBalances objectAtIndex:indexPath.row];
    return cell;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView formCellAtIndexPath:(NSIndexPath *)indexPath {
    FormCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FormCell identifier] forIndexPath:indexPath];
    return cell;
}

#pragma mark - webservice
- (void)callGetCompleteDrawals {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    NSString *username = [kUserDefaults objectForKey:KEY_USERNAME];
    [[WSURLSessionManager shared] wsGetCompleteDrawalsRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                id destinationArray= @[@{@"GDC": @"1000"},
                                       @{@"YAT": @"1000"},
                                       @{@"ABC": @"1000"}];
                
                self.arrayCompleteDrawals = [destinationArray allObjects];
                [self callGetBalances];
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
        }
    }];
}
- (void)callGetBalances {
    [UIHelper showLoadingInView:[kAppDelegate window]];
    NSString *username = [kUserDefaults objectForKey:KEY_USERNAME];
    [[WSURLSessionManager shared] wsGetBalancesRequestHandler:username handle:^(id responseObject, NSURLResponse *response, NSError *error) {
        if (!error && responseObject != nil) {
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                self.arrayBalances = [responseObject allObjects];
                [_collectionView reloadData];
            }];
        } else {
            [ErrorManager showError:error];
            [UIHelper hideLoadingFromView:[kAppDelegate window]];
        }
    }];
}

@end
