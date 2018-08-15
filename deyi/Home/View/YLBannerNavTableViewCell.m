//
//  YLBannerTableViewCell.m
//  deyi
//
//  Created by Michael Yang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLBannerNavTableViewCell.h"
#import "SDCycleScrollView.h"
#import "YLNavCollectionViewCell.h"

static CGFloat const COLLECTIONVIEW_CELL_HEIGHT = 60;

@interface YLBannerNavTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *sdCycleScrollView;
@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YLBannerNavTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self addSubview:self.sdCycleScrollView];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sdCycleScrollView.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(160);
    }];
}

- (SDCycleScrollView *)sdCycleScrollView
{
    if (!_sdCycleScrollView) {
        _sdCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _sdCycleScrollView.backgroundColor = [UIColor blueColor];
    }
    return _sdCycleScrollView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50 , COLLECTIONVIEW_CELL_HEIGHT);
        layout.minimumInteritemSpacing = 30;//item间距(最小值)
        layout.minimumLineSpacing = 20;//行间距(最小值)
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YLNavCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([YLNavCollectionViewCell class])];
    }
    return _collectionView;
}


#pragma mark - Collectionview delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.navArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_navArr || [_navArr count] <= 0) {
        return nil;
    }
    Nav *navModel = _navArr[indexPath.row];
    YLNavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YLNavCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[YLNavCollectionViewCell alloc] init];
    }
    [cell setNavModel:navModel];
    return cell;
}

- (void)setSDCycleScrollViewImages:(NSArray *)imagesURLStrings
{
    self.sdCycleScrollView.imageURLStringsGroup = imagesURLStrings;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.bannerImageClick) {
        self.bannerImageClick(_bannerArr[index].jumpto);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBannerArr:(NSArray *)bannerArr
{
    _bannerArr = bannerArr;
    [self setSDCycleScrollViewImages:[self bannerImagesURLString]];
}

- (void)setNavArr:(NSArray<Nav *> *)navArr
{
    _navArr = navArr;
    [self.collectionView reloadData];
}

- (NSArray *)bannerImagesURLString
{
    NSMutableArray *images = [NSMutableArray array];
    for (Banner *banner in self.bannerArr) {
        [images addObject:banner.pic];
    }
    return images;
}


@end
