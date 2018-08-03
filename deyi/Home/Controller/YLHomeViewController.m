//
//  YLHomeViewController.m
//  deyi
//
//  Created by Liang on 2018/8/2.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeViewController.h"
#import "WSegmentView.h"
#import "SDCycleScrollView.h"

@interface YLHomeViewController ()
{
    WSegmentView *segmentView;
}

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *searchView;
@property(nonatomic, strong) SDCycleScrollView *sdCycleScrollView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UITableView *tableView;

@end

@implementation YLHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_user"] style:UIBarButtonItemStylePlain target:self action:@selector(gotoMy)];
        navItem.rightBarButtonItem = rightItem;
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_weather_sun"] style:UIBarButtonItemStylePlain target:self action:@selector(weather)];
        navItem.leftBarButtonItem = leftItem;
        segmentView = [[WSegmentView alloc] initWithFrame:CGRectMake(0, 0, 100, 30) titles:@[@"推荐",@"动态"] initSelected:YES];
        navItem.titleView = segmentView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
}

- (void)initSubview
{
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.searchView];
    [self.scrollView addSubview:self.sdCycleScrollView];
    [self.scrollView addSubview:self.collectionView];
    [self.scrollView addSubview:self.tableView];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 1000);
    }
    return _scrollView;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
    }
    return _searchView;
}



- (void)gotoMy
{
    
}

- (void)weather
{
    
}



@end
