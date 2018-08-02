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
#import <YYCategories/YYCategories.h>

@interface YLBaseTabBarController ()

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
                                     @{@"vc":@"YLHomeViewController",@"title":@"首页",@"simg":@"",@"usimg":@""},
                                     @{@"vc":@"YLBBSViewController",@"title":@"社区",@"simg":@"",@"usimg":@""},
                                     @{@"vc":@"YLTimelineViewController",@"title":@"凑热闹",@"simg":@"",@"usimg":@""},
                                     @{@"vc":@"YLStoreViewController",@"title":@"商城",@"simg":@"",@"usimg":@""},
                                     @{@"vc":@"YLMyViewController",@"title":@"我的",@"simg":@"",@"usimg":@""},
                                     ];
        
        for (NSDictionary *value in viewControllers) {
            UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:value[@"title"] image:value[@"usimg"] selectedImage:value[@"simg"]];
            
            UIViewController *vc = [[NSClassFromString(value[@"VC"]) alloc] init];
            vc.hidesBottomBarWhenPushed = NO;
            
            YLBaseNavgationViewController *nav = [[YLBaseNavgationViewController alloc] initWithRootViewController:vc];
            nav.tabBarItem = item;
            [nav.navigationBar setTranslucent:NO];
            nav.navigationBar setBackgroundImage:[UIImage imagewithColor:UI_MAIN_NAV_COLOR] forBarMetrics:<#(UIBarMetrics)#>
            
        }
    }
}


@end
