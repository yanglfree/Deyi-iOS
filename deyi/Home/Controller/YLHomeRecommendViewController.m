//
//  YLHomeRecommendViewController.m
//  deyi
//
//  Created by Liang on 2018/8/15.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLHomeRecommendViewController.h"
#import "ZJScrollPageView.h"

@interface YLHomeRecommendViewController ()<ZJScrollPageViewChildVcDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, copy) NSArray *recommendListArr;

@end

@implementation YLHomeRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:tableview];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return _recommendListArr.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
