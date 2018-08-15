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
#import "ZJScrollPageView.h"
#import "YLHomeRecommendViewController.h"
#import "YLHomeTimeLineViewController.h"

@interface YLHomeViewController ()<UIScrollViewDelegate,ZJScrollPageViewDelegate>
{
    
}

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) ZJScrollPageView *scrollPageView;
@property(nonatomic, copy) NSArray *titleArr;

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
        _titleArr = @[@"推荐",@"动态"];
        navItem.titleView = self.scrollPageView.segmentView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubview];
}

- (void)initSubview
{
    [self.view addSubview:self.scrollPageView];
    CGFloat navHeight = self.navigationController.navigationBar.height;
    CGFloat tabHeight = self.tabBarController.tabBar.height;
    [self.scrollPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(-navHeight);
        make.bottom.mas_equalTo(self.view).offset(-tabHeight);
    }];
}

- (ZJScrollPageView *)scrollPageView
{
    if (!_scrollPageView) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showLine = YES;
        style.selectedTitleColor = [UIColor blackColor];
        style.normalTitleColor = UI_TEXT_DARK_GRAY;
        _scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight - TAB_BAR_HEIGHT) segmentStyle:style titles:_titleArr parentViewController:self delegate:self];
        _scrollPageView.segmentView.frame = CGRectMake(ScreenWidth / 2 - 50, 0, 100, 40);
        _scrollPageView.backgroundColor = [UIColor yellowColor];
    }
    return _scrollPageView;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor yellowColor];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, ScreenHeight - 64 - 49);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

- (NSInteger)numberOfChildViewControllers
{
    return _titleArr.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        if (index == 0) {
            //推荐
            childVc = (UIViewController<ZJScrollPageViewChildVcDelegate> *)[[YLHomeRecommendViewController alloc] init];
        }else{
            //动态
            childVc = (UIViewController<ZJScrollPageViewChildVcDelegate> *)[[YLHomeTimeLineViewController alloc] init];
        }
    }
    return childVc;
}

- (void)gotoMy
{
    
}

- (void)weather
{
    
}

@end
