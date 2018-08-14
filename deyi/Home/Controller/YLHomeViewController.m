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

@interface YLHomeViewController ()<UIScrollViewDelegate>
{
    
}

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) WSegmentView *segmentView;

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
        navItem.titleView = self.segmentView;
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
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-49);
    }];
}

- (WSegmentView *)segmentView
{
    if (!_segmentView) {
        _segmentView = [[WSegmentView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 75, 0, 150, 40) titles:@[@"推荐",@"动态"] initSelected:YES];
        _segmentView.normalBgColor = [UIColor whiteColor];
        _segmentView.selectedBgColor = [UIColor whiteColor];
        _segmentView.selectedTitleColor = [UIColor blackColor];
        _segmentView.normalTitleColor = UI_TEXT_DARK_GRAY;
        _segmentView.titleFont = [UIFont fontWithName:@"" size:14];
        _segmentView.showLine = YES;
    }
    return _segmentView;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)gotoMy
{
    
}

- (void)weather
{
    
}



@end
