//
//  YLHomeTimeLineViewController.m
//  deyi
//
//  Created by Liang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeTimeLineViewController.h"
#import "ZJScrollPageView.h"

@interface YLHomeTimeLineViewController ()<ZJScrollPageViewChildVcDelegate>

@end

@implementation YLHomeTimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
