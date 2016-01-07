//
//  EventViewController.m
//  CoAssets
//
//  Created by Macintosh HD on 1/7/16.
//  Copyright © 2016 Sanyi. All rights reserved.
//

#import "EventViewController.h"
#import "EventCollectionViewCell.h"

@interface EventViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_collectionview;
}

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = m_string(@"EVENT");
    _collectionview.dataSource = self;
    _collectionview.delegate   = self;
    [_collectionview registerNib:[UINib nibWithNibName:[EventCollectionViewCell identifier] bundle:nil] forCellWithReuseIdentifier:[EventCollectionViewCell identifier]];
}

#pragma mark - UICollectionviewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EventCollectionViewCell identifier] forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionviewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 50;
    CGFloat height = 440;
    CGSize size = CGSizeMake(width, height);
    return size;
}

@end
