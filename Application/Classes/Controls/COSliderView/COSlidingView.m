//
//  ABSlidingView.m
//  ApptBooking
//
//  Created by Nikmesoft  M009 on 5/11/15.
//  Copyright (c) 2015 Linh NGUYEN. All rights reserved.
//

#import "COSlidingView.h"
#import "COSlidingCell.h"

@interface COSlidingView ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    __weak IBOutlet UICollectionView *_collectionView;
    NSIndexPath *_currentIndexPath;
    NSTimer *_timer;
}
@end

@implementation COSlidingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _setupUI];
}

#pragma mark - SetupUI
- (void)_setupUI {
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerNib:[UINib nibWithNibName:[COSlidingCell identifier] bundle:nil] forCellWithReuseIdentifier:[COSlidingCell identifier]];
}

#pragma mark - Setter, Getter
- (void)setArrayImage:(NSArray *)arrayImage {
    _arrayImage = arrayImage;
    [_collectionView reloadData];
    [self _scrollAutomatic];
}

#pragma mark - Pravite
- (void)_scrollAutomatic {
    if (self.arrayImage.count > 0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.85f target:self selector:@selector(_tick) userInfo:nil repeats:YES];
    }
}

- (void)_tick {
    BOOL animation = NO;
    if (!_currentIndexPath || _currentIndexPath.row == (self.arrayImage.count -1 )) {
        _currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    } else {
        animation = YES;
        _currentIndexPath = [NSIndexPath indexPathForRow:_currentIndexPath.row + 1 inSection:_currentIndexPath.section];
    }
    [self _collectionViewScrollToIndexPath:_currentIndexPath animated:animation];
}

- (void)_collectionViewScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:animated];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.arrayImage.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    COSlidingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[COSlidingCell identifier] forIndexPath:indexPath];
    cell.imageName = [self.arrayImage objectAtIndex:indexPath.row];
    _currentIndexPath = indexPath;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

@end
