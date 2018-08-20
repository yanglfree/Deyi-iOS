//
//  YLBBSViewController.m
//  deyi
//
//  Created by Liang on 2018/8/2.
//  Copyright © 2018年 hipie. All rights reserved.
//

#import "YLBBSViewController.h"
#import "YLSectionModel.h"
#import "YLBBSSectionTableViewCell.h"

@interface YLBBSViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@property(nonatomic, copy) NSArray<YLSectionModel *> *sectionArr; //板块数组
@property(nonatomic, copy) NSArray<NSString *> *leftTitleArr;

@end

@implementation YLBBSViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _leftTitleArr = @[@"版块",@"热帖",@"新帖",@"红人"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"社区";
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _leftTableView.scrollEnabled = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _rightTableView.showsVerticalScrollIndicator = NO;
    [_rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YLBBSSectionTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([YLBBSSectionTableViewCell class])];
    
    [self initData];
}

- (void)initData
{
    WEAKSELF
    [[YLNetwork sharedNetwork] PostWithUrl:API_BBS_SECTION params:nil successHander:^(NSDictionary *response) {
        weakSelf.sectionArr = [NSArray yy_modelArrayWithClass:[YLSectionModel class] json:response[@"data"][@"list"]];
        [weakSelf.rightTableView reloadData];
    } failHander:^(NSError *error, NSInteger httpStatus, id response, NSString *msg) {
        
    }];
}

#pragma mark - tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftTableView) {
        return _leftTitleArr.count;
    }else{
        return _sectionArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == _rightTableView) {
        YLSectionModel *model = _sectionArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YLBBSSectionTableViewCell class])];
        if (!cell) {
            cell = [[YLBBSSectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([YLBBSSectionTableViewCell class])];
        }
        [cell setValue:model forKey:@"sectionModel"];
    }else{
        NSString *title = _leftTitleArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        }
        if (indexPath.row == 0) {
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }else{
            cell.backgroundColor = UIColorHex(0xf5f5f5);
            cell.textLabel.textColor = UIColorHex(0x686868);
        }
        cell.textLabel.font = [UIFont fontWithName:@"" size:14];
        cell.textLabel.text = title;
    }
    return cell;
    
}


@end
