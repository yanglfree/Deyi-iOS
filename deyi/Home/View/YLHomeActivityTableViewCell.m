//
//  YLHomeActivityTableViewCell.m
//  deyi
//
//  Created by Liang on 2018/8/16.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeActivityTableViewCell.h"
#import "YLHomeActivityCollectionViewCell.h"

// ksectionmargin 设置为kitemSpacing的两倍
static const CGFloat kSectionMargin =6.f;
static const CGFloat kRowNumber = 3.f;
static const CGFloat kHorizontalNumber = 1.f;
static const CGFloat kItemSpacing = 3.f;

@interface YLHomeActivityTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *allLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property(nonatomic, strong) UICollectionViewFlowLayout *layout;

@property(nonatomic, strong) ActivityModel *activityModel;

@end

@implementation YLHomeActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configCollectionView];
}

- (void)setActivityModel:(ActivityModel *)activityModel
{
    _activityModel = activityModel;
    [_collectionView reloadData];
    _pageControl.numberOfPages = ceilf(_activityModel.listArr.count / 3);
}

- (void)configCollectionView
{
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.minimumInteritemSpacing = 1;
    _layout.sectionInset = UIEdgeInsetsMake(kSectionMargin, kSectionMargin, kSectionMargin, kSectionMargin);
    _layout.itemSize = CGSizeMake((ScreenWidth - 6 * kSectionMargin) / kRowNumber, (_collectionView.height - 2 * kSectionMargin) / kHorizontalNumber);
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.collectionViewLayout = _layout;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLHomeActivityCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YLHomeActivityCollectionViewCell class])];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}

#pragma mark - uicollection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _activityModel.listArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityList *list = _activityModel.listArr[indexPath.row];
    YLHomeActivityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YLHomeActivityCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[YLHomeActivityCollectionViewCell alloc] init];
    }
    [cell setCellWithModel:list];
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = floorf((_collectionView.contentOffset.x + ScreenWidth * 0.5) / ScreenWidth);
}

@end
