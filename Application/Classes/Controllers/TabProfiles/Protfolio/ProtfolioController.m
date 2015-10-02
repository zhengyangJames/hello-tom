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

#define heightCollectionViewCellSize 150

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
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

#pragma mark - UICollectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 18) / 2;
    CGSize size = CGSizeMake(width, heightCollectionViewCellSize);
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PortFolioCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:[PortFolioCell identifier] forIndexPath:indexPath];
    cell.object = [self.arrayList[indexPath.row] objectForKey:@"text"];
    cell.imageName = [self.arrayList[indexPath.row] objectForKey:@"image"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
