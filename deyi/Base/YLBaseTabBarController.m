//
//  YLBaseTabBarController.m
//  deyi
//
//  Created by Liang on 2018/8/2.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLBaseTabBarController.h"
#import "YLHomeViewController.h"
#import "YLBBSViewController.h"
#import "YLMyViewController.h"
#import "YLTimelineViewController.h"
#import "YLStoreViewController.h"
#import "YLBaseNavgationViewController.h"

@interface YLBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation YLBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray *vcs = [NSMutableArray array];
        NSArray *viewControllers = @[
                                     @{@"vc":@"YLHomeViewController",@"title":@"首页",@"simg":@"tab_home_select",@"usimg":@"tab_home"},
                                     @{@"vc":@"YLBBSViewController",@"title":@"社区",@"simg":@"tab_sq_select",@"usimg":@"tab_sq"},
                                     @{@"vc":@"YLTimelineViewController",@"title":@"凑热闹",@"simg":@"tab_cou_select",@"usimg":@"tab_cou"},
                                     @{@"vc":@"YLStoreViewController",@"title":@"商城",@"simg":@"tab_buy_select",@"usimg":@"tab_buy"},
                                     @{@"vc":@"YLMyViewController",@"title":@"我的",@"simg":@"tab_new_select",@"usimg":@"tab_new"},
                                     ];
        
        for (NSDictionary *value in viewControllers) {
            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:value[@"title"] image:[UIImage imageNamed:value[@"usimg"]] selectedImage:[UIImage imageNamed:value[@"simg"]]];
            
            UIViewController *vc = [[NSClassFromString(value[@"vc"]) alloc] init];
            vc.hidesBottomBarWhenPushed = NO;
            YLBaseNavgationViewController *nav = [[YLBaseNavgationViewController alloc] initWithRootViewController:vc];
            nav.tabBarItem = item;
            [nav.navigationBar setTranslucent:NO];
            [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
            [nav.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
            UIColor *color = [UIColor blackColor];
            NSDictionary *dict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],NSForegroundColorAttributeName:color};
            nav.navigationBar.titleTextAttributes = dict;
            [vcs addObject:nav];
        }
        self.viewControllers = vcs;
        self.tabBar.backgroundColor = UI_BG_DARK_GRAY;
        self.tabBar.shadowImage = [[UIImage alloc] init];
        self.tabBar.backgroundImage = [[UIImage alloc] init];
//        self.tabBar.tintColor = UI_MAIN_NAV_COLOR;
        self.delegate = self;
    }
    return self;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}


@end
